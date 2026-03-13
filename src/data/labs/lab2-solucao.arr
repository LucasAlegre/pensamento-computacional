use context dcic2024

include image
include csv
include data-source

#|
    Este arquivo contém um modelo para a solução dos exercícios do Laboratório 2 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#


#|
    Constantes
|#

CARTA-ALT = 175
CARTA-LAR = 125

ATAQUE = "Attack"
DEFESA = "Defense"
EFEITO-NAOEFETIVO = "Not very effective"
EFEITO-EFETIVO = "Effective"
EFEITO-SUPEREFETIVO = "Super-effective!"
TYPE-NORMAL = "NORMAL"
TYPE-FIRE = "FIRE"
TYPE-WATER = "WATER"
TYPE-ELECTRIC = "ELECTRIC"
TYPE-GRASS = "GRASS"

FUNDO-NORMAL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "darkgray")
FUNDO-FIRE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "red")
FUNDO-WATER = rectangle(CARTA-LAR, CARTA-ALT, "solid", "blue")
FUNDO-ELECTRIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "yellow")
FUNDO-GRASS = rectangle(CARTA-LAR, CARTA-ALT, "solid", "green")

# Mesa redonda onde vamos desenhar as cartas
MESA = circle(20 + CARTA-ALT, "solid", "lightgray")
BORDA = rectangle(CARTA-LAR + 10, CARTA-ALT + 10, "outline", "black")

#|
    Tabela de Pokémons
|#

POKEMONS-URL = "https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv"

TABELA-POKEMONS =
 load-table: id, name, type1, type2, total, hp, attack, defense, spatck, spdef, speed,generation, legendary
    source: csv-table-url(POKEMONS-URL, default-options)
    sanitize id using num-sanitizer
    sanitize name using string-sanitizer
    sanitize type1 using string-sanitizer
    sanitize type2 using string-sanitizer
    sanitize hp using num-sanitizer
  end

POKEMON-DATA :: Table = filter-with(TABELA-POKEMONS, lam(row): row["id"] <= 50 end)

fun id-to-3-digit-string(id :: Number) -> String:
    doc: "Dado um número, devolve uma string com este número formatado com 3 dígitos (com zeros à esquerda se necessário)."
    ask:
        | id < 10 then: string-append("00", num-to-string(id))
        | id < 100 then: string-append("0", num-to-string(id))
        | otherwise: num-to-string(id)
    end
where:
    id-to-3-digit-string(1) is "001"
    id-to-3-digit-string(10) is "010"
    id-to-3-digit-string(100) is "100"
end

fun img-pokemon(id :: Number) -> Image:
    doc: "Dado o id de um pokemon, devolve a imagem deste pokemon."
    url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/" + id-to-3-digit-string(id) + ".png"
    img = image-url(url)

    scale(0.75, img)
end


fun seleciona-imagem-pokemon(nome :: String) -> Image:
    doc: "Dado o nome do pokemon, devolve a imagem correspondente a este pokemon."

    fun nome-igual(row :: Row) -> Boolean:
        doc: "Dado uma linha da tabela de pokémons, devolve True se o nome da linha for igual ao nome dado."
        row["name"] == nome
    end

    id = filter-with(POKEMON-DATA, nome-igual).row-n(0)["id"]
    img-pokemon(id)
end

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


fun cria-carta(nome :: String, tipo :: String) -> Image:
    doc: "Dado a borda da carta, o fundo escolhido referente ao tipo da carta e a String com o tipo da carta, devolve uma imagem com a carta montada (colocar o texto em cima do fundo em cima da borda)."
    # Seleciona a imagem do pokemon
    img0 = seleciona-imagem-pokemon(nome)
    # Desenha um círculo branco no centro do fundo
    im1 = overlay(circle(60, "solid", "white"), seleciona-fundo(tipo))
    # Sobrepõe a imagem do pokemon no círculo branco
    im2 = overlay(img0, im1)
    # Sobrepõe o texto do tipo na parte inferior da imagem do pokemon
    im3 = overlay-align("middle", "bottom", text(tipo, 20, "black"), im2)
    # Sobrepõe o texto do nome na parte superior da imagem do pokemon
    im4 = overlay-align("middle", "top", text(nome, 20, "black"), im3)
    # Sobrepõe a borda no centro da imagem da carta
    im5 = overlay-align("center", "center", im4, BORDA)
    im5
end

fun verifica-efeito(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    ask:
        | (tipo-ataque == TYPE-FIRE) then:
            ask:
                | (tipo-defesa == TYPE-GRASS) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-WATER) or (tipo-defesa == TYPE-FIRE) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | (tipo-ataque == TYPE-WATER) then:
            ask:
                | (tipo-defesa == TYPE-FIRE) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-GRASS) or (tipo-defesa == TYPE-WATER) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | (tipo-ataque == TYPE-ELECTRIC) then:
            ask:
                | (tipo-defesa == TYPE-WATER) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-GRASS) or (tipo-defesa == TYPE-ELECTRIC) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | (tipo-ataque == TYPE-GRASS) then:
            ask:
                | (tipo-defesa == TYPE-WATER) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-FIRE) or (tipo-defesa == TYPE-GRASS) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | otherwise: EFEITO-EFETIVO
    end
where:
    verifica-efeito(TYPE-FIRE, TYPE-GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-WATER) is EFEITO-NAOEFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-ELECTRIC) is EFEITO-EFETIVO
end


NOMES-POKEMONS :: List<String> = POKEMON-DATA.get-column("name")
TIPOS-POKEMONS :: List<String> = POKEMON-DATA.get-column("type1")


fun tamanho-lista(lista :: List<Any>) -> Number:
    doc: "Dado uma lista, devolve o tamanho da lista."
    cases (List<Any>) lista:
        | empty => 0
        | link(first, rest) => 1 + tamanho-lista(rest)
    end
where:
    tamanho-lista([list: 1, 2, 3]) is 3
    tamanho-lista(empty) is 0
end


fun conta-tipos(lista-tipos :: List<String>, tipo :: String) -> Number:
    doc: "Dado uma lista de tipos de Pokémons, devolve o número de tipos diferentes."
    cases (List<String>) lista-tipos:
        | empty => 0
        | link(first, rest) => if first == tipo:
                                 1 + conta-tipos(rest, tipo) 
                              else: 
                                 conta-tipos(rest, tipo)
                              end
    end
where:
    conta-tipos([list: "FIRE", "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"], "FIRE") is 2
    conta-tipos(empty, "FIRE") is 0
end

fun remove-tipos-repetidos(lista-tipos :: List<String>) -> List<String>:
    doc: "Dado uma lista de tipos de Pokémons, devolve uma lista sem tipos repetidos."
    cases (List<String>) lista-tipos:
        | empty => empty
        | link(first, rest) => if conta-tipos(rest, first) > 0:
                                 remove-tipos-repetidos(rest)
                              else:
                                 link(first, remove-tipos-repetidos(rest))
                              end
    end
where:
    remove-tipos-repetidos([list: "FIRE", "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]) is [list: "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]
    remove-tipos-repetidos(empty) is empty
end

remove-tipos-repetidos(TIPOS-POKEMONS)

#|
    Definição Lista de Imagens
|#

data ListaDeImagens:
    # Uma elemento de ListaDeImagens pode ser:
    | i-empty  # Uma lista vazia
    | i-link(first :: Image, rest :: ListaDeImagens)  # Uma imagem seguida de uma ListaDeImagens
end

fun cria-lista-de-cartas(nomes :: List<String>, tipos :: List<String>) -> ListaDeImagens:
    doc: "Dado uma lista de nomes de Pokémons e uma lista dos respectivos tipos, devolve uma lista de imagens de cartas."
    cases (List<String>) nomes:
        | empty => i-empty
        | link(first, rest) => i-link(
                                cria-carta(first, tipos.first),  # Cria a carta do primeiro Pokémon e adiciona na
                                cria-lista-de-cartas(rest, tipos.rest))  # lista com as imagens dos Pokémons restantes
    end
end

# cria-lista-de-cartas(NOMES-POKEMONS, TIPOS-POKEMONS)
