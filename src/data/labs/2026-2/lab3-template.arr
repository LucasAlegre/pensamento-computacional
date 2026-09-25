use context dcic2024

#|
    Este arquivo contém o template para a solução dos exercícios do Laboratório 3 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
# Importa funções e constantes da biblioteca de chat
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/chat-lib3.arr")


#| 
    Exercício 1: Modelando Usuários, Mensagens e Chat
|#

# 1.1 Defina a estrutura Usuario (com campos nome, avatar e online)
data Usuario:
  # Complete!
end

# 1.2 Defina a estrutura Mensagem com suas duas variantes (msg-texto e msg-imagem)
data Mensagem:
  # Complete!
end

# 1.3 Defina a estrutura Chat (com campos contato e mensagens)
data Chat:
  # Complete!
end

# 1.4 Crie manualmente as constantes de teste para usar nas verificações dos próximos exercícios:
# (Crie pelo menos 2 contatos, 3 mensagens e 1 chat)
# CONTATO-ANA = ...
# CONTATO-EU = ...
# MSG-TESTE-1 = ...
# MSG-TESTE-2 = ...
# MSG-TESTE-3 = ...
# CHAT-TESTE = ...


#|
    Carregamento do Chat Longo da Tabela Online (Código fornecido)
    O código abaixo lê a tabela online através da biblioteca e constrói
    um Chat longo com 20 mensagens reais trocadas entre Ana e Eu.
|#

fun cria-msg-tabela(id :: Number) -> Mensagem:
  if tipo-msg(id) == "texto":
    msg-texto(autor-msg(id), horario-msg(id), texto-msg(id))
  else:
    msg-imagem(autor-msg(id), horario-msg(id), imagem-msg(id), legenda-msg(id))
  end
end

fun cria-historico-tabela(ids :: List<Number>) -> List<Mensagem>:
  cases (List<Number>) ids:
    | empty => empty
    | link(first, rest) => link(cria-msg-tabela(first), cria-historico-tabela(rest))
  end
end

# Constante com o chat longo contendo as 20 mensagens da tabela online:
CHAT-LONGO = chat(usuario("Ana", avatar-contato("Ana"), status-contato("Ana")), cria-historico-tabela(IDS-MENSAGENS-TABELA))


#| 
    Exercício 2: Editando uma Mensagem
|#

fun edita-mensagem(m :: Mensagem, novo-texto :: String) -> Mensagem:
  doc: "Dada uma mensagem e um novo texto, devolve uma nova mensagem com o texto atualizado (se msg-texto) ou a legenda atualizada (se msg-imagem)."
  # Complete usando cases (Mensagem)!
  m
where:
  true is true
end


#| 
    Exercício 3: Adicionando uma Mensagem em um Chat
|#

fun adiciona-no-fim(lista :: List<Mensagem>, m :: Mensagem) -> List<Mensagem>:
  doc: "Adiciona uma mensagem m no final de uma lista de mensagens."
  # Se a lista for vazia, então [...]
  # Senão:
      # [manter primeiro elemento]
      # [adicionar m recursivamente no resto da lista]
  empty
where:
  true is true
end

fun adiciona-mensagem(c :: Chat, m :: Mensagem) -> Chat:
  doc: "Recebe um chat e uma nova mensagem m, e devolve um novo Chat com a mensagem adicionada ao final do histórico."
  # Complete!
  c
where:
  true is true
end


#| 
    Exercício 4: Filtrando um Chat
|#

fun filtra-mensagens-autor(mensagens :: List<Mensagem>, autor :: String) -> List<Mensagem>:
  doc: "Dada uma lista de mensagens e um autor, devolve uma lista contendo apenas as mensagens enviadas por esse autor."
  # Se a lista for vazia, então [...]
  # Senão:
      # [verificar se o autor da primeira mensagem é igual a autor]
      # [combinar com a chamada recursiva para o resto da lista]
  empty
where:
  true is true
end

fun filtra-chat(c :: Chat, autor :: String) -> Chat:
  doc: "Dado um chat e o nome de um autor, devolve um novo Chat contendo apenas as mensagens desse autor."
  # Complete!
  c
where:
  true is true
end

# Teste seu filtro no CHAT-LONGO para inspecionar mensagens:
# filtra-chat(CHAT-LONGO, "Ana")
# filtra-chat(CHAT-LONGO, "Eu")


#| 
    Exercício 5: Desenhando um Chat
|#

# --- Funções gráficas auxiliares (fornecidas prontas) ---

fun desenha-avatar(u :: Usuario) -> Image:
  doc: "Dado um usuario, devolve a imagem do avatar com indicador de online (verde) ou offline (cinza)."
  indicador = if u.online: circle(5, "solid", "limegreen") else: circle(5, "solid", "gray") end
  overlay-align("right", "bottom", indicador, u.avatar)
end

fun desenha-mensagem(m :: Mensagem) -> Image:
  doc: "Dada uma mensagem, gera a imagem do balão de conversa correspondente."
  is-eu = cases (Mensagem) m:
    | msg-texto(a, h, t) => a == "Eu"
    | msg-imagem(a, h, img, leg) => a == "Eu"
  end
  cor-balao = if is-eu: COR-BALAO-EU else: COR-BALAO-OUTRO end
  alinhamento = if is-eu: "right" else: "left" end

  cases (Mensagem) m:
    | msg-texto(autor, horario, texto) =>
      txt-conteudo = text(texto, 13, "black")
      txt-hora = text(horario, 10, "gray")
      txt-autor = if is-eu: empty-image else: text(autor, 11, "darkgreen") end
      
      conteudo-balao = above-align("left", txt-autor, above-align("left", txt-conteudo, txt-hora))
      largura-conteudo = image-width(conteudo-balao) + 16
      altura-conteudo = image-height(conteudo-balao) + 12
      
      fundo-balao = rectangle(num-max(largura-conteudo, 80), altura-conteudo, "solid", cor-balao)
      borda-balao = rectangle(num-max(largura-conteudo, 80), altura-conteudo, "outline", "lightgray")
      balao = overlay(borda-balao, overlay-align("center", "center", conteudo-balao, fundo-balao))
      
      linha = rectangle(LARGURA-CHAT, altura-conteudo + 8, "solid", "transparent")
      overlay-align(alinhamento, "middle", balao, linha)

    | msg-imagem(autor, horario, img, legenda) =>
      txt-autor = if is-eu: empty-image else: text(autor, 11, "darkgreen") end
      txt-legenda = text(legenda, 12, "black")
      txt-hora = text(horario, 10, "gray")
      
      conteudo-balao = above-align("left", txt-autor, above-align("left", img, above-align("left", txt-legenda, txt-hora)))
      largura-conteudo = image-width(conteudo-balao) + 16
      altura-conteudo = image-height(conteudo-balao) + 12
      
      fundo-balao = rectangle(largura-conteudo, altura-conteudo, "solid", cor-balao)
      borda-balao = rectangle(largura-conteudo, altura-conteudo, "outline", "lightgray")
      balao = overlay(borda-balao, overlay-align("center", "center", conteudo-balao, fundo-balao))
      
      linha = rectangle(LARGURA-CHAT, altura-conteudo + 8, "solid", "transparent")
      overlay-align(alinhamento, "middle", balao, linha)
  end
end

fun desenha-cabecalho(u :: Usuario) -> Image:
  doc: "Dado um usuario de contato, desenha a barra superior verde escura do chat."
  barra = rectangle(LARGURA-CHAT, 55, "solid", COR-CABECALHO)
  avatar-img = desenha-avatar(u)
  txt-nome = text(u.nome, 16, "white")
  txt-status = text(if u.online: "online" else: "offline" end, 11, if u.online: "lightgreen" else: "lightgray" end)
  info-contato = above-align("left", txt-nome, txt-status)
  cabecalho-conteudo = beside-align("center", avatar-img, beside-align("center", rectangle(10, 1, "solid", "transparent"), info-contato))
  overlay-align("left", "center", beside(rectangle(12, 1, "solid", "transparent"), cabecalho-conteudo), barra)
end

# --- Implementação do aluno ---

fun desenha-mensagens(mensagens :: List<Mensagem>) -> Image:
  doc: "Dada uma lista de mensagens, devolve uma imagem com todas as mensagens empilhadas verticalmente."
  # Caso base: Se a lista for vazia, devolve imagem vazia
  # Passo recursivo: Posiciona o desenho da primeira mensagem acima do restante das mensagens
  empty-image
end

fun desenha-chat(c :: Chat) -> Image:
  doc: "Dado um Chat, desenha a interface completa da conversa."
  # Complete usando desenha-cabecalho e desenha-mensagens!
  empty-image
end

# Descomente para visualizar seus chats montados:
# desenha-chat(CHAT-TESTE)
# desenha-chat(CHAT-LONGO)
# desenha-chat(filtra-chat(CHAT-LONGO, "Ana"))
