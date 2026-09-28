use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 3 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
# Importa funções e constantes da biblioteca de chat
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/chat-lib3.arr")


#| 
    Exercício 1: Modelando Usuários, Mensagens e Chat
|#

# 1.1 Definição das estruturas Usuario, Mensagem e Chat
data Usuario:
  | usuario(
      nome :: String,
      avatar :: Image,
      online :: Boolean)
end

data Mensagem:
  | msg-texto(
      autor :: String,
      horario :: String,
      texto :: String)
  | msg-imagem(
      autor :: String,
      horario :: String,
      imagem :: Image,
      legenda :: String)
end

data Chat:
  | chat(
      contato :: Usuario,
      mensagens :: List<Mensagem>)
end

# 1.2 Constantes de teste criadas manualmente para usar nos testes dos próximos exercícios:
CONTATO-ANA = usuario("Ana", circle(20, "solid", "purple"), true)
CONTATO-EU = usuario("Eu", circle(20, "solid", "forestgreen"), true)

MSG-TESTE-1 = msg-texto("Ana", "09:00", "Oi! Tudo bem?")
MSG-TESTE-2 = msg-texto("Eu", "09:01", "Tudo ótimo!")
MSG-TESTE-3 = msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Exemplo de figura")

CHAT-TESTE = chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3])


# As funções abaixo são usadas para criar uma constante (CHAT-LONGO, abaixo) a partir de uma tabela (csv)

fun cria-msg-tabela(id :: Number) -> Mensagem:
  doc: "Dado o ID de uma mensagem na tabela chat.csv, consulta a biblioteca e constrói a estrutura Mensagem correspondente (msg-texto ou msg-imagem)."
  if tipo-msg(id) == "texto":
    msg-texto(autor-msg(id), horario-msg(id), texto-msg(id))
  else:
    msg-imagem(autor-msg(id), horario-msg(id), imagem-msg(id), legenda-msg(id))
  end
end

fun cria-historico-tabela(ids :: List<Number>) -> List<Mensagem>:
  doc: "Dada uma lista de IDs de mensagens da tabela online, constrói recursivamente a lista de estruturas Mensagem correspondentes."
  cases (List<Number>) ids:
    | empty => empty
    | link(first, rest) => link(cria-msg-tabela(first), cria-historico-tabela(rest))
  end
end

# Constante com o chat longo contendo as 20 mensagens da tabela:
CHAT-LONGO = chat(usuario("Ana", avatar-contato("Ana"), true), cria-historico-tabela(IDS-MENSAGENS-TABELA))


#| 
    Exercício 2: Editando uma Mensagem
|#

fun edita-mensagem(m :: Mensagem, novo-texto :: String) -> Mensagem:
  doc: "Dada uma mensagem e um novo texto, devolve uma nova mensagem com o texto atualizado (se msg-texto) ou a legenda atualizada (se msg-imagem)."
  cases (Mensagem) m:
    # Se for mensagem de texto: atualiza o campo texto
    | msg-texto(autor, horario, texto) =>
      msg-texto(autor, horario, novo-texto)
    # Se for mensagem com imagem: atualiza o campo legenda
    | msg-imagem(autor, horario, img, legenda) =>
      msg-imagem(autor, horario, img, novo-texto)
  end
where:
  edita-mensagem(MSG-TESTE-1, "Olá! Tudo bem?") is msg-texto("Ana", "09:00", "Olá! Tudo bem?")
  edita-mensagem(MSG-TESTE-2, "Tudo certo!") is msg-texto("Eu", "09:01", "Tudo certo!")
  edita-mensagem(MSG-TESTE-3, "Nova legenda") is msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Nova legenda")
end


#| 
    Exercício 3: Adicionando uma Mensagem em um Chat
|#

fun adiciona-no-fim(lista :: List<Mensagem>, m :: Mensagem) -> List<Mensagem>:
  doc: "Adiciona uma mensagem m no final de uma lista de mensagens."
  cases (List<Mensagem>) lista:
    # Caso base: Se a lista for vazia, a nova lista contém apenas m
    | empty => [list: m]
    # Caso recursivo: Mantém o primeiro e adiciona m no final do restante da lista
    | link(first, rest) => link(first, adiciona-no-fim(rest, m))
  end
where:
  adiciona-no-fim(empty, MSG-TESTE-1) is [list: MSG-TESTE-1]
  adiciona-no-fim([list: MSG-TESTE-1], MSG-TESTE-2) is [list: MSG-TESTE-1, MSG-TESTE-2]
end

fun adiciona-mensagem(c :: Chat, m :: Mensagem) -> Chat:
  doc: "Recebe um chat e uma nova mensagem m, e devolve um novo Chat com a mensagem adicionada ao final do histórico."
  chat(c.contato, adiciona-no-fim(c.mensagens, m))
where:
  adiciona-mensagem(chat(CONTATO-ANA, empty), MSG-TESTE-1) is chat(CONTATO-ANA, [list: MSG-TESTE-1])
  adiciona-mensagem(chat(CONTATO-ANA, [list: MSG-TESTE-1]), MSG-TESTE-2) is chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-2])
end


#| 
    Exercício 4: Editando uma Mensagem do Chat
|#

fun edita-por-horario(mensagens :: List<Mensagem>, horario :: String, novo-texto :: String) -> List<Mensagem>:
  doc: "Dada uma lista de mensagens, um horário e um novo texto, devolve a lista com a mensagem enviada nesse horário editada para o novo texto."
  cases (List<Mensagem>) mensagens:
    # Caso base: Lista vazia não possui mensagens para editar
    | empty => empty
    # Caso recursivo: Verifica se a primeira mensagem foi enviada no horário procurado
    | link(first, rest) =>
      if first.horario == horario:
        # Se o horário for igual, edita a primeira mensagem
        link(
          edita-mensagem(first, novo-texto), 
          edita-por-horario(rest, horario, novo-texto))
      else:
        # Senão, mantém a primeira mensagem como está
        link(first, edita-por-horario(rest, horario, novo-texto))
      end
  end
where:
  edita-por-horario(empty, "09:00", "Olá!") is empty
  edita-por-horario([list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3], "09:01", "Tudo certo!") is [list: MSG-TESTE-1, msg-texto("Eu", "09:01", "Tudo certo!"), MSG-TESTE-3]
  edita-por-horario([list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3], "09:02", "Nova legenda") is [list: MSG-TESTE-1, MSG-TESTE-2, msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Nova legenda")]
  edita-por-horario([list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3], "10:00", "Olá!") is [list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3]
end

fun edita-chat(c :: Chat, horario :: String, novo-texto :: String) -> Chat:
  doc: "Dado um chat, um horário e um novo texto, devolve um novo Chat com a mensagem enviada nesse horário editada."
  chat(c.contato, edita-por-horario(c.mensagens, horario, novo-texto))
where:
  edita-chat(CHAT-TESTE, "09:00", "Olá! Tudo bem?") is chat(CONTATO-ANA, [list: msg-texto("Ana", "09:00", "Olá! Tudo bem?"), MSG-TESTE-2, MSG-TESTE-3])
  edita-chat(CHAT-TESTE, "09:02", "Nova legenda") is chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-2, msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Nova legenda")])
  edita-chat(CHAT-TESTE, "10:00", "Olá!") is CHAT-TESTE
end


#| 
    Exercício 5: Desenhando um Chat
|#

# --- Funções gráficas auxiliares (fornecidas) ---

fun desenha-avatar(u :: Usuario) -> Image:
  doc: "Dado um usuario, devolve a imagem do avatar com indicador de online (verde) ou offline (cinza)."
  indicador = if u.online: 
    circle(5, "solid", "limegreen") 
  else: 
    circle(5, "solid", "gray") 
  end

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
  above-align("left", txt-autor, above-align("left", conteudo, text(horario, 10, "gray")))
end

fun desenha-conteudo(m :: Mensagem) -> Image:
  doc: "Dada uma mensagem, desenha o que vai dentro do balão: autor, texto (ou imagem com legenda) e horário."
  cases (Mensagem) m:
    | msg-texto(autor, horario, texto) =>
      empilha-conteudo(desenha-autor(autor), text(texto, 13, "black"), horario)
    | msg-imagem(autor, horario, img, legenda) =>
      empilha-conteudo(desenha-autor(autor), above-align("left", img, text(legenda, 12, "black")), horario)
  end
end

fun desenha-balao(conteudo :: Image, cor :: String) -> Image:
  doc: "Dado o conteúdo de uma mensagem e uma cor de fundo, desenha o balão com margem interna e borda cinza."
  largura = num-max(image-width(conteudo) + 16, 80)
  altura = image-height(conteudo) + 12
  fundo = rectangle(largura, altura, "solid", cor)
  borda = rectangle(largura, altura, "outline", "lightgray")
  conteudo-com-margem = beside(espaco(8, cor), conteudo)

  overlay-align("middle", "middle", borda, overlay-align("left", "middle", conteudo-com-margem, fundo))
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

  posiciona-balao(desenha-balao(desenha-conteudo(m), cor-balao), minha)
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
  above-align("left", 
    text(u.nome, 16, "white"), 
    desenha-status(u.online))
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
  cases (List<Mensagem>) mensagens:
    # Caso base: Se a lista for vazia, devolve imagem vazia
    | empty => empty-image
    # Passo recursivo: Posiciona o desenho da primeira mensagem acima do restante das mensagens
    | link(first, rest) => 
        above(
          desenha-mensagem(first), 
          desenha-mensagens(rest))
  end
end

fun desenha-chat(c :: Chat) -> Image:
  doc: "Dado um Chat, desenha a interface completa da conversa combinando cabecalho e mensagens."
  above(
    desenha-cabecalho(c.contato), 
    desenha-mensagens(c.mensagens))
end


# Visualizando o chat longo completo:
desenha-chat(CHAT-LONGO)
