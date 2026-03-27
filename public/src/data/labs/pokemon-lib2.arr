use context dcic2024

import color from color
import color as C
include image
include csv
include data-source
include reactors

provide: * end

TYPE-NORMAL = "NORMAL"
TYPE-FIRE = "FIRE"
TYPE-WATER = "WATER"
TYPE-ELECTRIC = "ELECTRIC"
TYPE-GRASS = "GRASS"
TYPE-ICE = "ICE"
TYPE-FIGHTING = "FIGHTING"
TYPE-POISON = "POISON"
TYPE-PSYCHIC = "PSYCHIC"
TYPE-BUG = "BUG"
TYPE-GROUND = "GROUND"
TYPE-FAIRY = "FAIRY"
TYPE-ROCK = "ROCK"
TYPE-GHOST = "GHOST"
TYPE-DRAGON = "DRAGON"
TYPE-STEEL = "STEEL"
TYPE-FLYING = "FLYING"
TYPE-DARK = "DARK"


POKE-URL = "https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv"

POKE-DATA =
  load-table: id, name, type1, type2, total, hp, attack, defense, spatck, spdef, speed, generation, legendary
    source: csv-table-url(POKE-URL, default-options)
    sanitize id using num-sanitizer
    sanitize name using string-sanitizer
    sanitize type1 using string-sanitizer
    sanitize type2 using string-sanitizer
    sanitize hp using num-sanitizer
  end

CARTA-ALT = 175
CARTA-LAR = 125

MESA = circle(20 + CARTA-ALT, "solid", "lightgray")
BORDA = rectangle(CARTA-LAR + 10, CARTA-ALT + 10, "outline", "black")

FUNDO-NORMAL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "darkgray")
FUNDO-FIRE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "red")
FUNDO-WATER = rectangle(CARTA-LAR, CARTA-ALT, "solid", "blue")
FUNDO-ELECTRIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "yellow")
FUNDO-GRASS = rectangle(CARTA-LAR, CARTA-ALT, "solid", "green")
FUNDO-ICE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightblue")
FUNDO-FIGHTING = rectangle(CARTA-LAR, CARTA-ALT, "solid", "brown")
FUNDO-POISON = rectangle(CARTA-LAR, CARTA-ALT, "solid", "mediumorchid")
FUNDO-PSYCHIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "magenta")
FUNDO-BUG = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightgreen")
FUNDO-GROUND = rectangle(CARTA-LAR, CARTA-ALT, "solid", "sienna")
FUNDO-FAIRY = rectangle(CARTA-LAR, CARTA-ALT, "solid", "pink")
FUNDO-ROCK = rectangle(CARTA-LAR, CARTA-ALT, "solid", "gray")
FUNDO-GHOST = rectangle(CARTA-LAR, CARTA-ALT, "solid", "purple")
FUNDO-DRAGON = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightsteelblue")
FUNDO-STEEL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightgray")
FUNDO-FLYING = rectangle(CARTA-LAR, CARTA-ALT, "solid", "skyblue")
FUNDO-DARK = rectangle(CARTA-LAR, CARTA-ALT, "solid", "black")

ATAQUE = "Attack"
DEFESA = "Defense"
EFEITO-SEMEFEITO = "No effect"
EFEITO-NAOEFETIVO = "Not very effective"
EFEITO-EFETIVO = "Effective"
EFEITO-SUPEREFETIVO = "Super-effective!"


fun seleciona-fundo(tipo :: String) -> Image:
    doc: "Dado o tipo da carta, devolve a imagem de fundo correspondente a este tipo."
    ask:
        | tipo == TYPE-NORMAL then: FUNDO-NORMAL
        | tipo == TYPE-FIRE then: FUNDO-FIRE
        | tipo == TYPE-WATER then: FUNDO-WATER
        | tipo == TYPE-ELECTRIC then: FUNDO-ELECTRIC
        | tipo == TYPE-GRASS then: FUNDO-GRASS
        | otherwise: FUNDO-NORMAL
    end
where:
    seleciona-fundo(TYPE-NORMAL) is FUNDO-NORMAL
    seleciona-fundo(TYPE-FIRE) is FUNDO-FIRE
end


fun id-pokemon(nome :: String) -> Number:
    doc: "Dado o nome de um pokemon, devolve o id deste pokemon."
    tabela = filter-with(POKE-DATA, lam(row): row["name"] == nome end)

    tabela.row-n(0)["id"]
where:
    id-pokemon("Bulbasaur") is 1
    id-pokemon("Ivysaur") is 2
    id-pokemon("Venusaur") is 3
end


fun id-to-3-digit-string(pokemon-id :: Number) -> String:
    doc: "Dado um número, devolve uma string com este número formatado com 3 dígitos (com zeros à esquerda se necessário)."
    ask:
        | pokemon-id < 10 then: string-append("00", num-to-string(pokemon-id))
        | pokemon-id < 100 then: string-append("0", num-to-string(pokemon-id))
        | otherwise: num-to-string(pokemon-id)
    end
where:
    id-to-3-digit-string(1) is "001"
    id-to-3-digit-string(10) is "010"
    id-to-3-digit-string(100) is "100"
end


fun img-pokemon(pokemon-id :: Number) -> Image:
    doc: "Dado o id de um pokemon, devolve a imagem deste pokemon."
    url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/" + id-to-3-digit-string(pokemon-id) + ".png"
    img = image-url(url)

    scale(0.75, img)
end


fun name-pokemon(pokemon-id :: Number) -> String:
    doc: "Dado o id de um pokemon, devolve o nome deste pokemon."
    tabela = filter-with(POKE-DATA, lam(row): row["id"] == pokemon-id end)

    tabela.row-n(0)["name"]
where:
    name-pokemon(1) is "Bulbasaur"
    name-pokemon(2) is "Ivysaur"
end


fun testa-superefetivo(tipo-ataque :: String, tipo-defesa :: String) -> Boolean:
    doc: "Dado o tipo de ataque e o tipo de defesa, true se o ataque for super efetivo e false caso contrário."
    ask:
        | (tipo-ataque == TYPE-FIRE) and (tipo-defesa == TYPE-GRASS) then: true
        | (tipo-ataque == TYPE-WATER) and (tipo-defesa == TYPE-FIRE) then: true
        | (tipo-ataque == TYPE-ELECTRIC) and (tipo-defesa == TYPE-WATER) then: true
        | (tipo-ataque == TYPE-GRASS) and (tipo-defesa == TYPE-WATER) then: true
        | otherwise: false
    end
where:
    testa-superefetivo(TYPE-FIRE, TYPE-GRASS) is true
    testa-superefetivo(TYPE-WATER, TYPE-FIRE) is true
    testa-superefetivo(TYPE-ELECTRIC, TYPE-WATER) is true
    testa-superefetivo(TYPE-GRASS, TYPE-FIRE) is false
end


fun testa-naoefetivo(tipo-ataque :: String, tipo-defesa :: String) -> Boolean:
    doc: "Dado o tipo de ataque e o tipo de defesa, true se o ataque for não efetivo e false caso contrário."
    # um tipo é não efetivo se ele for igual ao tipo de defesa ou se a defesa for super efetiva
    (tipo-ataque == tipo-defesa) or testa-superefetivo(tipo-defesa, tipo-ataque)
where:
    testa-naoefetivo(TYPE-FIRE, TYPE-WATER) is true
    testa-naoefetivo(TYPE-WATER, TYPE-ELECTRIC) is true
    testa-naoefetivo(TYPE-ELECTRIC, TYPE-GRASS) is false
    testa-naoefetivo(TYPE-GRASS, TYPE-FIRE) is true
end


fun verifica-efeito(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    ask:
        | testa-superefetivo(tipo-ataque, tipo-defesa) then: EFEITO-SUPEREFETIVO
        | testa-naoefetivo(tipo-ataque, tipo-defesa) then: EFEITO-NAOEFETIVO
        | otherwise: EFEITO-EFETIVO  # Em todos outros casos, o efeito é efetivo
    end
where:
    verifica-efeito(TYPE-FIRE, TYPE-GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-WATER) is EFEITO-NAOEFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-ELECTRIC) is EFEITO-EFETIVO
end


fun cria-carta(nome :: String, tipo :: String) -> Image:
    doc: "Dado o nome do Pokemon e o tipo da carta, devolve uma imagem com a carta montada."
    
    # Definições Locais:
    # Gera imagem do pokemon sobre o círculo
    pokemon-sobre-circulo = overlay(img-pokemon(id-pokemon(nome)), circle(60, "solid", "white"))
    # Gera fundo com o pokemon
    fundo-com-pokemon = overlay(pokemon-sobre-circulo, seleciona-fundo(tipo))
    # Gera carta com o tipo
    carta-com-tipo = overlay-align("middle", "bottom", text(tipo, 20, "black"), fundo-com-pokemon)
    # Gera carta com o nome
    carta-com-nome = overlay-align("middle", "top", text(nome, 20, "black"), carta-com-tipo)
    # Gera carta final com a borda
    carta-final = overlay-align("center", "center", carta-com-nome, BORDA)

    # Expressão:
    carta-final
end
