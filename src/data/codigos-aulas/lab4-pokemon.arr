
use context dcic2024

import color from color
import color as C
include image
include csv
include data-source


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
    | pokemon(nome :: String, id :: Number, tipo :: TipoPokemon, hp :: Number)
end

bulbasaur = pokemon("Bulbasaur", 1, GRASS, 45)
charmander = pokemon("Charmander", 4, FIRE, 39)
squirtle = pokemon("Squirtle", 7, WATER, 44)
mewtwo = pokemon("Mewtwo", 150, PSYCHIC, 106)
pikachu = pokemon("Pikachu", 25, ELECTRIC, 35)
voltorb = pokemon("Voltorb", 100, ELECTRIC, 40)
gengar = pokemon("Gengar", 94, POISON, 60)

data Movimento:
    # Um elemento de movimento tem o formato:
    | ataque(nome :: String, tipo :: TipoPokemon, poder :: Number)
    | cura(nome :: String, cura :: Number)
end

# Constante ataques
ember = ataque("Ember", FIRE, 40)
tackle = ataque("Tackle", NORMAL, 40)


data Time:
    | t-empty
    | t-link(first :: Pokemon, rest :: Time)
end

data Treinador:
    | treinador(nome :: String, idade :: Number, time :: Time)
end

time1 = t-link(bulbasaur, t-link(charmander, t-link(squirtle, t-link(mewtwo, t-empty))))
time2 = t-link(pokemon("Psyduck", 54, WATER, 50), t-empty)
time3 = t-link(pikachu, t-link(voltorb, t-link(gengar, t-empty)))

ash = treinador("Ash", 10, time1)
misty = treinador("Misty", 11, time2)

fun tamanho-time(time :: Time) -> Number:
    doc: "Dado um time, devolve o número de pokemons neste time."
    cases (Time) time:
        | t-empty => 0
        | t-link(first, rest) => 1 + tamanho-time(rest)
    end
end

fun numero-pokemons-tipo(time :: Time, tipo :: TipoPokemon) -> Number:
    doc: "Dado um time e um tipo de pokemon, devolve o número de pokemons neste time que são deste tipo."
    cases (Time) time:
        | t-empty => 0
        | t-link(first, rest) =>
            ask:
                | first.tipo == tipo then: 1 + numero-pokemons-tipo(rest, tipo)
                | otherwise: numero-pokemons-tipo(rest, tipo)
            end
    end
end

fun id-to-3-digit-string(id :: Number) -> String:
    doc: "Dado um número, devolve uma string com este número formatado com 3 dígitos (com zeros à esquerda se necessário)."
    ask:
        | id < 10 then: string-append("00", num-to-string(id))
        | id < 100 then: string-append("0", num-to-string(id))
        | otherwise: num-to-string(id)
    end
end

fun img-pokemon(id :: Number) -> Image:
    doc: "Dado o id de um pokemon, devolve a imagem deste pokemon."
    url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/" + id-to-3-digit-string(id) + ".png"
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

desenha-time(ash.time)

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
                | verifica-efeito(tipo, p.tipo) == EFEITO-SUPEREFETIVO then: pokemon(p.nome, p.id, p.tipo, p.hp - (poder * 2))
                | verifica-efeito(tipo, p.tipo) == EFEITO-NAOEFETIVO then: pokemon(p.nome, p.id, p.tipo, p.hp - (poder * 0.5))
                | otherwise: pokemon(p.nome, p.id, p.tipo, p.hp - poder)
            end
        | cura(nome, c) => pokemon(p.nome, p.id, p.tipo, num-min(100, p.hp + c))
    end
end

fun desenha-movimento(p1 :: Pokemon, p2 :: Pokemon, move :: Movimento) -> Image:
    doc: "Dado um pokemon atacante, um pokemon defensor e um movimento, gera uma imagem mostrando o resultado de aplicar este movimento do pokemon atacante sobre o pokemon defensor (mostrar os pokemons antes de aplicar o movimento, o nome do movimento e o resultado do movimento: se é super efetivo, não efetivo, etc)."
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
            overlay-align("center", "center", beside-cartas, MESA)
    end
end

desenha-movimento(bulbasaur, charmander, tackle)



#|
    Alta Ordem
|#  


fun my-filter(t :: Time, f :: (Pokemon -> Boolean)) -> Time:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um booleano, devolve um time com apenas os pokemons deste time para os quais esta função devolve true."
    cases (Time) t:
        | t-empty => t-empty
        | t-link(first, rest) =>
            ask:
                | f(first) then: t-link(first, my-filter(rest, f))
                | otherwise: my-filter(rest, f)
            end
    end
end

fun my-map(t :: Time, f :: (Pokemon -> Any)) -> List<Any>:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um pokemon, devolve um time com os pokemons deste time transformados por esta função."
    cases (Time) t:
        | t-empty => empty
        | t-link(first, rest) => link(f(first), my-map(rest, f))
    end
end

fun my-fold(t :: Time, f :: (Pokemon, Any -> Any), acc :: Any) -> Any:
    doc: "Dado um time, uma função que recebe um pokemon e um acumulador e devolve um novo acumulador, e um valor inicial para o acumulador, devolve o resultado de aplicar esta função a todos os pokemons deste time, usando o valor inicial dado como acumulador."
    cases (Time) t:
        | t-empty => acc
        | t-link(first, rest) => my-fold(rest, f, f(first, acc))
    end
end

fun lista-eletrico(t :: Time) -> Time:
    doc: "Dado um time, devolve um time com apenas os pokemons do tipo elétrico deste time."
    my-filter(t, lam(p): p.tipo == ELECTRIC end)
end

fun nomes-pokemon-eletricos(t :: Time) -> List<String>:
    doc: "Dado um time, devolve uma lista com os nomes dos pokemons do tipo elétrico deste time."
    my-map(lista-eletrico(t), lam(p): p.nome end)
where:
    nomes-pokemon-eletricos(time1) is empty
    nomes-pokemon-eletricos(time3) is [list: "Pikachu", "Voltorb"]
end

fun desenha-pokemons-eletricos(t :: Time) -> Image:
    doc: "Dado um time, gera uma imagem com as cartas dos pokemons do tipo elétrico deste time empilhadas (colocar a carta do primeiro pokemon do time em cima)."
    my-fold(lista-eletrico(t),
      lam(p, acc): beside(desenha-carta(p), acc) end,
      empty-image)
end

desenha-pokemons-eletricos(time3)

fun soma-hp(t :: Time) -> Number:
    doc: "Dado um time, devolve a soma do hp de todos os pokemons deste time."
    my-fold(t,
      lam(p, acc): p.hp + acc end,
      0)
end

type Conteudo = List<Entrada>

data Entrada:
    | diretorio(nome :: String, conteudo :: Conteudo)
    | arquivo(nome :: String, pokemon :: Pokemon)
end


pokedex :: Entrada = diretorio("Pokedex", [list:
    diretorio("Kanto", [list:
        arquivo("Bulbasaur.txt", bulbasaur),
        arquivo("Charmander.txt", charmander),
        arquivo("Squirtle.txt", squirtle)
    ]),
    diretorio("Outros", [list:
        arquivo("Mewtwo.txt", mewtwo),
        arquivo("Pikachu.txt", pikachu),
        arquivo("Voltorb.txt", voltorb),
        arquivo("Gengar.txt", gengar)
    ])
])

fun arquivo-encontrado(conteudo :: Conteudo, nome :: String) -> Boolean:
    doc: "Dados o Conteudo de um diretorio e um nome de arquivo, verifica se existe um arquivo com este nome neste conteúdo de diretório, sem considerar subdiretorios"
    cases (Conteudo) conteudo:
        | empty => false
        | link(f, r) =>
            cases (Entrada) f:
                | diretorio(nomeD, conteudoD) => arquivo-encontrado(r, nome)
                | arquivo(nomeA, p) =>
                    ask:
                        | nomeA == nome then: true
                        | otherwise: arquivo-encontrado(r, nome)
                    end
            end
    end
end

fun arquivo-encontrado-no-diretorio(e :: Entrada, nome :: String) -> Boolean:
    doc: "Dado um diretorio e um nome de arquivo, verifica se existe um arquivo com este nome neste diretório ou em qualquer subdiretório deste diretório"
    cases (Entrada) e:
        | diretorio(nomeD, conteudoD) =>
            arquivo-encontrado-no-conteudo(conteudoD, nome)
        | arquivo(nomeA, p) => nomeA == nome
    end
where:
    arquivo-encontrado-no-diretorio(pokedex, "Mewtwo.txt") is true
    arquivo-encontrado-no-diretorio(pokedex, "Psyduck.txt") is false
end

fun arquivo-encontrado-no-conteudo(c :: Conteudo, nome :: String) -> Boolean:
    doc: "Dado um Conteudo e um nome de arquivo, verifica se existe um arquivo com este nome neste Conteudo ou em qualquer subdiretório deste Conteudo"
    cases (Conteudo) c:
        | empty => false
        | link(f, r) =>
            cases (Entrada) f:
                | diretorio(nomeD, conteudoD) =>
                    arquivo-encontrado-no-diretorio(f, nome) or arquivo-encontrado-no-conteudo(r, nome)
                
                | arquivo(nomeA, p) =>
                    ask:
                        | nomeA == nome then: true
                        | otherwise: arquivo-encontrado-no-conteudo(r, nome)
                    end
            end
    end
where:
    arquivo-encontrado-no-conteudo(pokedex.conteudo, "Mewtwo.txt") is true
    arquivo-encontrado-no-conteudo(pokedex.conteudo, "Psyduck.txt") is false
end

fun mostra-diretorio(e :: Entrada) -> Image:
    doc: "Dado um diretorio, gera uma imagem mostrando o nome deste diretorio e as imagens dos arquivos contidos diretamente neste diretorio (sem considerar subdiretorios)"
    cases (Entrada) e:
        | diretorio(nomeD, conteudoD) =>
            above-align("left",
              text(nomeD, 20, "black"),
              beside(
                    text("             ", 15, "white"),
                mostra-conteudo(conteudoD)))
        | arquivo(nomeA, p) => mostra-arquivo(e)
    end
end

fun mostra-conteudo(c :: Conteudo) -> Image:
    doc: "Dado um Conteudo, gera uma imagem mostrando as imagens dos arquivos contidos diretamente neste Conteudo (sem considerar subdiretorios)"
    cases (Conteudo) c:
        | empty => empty-image
        | link(f, r) =>
            above-align("left",
                cases (Entrada) f:
                    | diretorio(nomeD, conteudoD) => mostra-diretorio(f)
                    | arquivo(nomeA, p) => mostra-arquivo(f)
                end,
                mostra-conteudo(r)
            )
    end
end

fun mostra-arquivo(e :: Entrada) -> Image:
    doc: "Dado um arquivo, gera uma imagem mostrando o nome deste arquivo e a carta do pokemon contido neste arquivo"
    cases (Entrada) e:
        | diretorio(nomeD, conteudoD) => text(nomeD, 20, "black")
        | arquivo(nomeA, p) => 
            above-align("left", 
                text(string-append("|->", nomeA), 20, "darkblue"), 
                desenha-carta(p))
    end
end

mostra-diretorio(pokedex)


fun conta-arquivos-pokedex(e :: Entrada) -> Number:
    doc: "Dado um diretorio, conta o número de arquivos neste diretório, considerando também os subdiretórios"
    cases (Entrada) e:
        | diretorio(nomeD, conteudoD) => conta-arquivos(conteudoD)
        | arquivo(nomeA, p) => 1
    end
where:
    conta-arquivos-pokedex(pokedex) is 7
end

fun conta-arquivos(conteudo :: Conteudo) -> Number:
    doc: "Dados o Conteudo de um diretorio, conta o número de arquivos neste conteúdo de diretório, considerando também os subdiretórios"
    cases (Conteudo) conteudo:
        | empty => 0
        | link(f, r) =>
            cases (Entrada) f:
                | diretorio(nomeD, conteudoD) => conta-arquivos(conteudoD) + conta-arquivos(r)
                | arquivo(nomeA, p) => 1 + conta-arquivos(r)
            end
    end
where:
    conta-arquivos(pokedex.conteudo) is 7
end

fun cria-todos-pokemons(tabela :: Table) -> Time:
    doc: "Dada uma tabela de pokemons, devolve um time com todos os pokemons desta tabela."
    fun loop(i :: Number) -> Time:
        ask:
            | i > 300 then: t-empty
            | otherwise: t-link(pokemon-from-table(i, tabela), loop(i + 1))
        end
    end
    loop(1)
end


fun adiciona-diretorio(e :: Entrada, nome :: String) -> Entrada:
    doc: "Dado um diretorio e um nome de diretório, devolve um novo diretorio igual a este diretorio mas com um novo subdiretório com este nome adicionado a este diretório, caso já não exista um subdiretório com este nome neste diretório."
    cases (Entrada) e:
        | diretorio(nomeD, conteudoD) =>
            ask:
                | nomeD == nome then: e
                | otherwise: diretorio(nomeD, adiciona-diretorio-no-conteudo(conteudoD, nome))
            end
        | arquivo(nomeA, p) => e
    end
end

fun adiciona-diretorio-no-conteudo(conteudo :: Conteudo, nome :: String) -> Conteudo:
    doc: "Dado um Conteudo e um nome de diretório, devolve um novo Conteudo igual a este Conteudo mas com um novo subdiretório com este nome adicionado a este Conteudo, caso já não exista um subdiretório com este nome neste Conteudo."
    cases (Conteudo) conteudo:
        | empty => link(diretorio(nome, empty), empty)
        | link(f, r) =>
            cases (Entrada) f:
                | diretorio(nomeD, conteudoD) =>
                    ask:
                        | nomeD == nome then: link(f, r)
                        | otherwise: link(f, adiciona-diretorio-no-conteudo(r, nome))
                    end
                | arquivo(nomeA, p) => link(f, adiciona-diretorio-no-conteudo(r, nome))
            end
    end
end

fun adiciona-arquivo-no-diretorio(e :: Entrada, a :: Entrada, nome-dir :: String) -> Entrada:
    cases (Entrada) e:
        | diretorio(nomeD, conteudoD) =>
            ask:
                | nomeD == nome-dir then: diretorio(nomeD, link(a, conteudoD))
                | otherwise: diretorio(nomeD, adiciona-arquivo(conteudoD, a, nome-dir))
            end
        | arquivo(nomeA, p) => e
    end
end

fun adiciona-arquivo(conteudo :: Conteudo, a :: Entrada, nome-dir :: String) -> Conteudo:
    doc: "Dado um Conteudo e um arquivo, devolve um novo Conteudo igual a este Conteudo mas com este arquivo adicionado a este Conteudo (assumir que não existe um arquivo com o nome deste arquivo neste Conteudo)."
    cases (Conteudo) conteudo:
        | empty => empty
        | link(f, r) => 
            cases (Entrada) f:
                | diretorio(nomeD, conteudoD) =>
                    ask:
                        | nomeD == nome-dir then: 
                            link(adiciona-arquivo-no-diretorio(f, a, nome-dir), r)
                        | otherwise: link(f, adiciona-arquivo(r, a, nome-dir))
                    end
                | arquivo(nomeA, p) => link(f, adiciona-arquivo(r, a, nome-dir))
            end
    end
end

fun adiciona-pokemon(e :: Entrada, p :: Pokemon) -> Entrada:
    doc: "Dado uma pokedex e um pokemon, devolve uma nova pokedex igual a esta pokedex mas com um novo arquivo para este pokemon adicionado a esta pokedex (assumir que não existe um arquivo com o nome deste pokemon seguido de '.txt' nesta pokedex)."
    cases (Entrada) e:
        | diretorio(nomeD, conteudoD) =>
            dir-name = tipo-to-string(p.tipo)
            diretorio-atualizado = adiciona-diretorio(e, dir-name)

            adiciona-arquivo-no-diretorio(
                diretorio-atualizado, 
                arquivo(string-append(p.nome, ".txt"), p),
                dir-name)
            
        | arquivo(nomeA, poke) => e
    end
end


fun cria-pokedex(lista :: Time) -> Entrada:
    doc: "Dado um time, cria um diretorio com o nome 'Pokedex' e um arquivo para cada pokemon deste time, onde o nome do arquivo é o nome do pokemon seguido de '.txt' e o conteúdo do arquivo é o pokemon correspondente."
    pokedex-dir = diretorio("Pokedex", empty)
    fun loop(t :: Time, pokedex-aux :: Entrada) -> Entrada:
        cases (Time) t:
            | t-empty => pokedex-aux
            | t-link(p, rest) => 
                adiciona-pokemon(
                    loop(rest, pokedex-aux),
                    p
                )
        end
    end
    loop(lista, pokedex-dir)
end


todos-pokemons :: Time = cria-todos-pokemons(pokemon-data)

mostra-diretorio(cria-pokedex(todos-pokemons))
