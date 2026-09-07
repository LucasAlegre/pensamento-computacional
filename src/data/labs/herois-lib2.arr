use context dcic2024

import color from color
import color as C
include image
include csv
include data-source
include reactors

provide: * end

ALINHAMENTO-BOM = "good"
ALINHAMENTO-MAU = "bad"
ALINHAMENTO-NEUTRO = "neutral"


HEROI-URL = "https://raw.githubusercontent.com/lucasalegre/pensamento-computacional/main/src/data/labs/2026-2/herois.csv"

HEROI-DATA =
  load-table: id, name, publisher, alignment, gender, race, image_url
    source: csv-table-url(HEROI-URL, default-options)
    sanitize id using num-sanitizer
    sanitize name using string-sanitizer
    sanitize publisher using string-sanitizer
    sanitize alignment using string-sanitizer
    sanitize gender using string-sanitizer
    sanitize race using string-sanitizer
    sanitize image_url using string-sanitizer
  end

CARTA-ALT = 190
CARTA-LAR = 130

BORDA = rectangle(CARTA-LAR + 10, CARTA-ALT + 10, "outline", "black")

FUNDO-BOM = rectangle(CARTA-LAR, CARTA-ALT, "solid", "royal-blue")
FUNDO-MAU = rectangle(CARTA-LAR, CARTA-ALT, "solid", "fire-brick")
FUNDO-NEUTRO = rectangle(CARTA-LAR, CARTA-ALT, "solid", "dim-gray")
FUNDO-DESCONHECIDO = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightgray")


fun seleciona-fundo(alinhamento :: String) -> Image:
    doc: "Dado o alinhamento de um herói, devolve a imagem de fundo correspondente a este alinhamento."
    ask:
        | alinhamento == ALINHAMENTO-BOM then: FUNDO-BOM
        | alinhamento == ALINHAMENTO-MAU then: FUNDO-MAU
        | alinhamento == ALINHAMENTO-NEUTRO then: FUNDO-NEUTRO
        | otherwise: FUNDO-DESCONHECIDO
    end
where:
    seleciona-fundo(ALINHAMENTO-BOM) is FUNDO-BOM
    seleciona-fundo(ALINHAMENTO-MAU) is FUNDO-MAU
    seleciona-fundo(ALINHAMENTO-NEUTRO) is FUNDO-NEUTRO
end


fun id-heroi(nome :: String) -> Number:
    doc: "Dado o nome de um herói, devolve o id deste herói."
    tabela = filter-with(HEROI-DATA, lam(row): row["name"] == nome end)

    tabela.row-n(0)["id"]
where:
    id-heroi("A-Bomb") is 1
    id-heroi("Abe Sapien") is 2
end


fun img-heroi(nome :: String) -> Image:
    doc: "Dado o nome de um herói, devolve a imagem deste herói."
    tabela = filter-with(HEROI-DATA, lam(row): row["name"] == nome end)
    url = tabela.row-n(0)["image_url"]

    scale(0.7, image-url(url))
end


fun cria-carta(nome :: String, alinhamento :: String) -> Image:
    doc: "Dado o nome do herói e o seu alinhamento, devolve uma imagem com a carta montada."

    # Definições Locais:
    # Gera imagem do herói sobre o círculo
    heroi-sobre-circulo = overlay(img-heroi(nome), circle(60, "solid", "white"))
    # Gera fundo com o herói
    fundo-com-heroi = overlay(heroi-sobre-circulo, seleciona-fundo(alinhamento))
    # Gera carta com o alinhamento
    carta-com-alinhamento = overlay-align("middle", "bottom", text(alinhamento, 16, "black"), fundo-com-heroi)
    # Gera carta com o nome
    carta-com-nome = overlay-align("middle", "top", text(nome, 14, "black"), carta-com-alinhamento)
    # Gera carta final com a borda
    carta-final = overlay-align("center", "center", carta-com-nome, BORDA)

    # Expressão:
    carta-final
end
