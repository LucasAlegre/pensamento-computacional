use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 2 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#

include image
include csv
include data-source
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib2.arr")


#|
    Exercício 1
|#

fun id-primeira-geracao(row :: Row) -> Boolean:
    doc: "Dado uma linha de tabela e um número, devolve True se o id da linha for menor que o número dado."

    row["id"] <= 151
end

POKE-GEN1 :: Table = filter-with(POKE-DATA, id-primeira-geracao)

NOMES-POKEMONS :: List<String> = POKE-GEN1.get-column("name")
TIPOS-POKEMONS :: List<String> = POKE-GEN1.get-column("type1")

#|
    Exercício 2
|#

fun tamanho(lista :: List<String>) -> Number:
    doc: "Dado uma lista de strings, devolve o tamanho da lista."
    cases (List<String>) lista:
        # Caso base: uma lista vazia tem tamanho 0.
        | empty => 0
        # Passo: O tamanho de uma lista não vazia é 1 mais o tamanho do restante.
        | link(first, rest) => 1 + tamanho(rest)
    end
where:
    tamanho([list: 1, 2, 3]) is 3
    tamanho(empty) is 0
end

#|
    Exercício 3
|#

fun conta-tipos(lista-tipos :: List<String>, tipo :: String) -> Number:
    doc: ```Dado uma lista de tipos de Pokémons e um tipo, 
            devolve o número de vezes que o tipo aparece na lista.```
    cases (List<String>) lista-tipos:
        # Caso base: Uma lista não vazia contém o tipo procurado zero vezes.
        | empty => 0
        | link(first, rest) => 
        # Caso recursivo: Uma lista não vazia possui o seguinte número de vezes o tipo procurado:
            # Se o primeiro elemento da lista for do tipo procurado: 
            if first == tipo:
                # 1 somado ao número de vezes que o tipo aparece no resto da lista
                1 + conta-tipos(rest, tipo) 
            else:
                # Caso contrários: o número de vees que o tipo procurado aparece no resto da lista
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
        # Caso base: Uma lista vazia não possui tipos repetidos.
        | empty => empty
        | link(first, rest) =>
            ask:
                # Se o primeiro elemento da lista for do tipo procurado: 
                | conta-tipos(rest, first) > 0 then: 
                    # Retorna o resto da lista filtrada (sem o primeiro elemento)
                    remove-tipos-repetidos(rest)
                | otherwise: 
                    # Caso contrário: adiciona o primeiro elemento da lista ao resto da lista filtrada
                    link(first, remove-tipos-repetidos(rest))
            end
    end
where:
    remove-tipos-repetidos([list: "FIRE", "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]) is [list: "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]
    remove-tipos-repetidos(empty) is empty
end


#|
    Exercício 4
|#

data ListaDeImagens:
    | i-empty  # Uma lista vazia
    | i-link(first :: Image, rest :: ListaDeImagens)
end

fun cria-lista-de-cartas(nomes :: List<String>, tipos :: List<String>) -> ListaDeImagens:
    doc: "Dado uma lista de nomes de Pokémons e uma lista dos respectivos tipos, devolve uma lista de imagens de cartas."
    cases (List<String>) nomes:
        | empty => i-empty
        | link(first, rest) => 
            i-link(
                # Cria a carta do primeiro Pokémon e adiciona na
                cria-carta(first, tipos.first),  
                # lista com as imagens dos Pokémons restantes
                cria-lista-de-cartas(rest, tipos.rest)) 
    end
end

fun desenha-lista-de-cartas(lista-de-cartas :: ListaDeImagens) -> Image:
    doc: "Dado uma lista de imagens de cartas, devolve uma imagem com todas as cartas lado a lado."
    cases (ListaDeImagens) lista-de-cartas:
        # Caso base: Se a lista é vazia, devolve uma imagem vazia
        | i-empty => empty-image
        # Passo: Se a lista L não stiver vazia, colocar a primeira imagem da lista ao lado da imagem gerada com as cartas (imagens) do resto da lista, lado a lado
        | i-link(first, rest) => beside(
                                    first,
                                    desenha-lista-de-cartas(rest))
    end
end

CARTAS = cria-lista-de-cartas(NOMES-POKEMONS, TIPOS-POKEMONS)

desenha-lista-de-cartas(CARTAS)

