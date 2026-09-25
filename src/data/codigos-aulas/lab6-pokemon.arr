
use context dcic2024

import color from color
import color as C
include image
include csv
include data-source
include reactors


pokemons-url = "https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv"

pokemon-data =
  load-table: id, name, type1, type2, total, hp, attack, defense, spatck, spdef, speed, generation, legendary
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


data TipoPokemon:
    # Um TipoPokemon pode ser:
    | NORMAL
    | FIRE
    | WATER
    | BUG
    | GROUND
    | FAIRY
    | ROCK
    | GHOST
    | DRAGON
    | STEEL
    | ELECTRIC
    | GRASS
    | ICE
    | FIGHTING
    | POISON
    | PSYCHIC
    | FLYING
    | DARK
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
        | BUG => "BUG"
        | GROUND => "GROUND"
        | FAIRY => "FAIRY"
        | ROCK => "ROCK"
        | GHOST => "GHOST"
        | DRAGON => "DRAGON"
        | STEEL => "STEEL"
        | FLYING => "FLYING"
        | DARK => "DARK"
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
        | string-to-upper(s) == "PSYCHIC" then: PSYCHIC
        | string-to-upper(s) == "BUG" then: BUG
        | string-to-upper(s) == "GROUND" then: GROUND
        | string-to-upper(s) == "FAIRY" then: FAIRY
        | string-to-upper(s) == "ROCK" then: ROCK
        | string-to-upper(s) == "GHOST" then: GHOST
        | string-to-upper(s) == "DRAGON" then: DRAGON
        | string-to-upper(s) == "STEEL" then: STEEL
        | string-to-upper(s) == "FLYING" then: FLYING
        | otherwise: DARK
    end
end

data Pokemon:
    # Um elemento de Pokemon tem o formato:
    | pokemon(
        nome :: String, 
        id :: Number, 
        tipo :: TipoPokemon, 
        hp-max :: Number, 
        hp :: Number,
        movimentos :: List<Movimento>)
end

data Movimento:
    # Um elemento de movimento tem o formato:
    | ataque(nome :: String, tipo :: TipoPokemon, poder :: Number)
    | cura(nome :: String, cura :: Number)
end


bulbasaur = pokemon("Bulbasaur", 1, GRASS, 45, 45, [list: cura("Synthesis", 20), ataque("Vine Whip", GRASS, 45)])
charmander = pokemon("Charmander", 4, FIRE, 39, 39, [list: ataque("Ember", FIRE, 40), ataque("Scratch", NORMAL, 40)])
squirtle = pokemon("Squirtle", 7, WATER, 44, 44, [list: ataque("Water Gun", WATER, 40), ataque("Tackle", NORMAL, 40)])
mewtwo = pokemon("Mewtwo", 150, PSYCHIC, 106, 106, [list: ataque("Psychic", PSYCHIC, 90), ataque("Shadow Ball", GHOST, 80)])
pikachu = pokemon("Pikachu", 25, ELECTRIC, 35, 35, [list: ataque("Thunder Shock", ELECTRIC, 40), ataque("Quick Attack", NORMAL, 40)])
voltorb = pokemon("Voltorb", 100, ELECTRIC, 40, 40, [list: ataque("Spark", ELECTRIC, 65), ataque("Tackle", NORMAL, 40)])
gengar = pokemon("Gengar", 94, POISON, 60, 60, [list: ataque("Shadow Ball", GHOST, 80), ataque("Sludge Bomb", POISON, 90)])



data Time:
    | t-empty
    | t-link(first :: Pokemon, rest :: Time)
end

data Treinador:
    | treinador(nome :: String, idade :: Number, time :: Time)
end

time1 = t-link(bulbasaur, t-link(charmander, t-link(squirtle, t-empty)))
time2 = t-link(pikachu, t-link(voltorb, t-link(gengar, t-empty)))

ash = treinador("Ash", 10, time1)
misty = treinador("Misty", 11, time2)


fun tamanho-time(t :: Time) -> Number:
    doc: "Dado um time, devolve o número de pokemons neste time."
    cases (Time) t:
        | t-empty => 0
        | t-link(first, rest) => 1 + tamanho-time(rest)
    end
end

fun id-to-4-digit-string(id :: Number) -> String:
    doc: "Dado um número, devolve uma string com este número formatado com 4 dígitos (com zeros à esquerda se necessário)."
    ask:
        | id < 10 then: string-append("000", num-to-string(id))
        | id < 100 then: string-append("00", num-to-string(id))
        | id < 1000 then: string-append("0", num-to-string(id))
        | otherwise: num-to-string(id)
    end
end

fun img-pokemon(id :: Number) -> Image:
    doc: "Dado o id de um pokemon, devolve a imagem deste pokemon."
    url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/" + id-to-4-digit-string(id) + ".png"
    img = image-url(url)
    scale(0.75, img)
end

fun pokemon-from-table(id :: Number, table :: Table) -> Pokemon:
    doc: "Dado um id e uma tabela de pokemons, devolve o pokemon correspondente a este id nesta tabela."
    row = filter-with(pokemon-data, lam(row): row["id"] == id end).row-n(0)
    pokemon(row["name"], row["id"], string-to-tipo(row["type1"]), row["hp"])
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
        | BUG => FUNDO-BUG
        | GROUND => FUNDO-GROUND
        | FAIRY => FUNDO-FAIRY
        | ROCK => FUNDO-ROCK
        | GHOST => FUNDO-GHOST
        | DRAGON => FUNDO-DRAGON
        | STEEL => FUNDO-STEEL
        | FLYING => FUNDO-FLYING
        | DARK => FUNDO-DARK
    end
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

fun desenha-time(time :: Time) -> Image:
    doc: "Dado um treinador, gera uma imagem com as cartas dos pokemons do seu time empilhadas (colocar a carta do primeiro pokemon do time em cima)."
    cases (Time) time:
        | t-empty => empty-image
        | t-link(p, rest) => beside(desenha-carta(p), desenha-time(rest))
    end
end


fun verifica-efeito(tipo-ataque :: TipoPokemon, tipo-defesa :: TipoPokemon) -> String:
    doc: "Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo)."
    ask:
        | (tipo-ataque == FIRE) and (tipo-defesa == GRASS) then: EFEITO-SUPEREFETIVO
        | (tipo-ataque == WATER) and (tipo-defesa == FIRE) then: EFEITO-SUPEREFETIVO
        | (tipo-ataque == ELECTRIC) and (tipo-defesa == WATER) then: EFEITO-SUPEREFETIVO
        | (tipo-ataque == GRASS) and (tipo-defesa == WATER) then: EFEITO-SUPEREFETIVO
        | (tipo-ataque == ICE) and (tipo-defesa == GRASS) then: EFEITO-SUPEREFETIVO
        | (tipo-ataque == FIGHTING) and (tipo-defesa == NORMAL) then: EFEITO-SUPEREFETIVO
        |(tipo-ataque == POISON) and (tipo-defesa == GRASS) then: EFEITO-SUPEREFETIVO
        | otherwise: EFEITO-SEMEFEITO
    end
where:
    verifica-efeito(FIRE, GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito(WATER, FIRE) is EFEITO-SUPEREFETIVO
    verifica-efeito(ELECTRIC, WATER) is EFEITO-SUPEREFETIVO
end

fun aplica-movimento(p :: Pokemon, m :: Movimento) -> Pokemon:
    doc: "Dado um pokemon e um movimento, devolve o pokemon resultante de aplicar este movimento sobre este pokemon (considerar que o ataque sempre acerta e que a cura não pode aumentar o hp do pokemon para mais do que 100)."
    cases (Movimento) m:
        | ataque(nome, tipo, poder) => 
            ask:
                | verifica-efeito(tipo, p.tipo) == EFEITO-SUPEREFETIVO then: 
                    pokemon(p.nome, p.id, p.tipo, p.hp-max, p.hp - (poder * 2), p.movimentos)
                | verifica-efeito(tipo, p.tipo) == EFEITO-NAOEFETIVO then: 
                    pokemon(p.nome, p.id, p.tipo, p.hp-max, p.hp - (poder * 0.5), p.movimentos)
                | otherwise: 
                    pokemon(p.nome, p.id, p.tipo, p.hp-max, p.hp - poder, p.movimentos)
            end
        | cura(nome, c) => 
            pokemon(p.nome, p.id, p.tipo, p.hp-max, num-min(100, p.hp + c), p.movimentos)
    end
end



data Batalha:
    | batalha(t1 :: Treinador, t2 :: Treinador, is-turno-t1 :: Boolean, evento :: String)
end

fun busca-movimento(lm :: List<Movimento>, numero-movimento :: Number) -> Movimento:
    doc: "Dado um pokemon e o número do movimento (1 ou 2), devolve o movimento correspondente."
    cases (List<Movimento>) lm:
        | empty => none
        | link(f, r) =>
            ask:
                | numero-movimento == 1 then: f
                | otherwise: busca-movimento(r, numero-movimento - 1)
            end
    end
end

fun append-strings(ls :: List<String>) -> String:
    cases (List<String>) ls:
        | empty => ""
        | link(f, r) => string-append(f, append-strings(r))
    end
end

fun passo-batalha(b :: Batalha, is-t1 :: Boolean, numero-movimento :: Number) -> Batalha:
    doc: ""
    ask:
        | is-t1 then: 
            # O treinador 1 ataca o treinador 2
            cases (Time) b.t1.time:
                | t-empty => b # Treinador 1 sem pokemons
                | t-link(p1, rest1) =>
                    cases (Time) b.t2.time:
                        | t-empty => b # Treinador 2 sem pokemons
                        | t-link(p2, rest2) =>
                            move = busca-movimento(p1.movimentos, numero-movimento)
                            p2-resultado = aplica-movimento(p2, move)
                            efeito = cases (Movimento) move:
                                | cura(n, c) => ""
                                | ataque(n, t, p) => verifica-efeito(t, p2.tipo)
                            end
                            evento-texto = append-strings([list: p1.nome, " used ", move.nome, "\n", efeito])
                            novo-time2 = 
                                ask:
                                    | p2-resultado.hp <= 0 then: rest2 # Pokemon 2 desmaiou
                                    | otherwise: t-link(p2-resultado, rest2)
                                end
                            novo-t2 = treinador(b.t2.nome, b.t2.idade, novo-time2)
                            batalha(b.t1, novo-t2, false, evento-texto)
                    end
            end
        | otherwise:
            # O treinador 2 ataca o treinador 1
            cases (Time) b.t2.time:
                | t-empty => b # Treinador 2 sem pokemons
                | t-link(p2, rest2) =>
                    cases (Time) b.t1.time:
                        | t-empty => b # Treinador 1 sem pokemons
                        | t-link(p1, rest1) =>
                            move = busca-movimento(p2.movimentos, numero-movimento)
                            p1-resultado = aplica-movimento(p1, move)
                            efeito = cases (Movimento) move:
                                | cura(n, c) => ""
                                | ataque(n, t, p) => verifica-efeito(t, p1.tipo)
                            end
                            evento-texto = append-strings([list: p2.nome, " used ", move.nome, "\n", efeito])
                            novo-time1 = 
                                ask:
                                    | p1-resultado.hp <= 0 then: rest1 # Pokemon 1 desmaiou
                                    | otherwise: t-link(p1-resultado, rest1)
                                end
                            novo-t1 = treinador(b.t1.nome, b.t1.idade, novo-time1)
                            batalha(novo-t1, b.t2, true, evento-texto)
                    end
            end
    end
end


fun termina-batalha(b :: Batalha) -> Boolean:
    doc: "Dada uma batalha, devolve true se a batalha terminou (ou seja, se um dos treinadores não tem mais pokemons no seu time)."
    ask:
        | tamanho-time(b.t1.time) == 0 then: true
        | tamanho-time(b.t2.time) == 0 then: true
        | otherwise: false
    end
end

fun desenha-movimentos(lm :: List<Movimento>) -> Image:
    cases (List<Movimento>) lm:
        | empty => empty-image
        | link(f, r) => above(text(f.nome, 30, "black"), desenha-movimentos(r))
    end
end

fun desenha-batalha(b :: Batalha) -> Image:
    doc: "Dada uma batalha, devolve uma imagem com o nome dos treinadores, e a imagem dos seus times de pokemons."
    t1-img = desenha-time(b.t1.time)
    t2-img = desenha-time(b.t2.time)
    if tamanho-time(b.t1.time) == 0:
        text("Treinador 2 venceu!", 30, "black")
    else if tamanho-time(b.t2.time) == 0:
        text("Treinador 1 venceu!", 30, "black")
    else:
        ask:
            | b.is-turno-t1 then: 
                pokemon-name = b.t1.time.first.nome
                above(
                    above(
                        above(
                            above(text(b.t1.nome, 30, "black"), t1-img),
                            text(b.evento, 30, "black")),
                        above(text(b.t2.nome, 30, "black"), t2-img)),
                    desenha-movimentos(b.t1.time.first.movimentos))

            | otherwise:
                pokemon-name = b.t2.time.first.nome
                above(
                    above(
                        above(
                            above(text(b.t1.nome, 30, "black"), t1-img),
                            text(b.evento, 30, "black")),
                        above(text(b.t2.nome, 30, "black"), t2-img)),
                    desenha-movimentos(b.t2.time.first.movimentos))
        end
    end
end

fun on-click(b :: Batalha, key :: String) -> Batalha:
    doc: "Dada uma batalha e uma tecla pressionada, devolve a batalha resultante de aplicar o movimento correspondente a esta tecla (1 ou 2) pelo treinador cujo é o turno."
    num = string-to-number(key).value
    ask:
        | (num >= 1) and (num <= 4) then: passo-batalha(b, b.is-turno-t1, num) 
        | otherwise: b
    end
end

batalha-inicial = batalha(ash, misty, true, "Começa batalha!")

r = reactor:
  init: batalha-inicial,
  to-draw: desenha-batalha,
  on-key: on-click,
  # stop-when: termina-batalha,
  close-when-stop: true,
  seconds-per-tick: 0.1,
end

interact(r)
