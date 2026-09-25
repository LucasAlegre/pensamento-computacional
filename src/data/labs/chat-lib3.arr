use context dcic2024

import color from color
import color as C
include image
include csv
include data-source

provide: * end

#|
    chat-lib3.arr
    Biblioteca de apoio para o Laboratório 3 de INF05008 - Pensamento Computacional.
    Responsável por carregar o histórico de mensagens de uma tabela online (CSV)
    e fornecer funções prontas para consulta de mensagens, avatares e configurações visuais.

    Autor: Prof. Lucas N. Alegre
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

IDS-MENSAGENS-TABELA = [list: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]


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
    Funções para criação de avatares e status de contatos
|#

fun avatar-contato(nome :: String) -> Image:
  doc: "Dado o nome de um contato, gera um avatar circular colorido com a inicial do seu nome."
  letra = string-substring(nome, 0, 1)
  cor = ask:
    | nome == "Ana" then: "darkorchid"
    | nome == "Lucas" then: "dodgerblue"
    | nome == "Prof. Lucas" then: "dodgerblue"
    | nome == "Alex" then: "darkorange"
    | otherwise: "teal"
  end
  fundo = circle(20, "solid", cor)
  letra-img = text(letra, 18, "white")
  overlay(letra-img, fundo)
end

fun status-contato(nome :: String) -> Boolean:
  doc: "Dado o nome de um contato, devolve true se o contato estiver online ou false caso contrário."
  ask:
    | nome == "Ana" then: true
    | nome == "Lucas" then: true
    | nome == "Prof. Lucas" then: true
    | nome == "Alex" then: false
    | otherwise: false
  end
end


#|
    Constantes visuais para o layout do Chat
|#

LARGURA-CHAT = 360
LARGURA-BALAO = 260

COR-FUNDO-CHAT = "whitesmoke"
COR-BALAO-EU = "lightgreen"
COR-BALAO-OUTRO = "white"
COR-CABECALHO = "darkgreen"
