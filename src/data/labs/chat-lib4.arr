use context dcic2024

import color from color
import color as C
include image
include csv
include data-source

provide:
  *,
  type *
end

#|
    chat-lib4.arr
    Biblioteca de apoio para o Laboratório 4 de INF05008 - Pensamento Computacional.
    Reúne as estruturas de dados e as funções desenvolvidas no Laboratório 3 (aplicativo de mensagens),
    além de carregar o histórico de mensagens de uma tabela online (CSV).

    Autor: Prof. Lucas N. Alegre
|#


#|
    Estruturas de dados do aplicativo de mensagens
|#

data Usuario:
  # Estrutura para representar um usuário (contato) do aplicativo
  | usuario(
      nome :: String,     # Nome do usuário
      avatar :: Image,    # Imagem de perfil do usuário
      online :: Boolean)  # true se o usuário está online, false caso contrário
end

data Mensagem:
  # Uma mensagem pode ser de texto puro ou uma imagem com legenda:
  | msg-texto(
      autor :: String,    # Nome de quem enviou a mensagem
      horario :: String,  # Horário de envio (ex: "09:00")
      texto :: String)    # Texto da mensagem
  | msg-imagem(
      autor :: String,    # Nome de quem enviou a mensagem
      horario :: String,  # Horário de envio (ex: "09:00")
      imagem :: Image,    # Imagem enviada
      legenda :: String)  # Legenda da imagem
end

data Chat:
  # Estrutura para representar uma conversa com um contato
  | chat(
      contato :: Usuario,           # Contato da conversa
      mensagens :: List<Mensagem>)  # Histórico de mensagens trocadas
end


#|
    Tabela online com o histórico de mensagens
|#

# URL do arquivo CSV com as mensagens
CHAT-URL = "https://cdn.jsdelivr.net/gh/lucasalegre/pensamento-computacional@main/src/data/labs/2026-2/chat.csv"

# Carregamento e sanitização da tabela de dados online
CHAT-DATA =
  load-table: id, remetente, horario, tipo, texto, url_imagem, legenda
    source: csv-table-url(CHAT-URL, default-options)
    sanitize id using num-sanitizer
    sanitize remetente using string-sanitizer
    sanitize horario using string-sanitizer
    sanitize tipo using string-sanitizer
    sanitize texto using string-sanitizer
    sanitize url_imagem using string-sanitizer
    sanitize legenda using string-sanitizer
  end

TOTAL-MENSAGENS-TABELA = CHAT-DATA.length()

IDS-MENSAGENS-TABELA = CHAT-DATA.get-column("id")


#|
    Funções auxiliares para consulta à tabela online
|#

fun linha-msg(id :: Number) -> Row:
  doc: "Dado o identificador de uma mensagem, devolve a linha correspondente na tabela CHAT-DATA."
  tab = filter-with(CHAT-DATA, lam(row): row["id"] == id end)
  tab.row-n(0)
end

fun tipo-msg(id :: Number) -> String:
  doc: "Dado o ID de uma mensagem, devolve o tipo dela (\"texto\" ou \"imagem\")."
  linha-msg(id)["tipo"]
end

fun autor-msg(id :: Number) -> String:
  doc: "Dado o ID de uma mensagem, devolve o remetente dela."
  linha-msg(id)["remetente"]
end

fun horario-msg(id :: Number) -> String:
  doc: "Dado o ID de uma mensagem, devolve o horário de envio."
  linha-msg(id)["horario"]
end

fun texto-msg(id :: Number) -> String:
  doc: "Dado o ID de uma mensagem, devolve o texto do conteúdo."
  linha-msg(id)["texto"]
end

fun imagem-msg(id :: Number) -> Image:
  doc: "Dado o ID de uma mensagem do tipo imagem, devolve a imagem carregada da internet e redimensionada."
  scale(0.35, image-url(linha-msg(id)["url_imagem"]))
end

fun legenda-msg(id :: Number) -> String:
  doc: "Dado o ID de uma mensagem do tipo imagem, devolve a legenda correspondente."
  linha-msg(id)["legenda"]
end


#|
    Funções para criação de avatares de contatos
|#

fun avatar-contato(nome :: String) -> Image:
  doc: "Dado o nome de um contato, gera um avatar circular colorido com a inicial do seu nome."
  letra = string-substring(nome, 0, 1)
  fundo = circle(20, "solid", "darkorchid")
  letra-img = text(letra, 18, "white")

  overlay(letra-img, fundo)
end


#|
    Constantes visuais para o layout do Chat
|#

LARGURA-CHAT = 440
LARGURA-BALAO = 260

COR-FUNDO-CHAT = "whitesmoke"
COR-BALAO-EU = "lightgreen"
COR-BALAO-OUTRO = "white"
COR-CABECALHO = "darkgreen"


#|
    Constantes de teste (Laboratório 3)
|#

CONTATO-ANA = usuario("Ana", avatar-contato("Ana"), true)
CONTATO-EU = usuario("Eu", avatar-contato("Eu"), true)

MSG-TESTE-1 = msg-texto("Ana", "09:00", "Oi! Tudo bem?")
MSG-TESTE-2 = msg-texto("Eu", "09:01", "Tudo ótimo!")
MSG-TESTE-3 = msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Exemplo de figura")

CHAT-TESTE = chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3])


#|
    Criação de mensagens e chats a partir da tabela online
|#

fun cria-msg-tabela(id :: Number) -> Mensagem:
  doc: "Dado o ID de uma mensagem na tabela chat.csv, consulta a tabela e constrói a estrutura Mensagem correspondente (msg-texto ou msg-imagem)."
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

# Chat longo com a Ana, contendo todas as mensagens da tabela online
CHAT-LONGO = chat(usuario("Ana", avatar-contato("Ana"), true), cria-historico-tabela(IDS-MENSAGENS-TABELA))


#|
    Funções desenvolvidas no Laboratório 3
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
  edita-mensagem(MSG-TESTE-3, "Nova legenda") is msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Nova legenda")
end

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
  edita-por-horario([list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3], "10:00", "Olá!") is [list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3]
end

fun edita-chat(c :: Chat, horario :: String, novo-texto :: String) -> Chat:
  doc: "Dado um chat, um horário e um novo texto, devolve um novo Chat com a mensagem enviada nesse horário editada."
  chat(c.contato, edita-por-horario(c.mensagens, horario, novo-texto))
where:
  edita-chat(CHAT-TESTE, "09:00", "Olá! Tudo bem?") is chat(CONTATO-ANA, [list: msg-texto("Ana", "09:00", "Olá! Tudo bem?"), MSG-TESTE-2, MSG-TESTE-3])
  edita-chat(CHAT-TESTE, "10:00", "Olá!") is CHAT-TESTE
end


#|
    Funções de desenho do Chat (Laboratório 3)
|#

fun desenha-avatar(u :: Usuario) -> Image:
  doc: "Dado um usuario, devolve a imagem do avatar com indicador de online (verde) ou offline (cinza)."
  indicador = if u.online:
    # Se o usuário está online, o indicador é verde
    circle(5, "solid", "limegreen")
  else:
    # Senão, o indicador é cinza
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
    # Mensagem de texto: verifica o autor
    | msg-texto(autor, horario, texto) => autor == "Eu"
    # Mensagem com imagem: verifica o autor
    | msg-imagem(autor, horario, img, legenda) => autor == "Eu"
  end
where:
  eh-minha-mensagem(MSG-TESTE-1) is false
  eh-minha-mensagem(MSG-TESTE-2) is true
end

fun desenha-autor(autor :: String) -> Image:
  doc: "Desenha o nome do autor da mensagem, ou uma imagem vazia se o autor for \"Eu\"."
  if autor == "Eu":
    # Mensagens próprias não mostram o nome do autor
    empty-image
  else:
    # Mensagens de outros contatos mostram o nome do autor
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
    # Mensagem de texto: desenha o texto
    | msg-texto(autor, horario, texto) =>
      empilha-conteudo(desenha-autor(autor), text(texto, 13, "black"), horario)
    # Mensagem com imagem: desenha a imagem com a legenda abaixo
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
    # Balão encostado à direita (mensagens próprias)
    overlay-align("right", "middle", beside(balao, margem), fundo-linha)
  else:
    # Balão encostado à esquerda (mensagens do contato)
    overlay-align("left", "middle", beside(margem, balao), fundo-linha)
  end
end

fun desenha-mensagem(m :: Mensagem) -> Image:
  doc: "Dada uma mensagem, gera a imagem do balão de conversa correspondente posicionado na linha do chat."
  minha = eh-minha-mensagem(m)
  cor-balao = if minha:
    # Mensagens próprias usam a cor de balão do usuário
    COR-BALAO-EU
  else:
    # Mensagens do contato usam a cor de balão do outro
    COR-BALAO-OUTRO
  end

  posiciona-balao(desenha-balao(desenha-conteudo(m), cor-balao), minha)
end

fun desenha-status(online :: Boolean) -> Image:
  doc: "Desenha o status do contato: \"online\" em verde claro ou \"offline\" em cinza claro."
  if online:
    # Contato online
    text("online", 11, "lightgreen")
  else:
    # Contato offline
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
  doc: "Dado um Chat, desenha a interface completa da conversa combinando cabeçalho e mensagens."
  above(
    desenha-cabecalho(c.contato),
    desenha-mensagens(c.mensagens))
end
