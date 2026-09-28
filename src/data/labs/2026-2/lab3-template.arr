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
# Dica: Use a função avatar-contato :: String -> Image da biblioteca para criar o avatar de seus contatos
# CONTATO-ANA = ...
# CONTATO-EU = ...
# MSG-TESTE-1 = ...
# MSG-TESTE-2 = ...
# MSG-TESTE-3 = ...
# CHAT-TESTE = ...


# As funções abaixo são usadas para criar uma constante (CHAT-LONGO, abaixo) a partir de uma tabela (csv)

fun cria-msg-tabela(id :: Number) -> Mensagem:
  doc: "Dado o ID de uma mensagem na tabela chat.csv, consulta a biblioteca e constrói a estrutura Mensagem correspondente (msg-texto ou msg-imagem)."
  if tipo-msg(id) == "texto":
    # Se o tipo da mensagem for texto, constrói a variante msg-texto
    msg-texto(autor-msg(id), horario-msg(id), texto-msg(id))
  else:
    # Caso contrário (imagem), constrói a variante msg-imagem
    msg-imagem(autor-msg(id), horario-msg(id), imagem-msg(id), legenda-msg(id))
  end
end

fun cria-historico-tabela(ids :: List<Number>) -> List<Mensagem>:
  doc: "Dada uma lista de IDs de mensagens da tabela online, constrói recursivamente a lista de estruturas Mensagem correspondentes."
  cases (List<Number>) ids:
    # Caso base: Uma lista vazia de IDs resulta em um histórico vazio de mensagens
    | empty => empty
    # Caso recursivo: Converte o primeiro ID em Mensagem e adiciona ao histórico do restante da lista
    | link(first, rest) => link(cria-msg-tabela(first), cria-historico-tabela(rest))
  end
end

# Constante com um chat longo lido de uma tabela:
# Descomente a linha abaixo ao finalziar o exercício 1
# CHAT-LONGO = chat(usuario("Ana", avatar-contato("Ana"), true), cria-historico-tabela(IDS-MENSAGENS-TABELA))


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
    Exercício 4: Editando uma Mensagem do Chat
|#

fun edita-por-horario():
  doc: "Dada uma lista de mensagens, um horário e um novo texto, devolve a lista com a mensagem enviada nesse horário editada para o novo texto."
  # Se a lista for vazia, então [...]
  # Senão:

  empty
where:
  true is true
end

fun edita-chat():
  doc: "Dado um chat, um horário e um novo texto, devolve um novo Chat com a mensagem enviada nesse horário editada."
  # Complete!
  0
where:
  true is true
end

# Teste sua edição no CHAT-LONGO:
# edita-chat(CHAT-LONGO, "09:01", "Bom dia Ana! Tudo ótimo e você?")
# edita-chat(CHAT-LONGO, "09:05", "Saudades do Lab 1 de Truco!")


#| 
    Exercício 5: Desenhando um Chat
|#

# --- Funções gráficas auxiliares (fornecidas prontas) ---

fun desenha-avatar(u :: Usuario) -> Image:
  doc: "Dado um usuario, devolve a imagem do avatar com indicador de online (verde) ou offline (cinza)."
  indicador = if u.online: circle(5, "solid", "limegreen") else: circle(5, "solid", "gray") end

  overlay-align("right", "bottom", indicador, u.avatar)
end

fun espaco(largura :: Number, cor :: String) -> Image:
  doc: "Devolve um retângulo de altura 1 usado como espaçamento horizontal."
  rectangle(largura, 1, "solid", cor)
end

fun eh-minha-mensagem(m :: Mensagem) -> Boolean:
  doc: "Devolve true se a mensagem foi enviada pelo próprio usuário (autor \"Eu\")."
  cases (Mensagem) m:
    | msg-texto(autor, horario, texto) => autor == "Eu"
    | msg-imagem(autor, horario, img, legenda) => autor == "Eu"
  end
end

fun desenha-autor(autor :: String) -> Image:
  doc: "Desenha o nome do autor da mensagem, ou uma imagem vazia se o autor for \"Eu\"."
  if autor == "Eu":
    empty-image
  else:
    text(autor, 11, "darkgreen")
  end
end

fun empilha-conteudo(txt-autor :: Image, conteudo :: Image, horario :: String) -> Image:
  doc: "Empilha o autor, o conteúdo e o horário da mensagem, alinhados à esquerda."
  above-align("left", 
    txt-autor, 
    above-align("left", 
      conteudo, 
      text(horario, 10, "gray")))
end

fun desenha-conteudo(m :: Mensagem) -> Image:
  doc: "Dada uma mensagem, desenha o que vai dentro do balão: autor, texto (ou imagem com legenda) e horário."
  cases (Mensagem) m:
    | msg-texto(autor, horario, texto) =>
      empilha-conteudo(
        desenha-autor(autor), 
        text(texto, 13, "black"), 
        horario)
    | msg-imagem(autor, horario, img, legenda) =>
      empilha-conteudo(
        desenha-autor(autor), 
        above-align("left", 
          img, 
          text(legenda, 12, "black")),
        horario)
  end
end

fun desenha-balao(conteudo :: Image, cor :: String) -> Image:
  doc: "Dado o conteúdo de uma mensagem e uma cor de fundo, desenha o balão com margem interna e borda cinza."
  largura = num-max(image-width(conteudo) + 16, 80)
  altura = image-height(conteudo) + 12
  fundo = rectangle(largura, altura, "solid", cor)
  borda = rectangle(largura, altura, "outline", "lightgray")
  conteudo-com-margem = beside(espaco(8, cor), conteudo)

  overlay-align("middle", "middle", 
    borda, 
    overlay-align("left", "middle", conteudo-com-margem, fundo))
end

fun posiciona-balao(balao :: Image, a-direita :: Boolean) -> Image:
  doc: "Posiciona o balão na linha do chat, encostado à direita ou à esquerda, com margem de 10 pixels."
  fundo-linha = rectangle(LARGURA-CHAT, image-height(balao) + 8, "solid", COR-FUNDO-CHAT)
  margem = espaco(10, COR-FUNDO-CHAT)

  if a-direita:
    overlay-align("right", "middle", beside(balao, margem), fundo-linha)
  else:
    overlay-align("left", "middle", beside(margem, balao), fundo-linha)
  end
end

fun desenha-mensagem(m :: Mensagem) -> Image:
  doc: "Dada uma mensagem, gera a imagem do balão de conversa correspondente posicionado na linha do chat."
  minha = eh-minha-mensagem(m)
  cor-balao = if minha: COR-BALAO-EU else: COR-BALAO-OUTRO end

  posiciona-balao(
    desenha-balao(
      desenha-conteudo(m),
      cor-balao), 
    minha)
end

fun desenha-status(online :: Boolean) -> Image:
  doc: "Desenha o status do contato: \"online\" em verde claro ou \"offline\" em cinza claro."
  if online:
    text("online", 11, "lightgreen")
  else:
    text("offline", 11, "lightgray")
  end
end

fun desenha-info-contato(u :: Usuario) -> Image:
  doc: "Desenha o nome do contato com o status logo abaixo."
  above-align("left", text(u.nome, 16, "white"), desenha-status(u.online))
end

fun desenha-cabecalho(u :: Usuario) -> Image:
  doc: "Dado um usuario de contato, desenha a barra superior verde escura do chat."
  barra = rectangle(LARGURA-CHAT, 55, "solid", COR-CABECALHO)
  conteudo = beside-align("middle", desenha-avatar(u), beside(espaco(10, COR-CABECALHO), desenha-info-contato(u)))

  overlay-align("left", "middle", 
    beside(espaco(15, COR-CABECALHO), conteudo),
    barra)
end

# --- Implementação do aluno ---

fun desenha-mensagens(mensagens :: List<Mensagem>) -> Image:
  doc: "Dada uma lista de mensagens, devolve uma imagem com todas as mensagens empilhadas verticalmente."
  
  empty-image
end

fun desenha-chat(c :: Chat) -> Image:
  doc: "Dado um Chat, desenha a interface completa da conversa combinando cabecalho e mensagens."
  
  # Complete usando desenha-cabecalho e desenha-mensagens!
  empty-image
end

# Descomente para visualizar seus chats montados:
# desenha-chat(CHAT-LONGO)
