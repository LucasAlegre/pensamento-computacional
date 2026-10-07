use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 4 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
# Importa as estruturas, funções e constantes da biblioteca de chat (incluindo o que foi desenvolvido no Laboratório 3)
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/chat-lib4.arr")


#|
    Constantes (fornecidas prontas)
|#

# Chat curto com a Ana, contendo as 6 primeiras mensagens da tabela online:
CHAT-CURTO = chat(usuario("Ana", avatar-contato("Ana"), true), cria-historico-tabela([list: 1, 2, 3, 4, 5, 6]))

desenha-chat(CHAT-CURTO)


#|
    Exercício 1: Filter
|#

fun eh-do-autor(m :: Mensagem, autor :: String) -> Boolean:
  doc: "Dada uma mensagem e o nome de um autor, devolve true se a mensagem foi enviada por este autor e false caso contrário."
  m.autor == autor
where:
  eh-do-autor(MSG-TESTE-1, "Ana") is true
  eh-do-autor(MSG-TESTE-2, "Ana") is false
  eh-do-autor(MSG-TESTE-3, "Ana") is true
end

fun my-filter(f :: (Mensagem -> Boolean), l :: List<Mensagem>) -> List<Mensagem>:
  doc: "Dada uma função de critério (que recebe uma mensagem e devolve um booleano) e uma lista de mensagens, devolve uma nova lista com apenas as mensagens para as quais o critério devolve true."
  cases (List<Mensagem>) l:
    # Caso base: Se a lista for vazia, não há mensagens para filtrar
    | empty => empty
    # Caso recursivo: Verifica se a primeira mensagem satisfaz o critério
    | link(first, rest) =>
      if f(first):
        # Se satisfaz, mantém a primeira mensagem e filtra o restante da lista
        link(first, my-filter(f, rest))
      else:
        # Senão, descarta a primeira mensagem e filtra o restante da lista
        my-filter(f, rest)
      end
  end
where:
  my-filter(lam(m): true end, CHAT-TESTE.mensagens) is CHAT-TESTE.mensagens
  my-filter(lam(m): eh-do-autor(m, "Eu") end, CHAT-TESTE.mensagens) is [list: MSG-TESTE-2]
  my-filter(is-msg-imagem, CHAT-TESTE.mensagens) is [list: MSG-TESTE-3]
end

fun filtra-autor(c :: Chat, autor :: String) -> Chat:
  doc: "Dado um chat e o nome de um autor, devolve um novo Chat com o mesmo contato e apenas as mensagens enviadas por este autor."
  chat(c.contato, my-filter(lam(m): eh-do-autor(m, autor) end, c.mensagens))
where:
  filtra-autor(CHAT-TESTE, "Eu") is chat(CONTATO-ANA, [list: MSG-TESTE-2])
  filtra-autor(CHAT-TESTE, "Ana") is chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-3])
  filtra-autor(CHAT-TESTE, "Bia") is chat(CONTATO-ANA, empty)
end

desenha-chat(filtra-autor(CHAT-LONGO, "Ana"))


#|
    Exercício 2: Map
|#

fun my-map(f :: (Mensagem -> Any), l :: List<Mensagem>) -> List<Any>:
  doc: "Dada uma função (que recebe uma mensagem e devolve um valor qualquer) e uma lista de mensagens, devolve uma nova lista com o resultado da aplicação da função a cada mensagem."
  cases (List<Mensagem>) l:
    # Caso base: Se a lista for vazia, não há mensagens para transformar
    | empty => empty
    # Caso recursivo: Aplica a função à primeira mensagem e junta com o restante da lista transformada
    | link(first, rest) =>
      link(
        f(first),
        my-map(f, rest))
  end
where:
  my-map(is-msg-texto, CHAT-TESTE.mensagens) is [list: true, true, false]
  my-map(lam(m): m.horario end, CHAT-TESTE.mensagens) is [list: "09:00", "09:01", "09:02"]
  my-map(lam(m): edita-mensagem(m, "Oi!") end, [list: MSG-TESTE-2]) is [list: msg-texto("Eu", "09:01", "Oi!")]
  my-map(lam(m): m.autor end, empty) is empty
end

my-map(lam(m): m.autor end, CHAT-LONGO.mensagens)


#|
    Exercício 3: Fold
|#

fun my-fold<T>(f :: (T, T -> T), acc :: T, l :: List<T>) -> T:
  doc: "Dada uma função (que recebe dois valores do tipo T e devolve um valor do tipo T), um valor inicial para o acumulador e uma lista, devolve o resultado de aplicar a função sequencialmente ao acumulador e a cada elemento da lista."
  cases (List<T>) l:
    # Caso base: Se a lista for vazia, devolve o acumulador
    | empty => acc
    # Caso recursivo: Combina o acumulador com o primeiro elemento e continua com o restante da lista
    | link(first, rest) => my-fold(f, f(acc, first), rest)
  end
where:
  my-fold(lam(a, b): a + b end, 0, [list: 1, 2, 3, 4, 5]) is 15
  my-fold(lam(a, b): a * b end, 1, [list: 1, 2, 3]) is 6
  my-fold(string-append, "", [list: "Oi", "! ", "Tudo bem?"]) is "Oi! Tudo bem?"
end

fun total-caracteres(c :: Chat) -> Number:
  doc: "Dado um chat, devolve a quantidade total de caracteres dos textos das mensagens de texto (msg-texto) do chat."
  # Passo 1 (filter): seleciona apenas as mensagens de texto do chat
  mensagens-texto = my-filter(is-msg-texto, c.mensagens)

  # Passo 2 (map): transforma cada mensagem de texto na quantidade de caracteres do seu texto
  tamanhos = my-map(lam(m): string-length(m.texto) end, mensagens-texto)

  # Passo 3 (fold): soma todas as quantidades de caracteres
  my-fold(lam(a, b): a + b end, 0, tamanhos)
where:
  # CHAT-TESTE tem 2 mensagens de texto: "Oi! Tudo bem?" (13 caracteres) e "Tudo ótimo!" (11 caracteres)
  total-caracteres(CHAT-TESTE) is 24
  # Um chat sem mensagens de texto tem 0 caracteres
  total-caracteres(chat(CONTATO-ANA, [list: MSG-TESTE-3])) is 0
  total-caracteres(chat(CONTATO-ANA, empty)) is 0
end

fun galeria-imagens(c :: Chat) -> Image:
  doc: "Dado um chat, gera uma imagem com todas as imagens enviadas no chat (msg-imagem), dispostas lado a lado."
  # Passo 1 (filter): seleciona apenas as mensagens com imagem
  mensagens-imagem = my-filter(is-msg-imagem, c.mensagens)

  # Passo 2 (map): transforma cada mensagem com imagem na própria imagem enviada
  imagens = my-map(lam(m): m.imagem end, mensagens-imagem)

  # Passo 3 (fold): junta as imagens lado a lado
  my-fold(beside, empty-image, imagens)
end

total-caracteres(CHAT-LONGO)
galeria-imagens(CHAT-LONGO)
