use context dcic2024

import color from color
import color as C
include image
include csv
include data-source
include reactors

provide:
  *,
  type *
end


data TipoPokemon:
    # Um Pokemon ou movimento pode ter um dos tipos abaixo:
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


data Efeito:
    # Um ataque pode ter um dos efeitos abaixo:
    | SEM-EFEITO
    | NAO-EFETIVO
    | EFETIVO
    | SUPER-EFETIVO
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


EFFECTIVE-URL = "https://raw.githubusercontent.com/zonination/pokemon-chart/refs/heads/master/chart.csv"

EFFECTIVE-DATA =
  load-table: Attacking, Normal, Fire, Water, Electric, Grass, Ice, Fighting, Poison, Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel, Fairy
    source: csv-table-url(EFFECTIVE-URL, default-options)
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

fun tipo-to-string(tipo :: TipoPokemon) -> String:
    doc: "Dada um tipo de pokemon, devolve a string correspondente."
    ask:
        | tipo == NORMAL then: "Normal"
        | tipo == FIRE then: "Fire"
        | tipo == WATER then: "Water"
        | tipo == ELECTRIC then: "Electric"
        | tipo == GRASS then: "Grass"
        | tipo == ICE then: "Ice"
        | tipo == FIGHTING then: "Fighting"
        | tipo == POISON then: "Poison"
        | tipo == PSYCHIC then: "Psychic"
        | tipo == BUG then: "Bug"
        | tipo == GROUND then: "Ground"
        | tipo == FAIRY then: "Fairy"
        | tipo == ROCK then: "Rock"
        | tipo == GHOST then: "Ghost"
        | tipo == DRAGON then: "Dragon"
        | tipo == STEEL then: "Steel"
        | tipo == FLYING then: "Flying"
        | otherwise: "Dark"
    end
where:
    tipo-to-string(NORMAL) is "Normal"
    tipo-to-string(FIRE) is "Fire"
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


fun verifica-efeito(tipo-ataque :: TipoPokemon, tipo-defesa :: TipoPokemon) -> Efeito:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    str-ataque = tipo-to-string(tipo-ataque)
    str-defesa = tipo-to-string(tipo-defesa)
    tabela = filter-with(EFFECTIVE-DATA, lam(row): row["Attacking"] == str-ataque end)
    num-effect = tabela.row-n(0)[str-defesa]

    ask:
        | num-effect == "0" then: SEM-EFEITO
        | num-effect == "0.5" then: NAO-EFETIVO
        | num-effect == "1" then: EFETIVO
        | num-effect == "2" then: SUPER-EFETIVO
    end
where:
    verifica-efeito(FIRE, GRASS) is SUPER-EFETIVO
    verifica-efeito(FIRE, WATER) is NAO-EFETIVO
    verifica-efeito(FIRE, ELECTRIC) is EFETIVO
end
