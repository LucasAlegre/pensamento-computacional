use context dcic2024

import color from color
import color as C
include image
include csv
include data-source
include reactors

provide: * end


data TipoPokemon:
    | NORMAL
    | FIRE
    | ELECTRIC
    | WATER
    | GRASS
    | ICE
    | FIGHTING
    | POISON
    | PSYCHIC
    | BUG
    | GROUND
    | FAIRY
    | ROCK
    | GHOST
    | DRAGON
    | STEEL
    | FLYING
    | DARK
end


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

FUNDO-NORMAL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "dim-gray")
FUNDO-FIRE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "fire-brick")
FUNDO-WATER = rectangle(CARTA-LAR, CARTA-ALT, "solid", "dodger-blue")
FUNDO-ELECTRIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "gold")
FUNDO-GRASS = rectangle(CARTA-LAR, CARTA-ALT, "solid", "forest-green")
FUNDO-ICE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightblue")
FUNDO-FIGHTING = rectangle(CARTA-LAR, CARTA-ALT, "solid", "brown")
FUNDO-POISON = rectangle(CARTA-LAR, CARTA-ALT, "solid", "mediumorchid")
FUNDO-PSYCHIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "dark-magenta")
FUNDO-BUG = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightgreen")
FUNDO-GROUND = rectangle(CARTA-LAR, CARTA-ALT, "solid", "sienna")
FUNDO-FAIRY = rectangle(CARTA-LAR, CARTA-ALT, "solid", "pink")
FUNDO-ROCK = rectangle(CARTA-LAR, CARTA-ALT, "solid", "gray")
FUNDO-GHOST = rectangle(CARTA-LAR, CARTA-ALT, "solid", "rebecca-purple")
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


fun seleciona-fundo(tipo :: TipoPokemon) -> Image:
    doc: "Dado o tipo da carta, devolve a imagem de fundo correspondente a este tipo."
    ask:
        | tipo == NORMAL then: FUNDO-NORMAL
        | tipo == FIRE then: FUNDO-FIRE
        | tipo == WATER then: FUNDO-WATER
        | tipo == ELECTRIC then: FUNDO-ELECTRIC
        | tipo == GRASS then: FUNDO-GRASS
        | tipo == ICE then: FUNDO-ICE
        | tipo == FIGHTING then: FUNDO-FIGHTING
        | tipo == POISON then: FUNDO-POISON
        | tipo == PSYCHIC then: FUNDO-PSYCHIC
        | tipo == BUG then: FUNDO-BUG
        | tipo == GROUND then: FUNDO-GROUND
        | tipo == FAIRY then: FUNDO-FAIRY
        | tipo == ROCK then: FUNDO-ROCK
        | tipo == GHOST then: FUNDO-GHOST
        | tipo == DRAGON then: FUNDO-DRAGON
        | tipo == STEEL then: FUNDO-STEEL
        | tipo == FLYING then: FUNDO-FLYING
        | tipo == DARK then: FUNDO-DARK
        | otherwise: FUNDO-NORMAL
    end
where:
    seleciona-fundo(NORMAL) is FUNDO-NORMAL
    seleciona-fundo(FIRE) is FUNDO-FIRE
end

fun string-to-tipo(s :: String) -> TipoPokemon:
    doc: "Dada uma string, devolve o tipo de pokemon correspondente a esta string (assumir que a string é sempre um tipo válido)."
    u = string-to-upper(s)
    
    ask:
        | u == "NORMAL" then: NORMAL
        | u == "FIRE" then: FIRE
        | u == "WATER" then: WATER
        | u == "ELECTRIC" then: ELECTRIC
        | u == "GRASS" then: GRASS
        | u == "ICE" then: ICE
        | u == "FIGHTING" then: FIGHTING
        | u == "POISON" then: POISON
        | u == "PSYCHIC" then: PSYCHIC
        | u == "BUG" then: BUG
        | u == "GROUND" then: GROUND
        | u == "FAIRY" then: FAIRY
        | u == "ROCK" then: ROCK
        | u == "GHOST" then: GHOST
        | u == "DRAGON" then: DRAGON
        | u == "STEEL" then: STEEL
        | u == "FLYING" then: FLYING
        | otherwise: DARK
    end
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


fun testa-superefetivo(tipo-ataque :: TipoPokemon, tipo-defesa :: TipoPokemon) -> Boolean:
    doc: "Dado o tipo de ataque e o tipo de defesa, true se o ataque for super efetivo e false caso contrário."
    ask:
        | (tipo-ataque == FIRE) and (tipo-defesa == GRASS) then: true
        | (tipo-ataque == WATER) and (tipo-defesa == FIRE) then: true
        | (tipo-ataque == ELECTRIC) and (tipo-defesa == WATER) then: true
        | (tipo-ataque == GRASS) and (tipo-defesa == WATER) then: true
        | otherwise: false
    end
where:
    testa-superefetivo(FIRE, GRASS) is true
    testa-superefetivo(WATER, FIRE) is true
    testa-superefetivo(ELECTRIC, WATER) is true
    testa-superefetivo(GRASS, FIRE) is false
end


fun testa-naoefetivo(tipo-ataque :: TipoPokemon, tipo-defesa :: TipoPokemon) -> Boolean:
    doc: "Dado o tipo de ataque e o tipo de defesa, true se o ataque for não efetivo e false caso contrário."
    # um tipo é não efetivo se ele for igual ao tipo de defesa ou se a defesa for super efetiva
    (tipo-ataque == tipo-defesa) or testa-superefetivo(tipo-defesa, tipo-ataque)
where:
    testa-naoefetivo(FIRE, WATER) is true
    testa-naoefetivo(WATER, ELECTRIC) is true
    testa-naoefetivo(ELECTRIC, GRASS) is false
    testa-naoefetivo(GRASS, FIRE) is true
end


fun verifica-efeito(tipo-ataque :: TipoPokemon, tipo-defesa :: TipoPokemon) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    ask:
        | testa-superefetivo(tipo-ataque, tipo-defesa) then: EFEITO-SUPEREFETIVO
        | testa-naoefetivo(tipo-ataque, tipo-defesa) then: EFEITO-NAOEFETIVO
        | otherwise: EFEITO-EFETIVO  # Em todos outros casos, o efeito é efetivo
    end
where:
    verifica-efeito(FIRE, GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito(FIRE, WATER) is EFEITO-NAOEFETIVO
    verifica-efeito(FIRE, ELECTRIC) is EFEITO-EFETIVO
end


fun cria-carta(nome :: String, tipo :: TipoPokemon) -> Image:
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
