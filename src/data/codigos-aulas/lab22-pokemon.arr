use context dcic2024

include csv
include data-source


pokemons-url = "https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv"

pokemon-data =
 load-table: id, name, type1, type2, total, hp, attack, defense, spatck, spdef, speed,generation, legendary
    source: csv-table-url(pokemons-url, default-options)
    sanitize id using num-sanitizer
    sanitize name using string-sanitizer
    sanitize type1 using string-sanitizer
    sanitize type2 using string-sanitizer
    sanitize hp using num-sanitizer
  end


CARTA-ALT = 175
CARTA-LAR = 125

MESA = circle(20 + CARTA-ALT, "solid", "lightgray")

FUNDO-NORMAL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "darkgray")
FUNDO-FIRE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "red")
FUNDO-WATER = rectangle(CARTA-LAR, CARTA-ALT, "solid", "blue")
FUNDO-ELECTRIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "yellow")
FUNDO-GRASS = rectangle(CARTA-LAR, CARTA-ALT, "solid", "green")
FUNDO-ICE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightblue")
FUNDO-FIGHTING = rectangle(CARTA-LAR, CARTA-ALT, "solid", "brown")
FUNDO-POISON = rectangle(CARTA-LAR, CARTA-ALT, "solid", "mediumorchid")
FUNDO-PSYCHIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "magenta")

ATAQUE = "Attack"
DEFESA = "Defense"

EFEITO-SEMEFEITO = "No effect"
EFEITO-NAOEFETIVO = "Not very effective"
EFEITO-EFETIVO = "Effective"
EFEITO-SUPEREFETIVO = "Super-effective!"

BORDA = rectangle(CARTA-LAR + 10, CARTA-ALT + 10, "outline", "black")


data TipoPokemon:
    # Um elemento de TipoPokemon tem o formato:
    | NORMAL
    | FIRE
    | WATER
    | ELECTRIC
    | GRASS
    | ICE
    | FIGHTING
    | POISON
    | PSYCHIC
end

fun tipo-to-string(tipo :: TipoPokemon) -> String:
    doc: "Dado um tipo de pokemon, devolve a string correspondente a este tipo."
    cases (TipoPokemon) tipo:
        | NORMAL => "NORMAL"
        | FIRE => "FIRE"
        | WATER => "WATER"
        | ELECTRIC => "ELECTRIC"
        | GRASS => "GRASS"
        | ICE => "ICE"
        | FIGHTING => "FIGHTING"
        | POISON => "POISON"
        | PSYCHIC => "PSYCHIC"
    end
end

fun string-to-tipo(s :: String) -> TipoPokemon:
    doc: "Dada uma string, devolve o tipo de pokemon correspondente a esta string (assumir que a string é sempre um tipo válido)."
    ask:
        | string-to-upper(s) == "NORMAL" then: NORMAL
        | string-to-upper(s) == "FIRE" then: FIRE
        | string-to-upper(s) == "WATER" then: WATER
        | string-to-upper(s) == "ELECTRIC" then: ELECTRIC
        | string-to-upper(s) == "GRASS" then: GRASS
        | string-to-upper(s) == "ICE" then: ICE
        | string-to-upper(s) == "FIGHTING" then: FIGHTING
        | string-to-upper(s) == "POISON" then: POISON
        | otherwise: PSYCHIC
    end
end

data Pokemon:
    # Um elemento de Pokemon tem o formato:
    | pokemon(nome :: String, id :: Number, tipo :: TipoPokemon, hp :: Number)
end

bulbasaur = pokemon("Bulbasaur", 1, GRASS, 45)
charmander = pokemon("Charmander", 4, FIRE, 39)
squirtle = pokemon("Squirtle", 7, WATER, 44)
mewtwo = pokemon("Mewtwo", 150, PSYCHIC, 106)

fun pokemon-from-table(id :: Number, table :: Table) -> Pokemon:
    doc: "Dado um id e uma tabela de pokemons, devolve o pokemon correspondente a este id nesta tabela."
    row = filter-with(pokemon-data, lam(row): row["id"] == id end).row-n(0)
    pokemon(row["name"], row["id"], string-to-tipo(row["type1"]), row["hp"])
end



data Movimento:
    # Um elemento de movimento tem o formato:
    | ataque(nome :: String, tipo :: TipoPokemon, poder :: Number)
    # onde nome é o nome do ataque, tipo é o tipo do ataque e poder é a força do ataque
    # ou:
    | cura(nome :: String, cura :: Number)
    # onde nome é o nome da cura e cura é a quantidade de hp que o movimento recupera
end

# Constante ataques
ember = ataque("Ember", FIRE, 40)
tackle = ataque("Tackle", NORMAL, 40)

fun id-to-3-digit-string(id :: Number) -> String:
    doc: "Dado um número, devolve uma string com este número formatado com 3 dígitos (com zeros à esquerda se necessário)."
    ask:
        | id < 10 then: "00" + num-to-string(id)
        | id < 100 then: "0" + num-to-string(id)
        | otherwise: num-to-string(id)
    end
where:
    id-to-3-digit-string(5) is "005"
    id-to-3-digit-string(45) is "045"
    id-to-3-digit-string(150) is "150"
end

fun img-pokemon(id :: Number) -> Image:
    doc: "Dado o id de um pokemon, devolve a imagem deste pokemon."
    url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/" + id-to-3-digit-string(id) + ".png"
    img = image-url(url)
    scale(0.75, img)
end


fun seleciona-fundo(tipo :: TipoPokemon) -> Image:
    doc: "Dado o tipo da carta, devolve a imagem de fundo correspondente a este tipo."
    cases (TipoPokemon) tipo:
        | NORMAL => FUNDO-NORMAL
        | FIRE => FUNDO-FIRE
        | WATER => FUNDO-WATER
        | ELECTRIC => FUNDO-ELECTRIC
        | GRASS => FUNDO-GRASS
        | ICE => FUNDO-ICE
        | FIGHTING => FUNDO-FIGHTING
        | POISON => FUNDO-POISON
        | PSYCHIC => FUNDO-PSYCHIC
    end
end

fun verifica-efeito(tipo-ataque :: TipoPokemon, tipo-defesa :: TipoPokemon) -> String:
    doc: "Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo)."
    cases (TipoPokemon) tipo-ataque:
        | NORMAL =>
            EFEITO-EFETIVO
        | FIRE =>
            ask:
                | tipo-defesa == GRASS then: EFEITO-SUPEREFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | WATER =>
            ask:
                | tipo-defesa == FIRE then: EFEITO-SUPEREFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | ELECTRIC =>
            ask:
                | tipo-defesa == WATER then: EFEITO-SUPEREFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | GRASS =>
            ask:
                | tipo-defesa == WATER then: EFEITO-SUPEREFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | ICE =>
            ask:
                | tipo-defesa == GRASS then: EFEITO-SUPEREFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | FIGHTING =>
            ask:
                | tipo-defesa == NORMAL then: EFEITO-SUPEREFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | POISON =>
            ask:
                | tipo-defesa == GRASS then: EFEITO-SUPEREFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | PSYCHIC =>
            EFEITO-EFETIVO
    end
where:
    verifica-efeito(FIRE, GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito(WATER, FIRE) is EFEITO-SUPEREFETIVO
    verifica-efeito(ELECTRIC, WATER) is EFEITO-SUPEREFETIVO
end


fun desenha-carta(p :: Pokemon) -> Image:
    doc: "Dado a borda da carta, o fundo escolhido referente ao tipo da carta e a String com o tipo da carta, devolve uma imagem com a carta montada (colocar o texto em cima do fundo em cima da borda)."
    im = overlay(img-pokemon(p.id), seleciona-fundo(p.tipo))
    im2 = overlay-align("middle", "bottom", text(tipo-to-string(p.tipo), 20, "black"), im)
    im3 = overlay-align("center", "center", im2, BORDA)
    nome-hp = above(
        text(p.nome, 20, "black"), 
        text("HP: " + num-to-string(p.hp), 20, "black"))
    im4 = overlay-align("center", "top", nome-hp, im3)
    im4
end

desenha-carta(bulbasaur)


fun aplica-movimento(p :: Pokemon, m :: Movimento) -> Pokemon:
    doc: "Dado um pokemon e um movimento, devolve o pokemon resultante de aplicar este movimento sobre este pokemon (considerar que o ataque sempre acerta e que a cura não pode aumentar o hp do pokemon para mais do que 100)."
    cases (Movimento) m:
        | ataque(nome, tipo, poder) => 
            ask:
                | verifica-efeito(tipo, p.tipo) == EFEITO-SUPEREFETIVO then: pokemon(p.nome, p.id, p.tipo, p.hp - (poder * 2))
                | verifica-efeito(tipo, p.tipo) == EFEITO-NAOEFETIVO then: pokemon(p.nome, p.id, p.tipo, p.hp - (poder * 0.5))
                | otherwise: pokemon(p.nome, p.id, p.tipo, p.hp - poder)
            end
        | cura(nome, c) => pokemon(p.nome, p.id, p.tipo, num-min(100, p.hp + c))
    end
end

fun desenha-movimento(p1 :: Pokemon, p2 :: Pokemon, move :: Movimento) -> Image:
    doc: ""
    cases (Movimento) move:
        | ataque(nome, tipo, poder) =>
            p2-resultado = aplica-movimento(p2, move)
            ca = desenha-carta(p1)
            cd = desenha-carta(p2-resultado)
            ca-movimento = beside(ca, text(string-append("uses ", move.nome), 20, "black"))
            beside-cartas = beside(ca-movimento, cd)
            img = overlay-align("center", "center", beside-cartas, MESA)
            above(img, text(verifica-efeito(move.tipo, p2.tipo), 20, "black"))
        | cura(nome, c) =>
            p1-resultado = aplica-movimento(p1, move)
            ca = desenha-carta(p1-resultado)
            cd = desenha-carta(p2)
            ca-movimento = beside(ca, text(string-append("uses ", move.nome), 20, "black"))
            beside-cartas = beside(ca-movimento, cd)
            img = overlay-align("center", "center", beside-cartas, MESA)
            above(img, text(verifica-efeito(move.tipo, p2.tipo), 20, "black"))
    end
end

desenha-movimento(bulbasaur, charmander, tackle)

voltorb = pokemon-from-table(100, pokemon-data)
desenha-carta(voltorb)