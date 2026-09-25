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


#|
    Carregamento do Chat Longo da Tabela Online (Código fornecido)
    Lê a tabela online de 20 mensagens reais e cria a constante CHAT-LONGO.
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
    # Caso recursivo: Mantém o primeiro e adiciona m no final do restante
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
    Exercício 4: Filtrando um Chat
|#

fun filtra-mensagens-autor(mensagens :: List<Mensagem>, autor :: String) -> List<Mensagem>:
  doc: "Dada uma lista de mensagens e um autor, devolve uma lista contendo apenas as mensagens enviadas por esse autor."
  cases (List<Mensagem>) mensagens:
    # Caso base: Lista vazia não possui mensagens
    | empty => empty
    # Caso recursivo: Verifica se o primeiro elemento foi enviado pelo autor procurado
    | link(first, rest) =>
      autor-da-msg = cases (Mensagem) first:
        | msg-texto(a, h, t) => a
        | msg-imagem(a, h, img, leg) => a
      end
      if autor-da-msg == autor:
        link(first, filtra-mensagens-autor(rest, autor))
      else:
        filtra-mensagens-autor(rest, autor)
      end
  end
where:
  filtra-mensagens-autor(empty, "Ana") is empty
  filtra-mensagens-autor([list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3], "Ana") is [list: MSG-TESTE-1, MSG-TESTE-3]
  filtra-mensagens-autor([list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3], "Eu") is [list: MSG-TESTE-2]
  filtra-mensagens-autor([list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3], "Lucas") is empty
end

fun filtra-chat(c :: Chat, autor :: String) -> Chat:
  doc: "Dado um chat e o nome de um autor, devolve um novo Chat contendo apenas as mensagens desse autor."
  chat(c.contato, filtra-mensagens-autor(c.mensagens, autor))
where:
  filtra-chat(CHAT-TESTE, "Ana") is chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-3])
  filtra-chat(CHAT-TESTE, "Eu") is chat(CONTATO-ANA, [list: MSG-TESTE-2])
  filtra-chat(CHAT-TESTE, "Lucas") is chat(CONTATO-ANA, empty)
end


#| 
    Exercício 5: Desenhando um Chat
|#

# --- Funções gráficas auxiliares (fornecidas) ---

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
  cases (List<Mensagem>) mensagens:
    # Caso base: Se a lista for vazia, devolve imagem vazia
    | empty => empty-image
    # Passo recursivo: Posiciona o desenho da primeira mensagem acima do restante das mensagens
    | link(first, rest) => above(desenha-mensagem(first), desenha-mensagens(rest))
  end
end

fun desenha-chat(c :: Chat) -> Image:
  doc: "Dado um Chat, desenha a interface completa da conversa."
  mensagens-montadas = desenha-mensagens(c.mensagens)
  fundo-mensagens = rectangle(LARGURA-CHAT, image-height(mensagens-montadas) + 20, "solid", COR-FUNDO-CHAT)
  corpo-chat = overlay-align("center", "top", mensagens-montadas, fundo-mensagens)
  above(desenha-cabecalho(c.contato), corpo-chat)
end

# Visualizando o chat de teste:
# desenha-chat(CHAT-TESTE)

# Visualizando o chat longo completo:
# desenha-chat(CHAT-LONGO)

# Visualizando o chat longo filtrado apenas com as mensagens da Ana:
# desenha-chat(filtra-chat(CHAT-LONGO, "Ana"))
