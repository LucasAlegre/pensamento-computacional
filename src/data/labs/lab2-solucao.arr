use context dcic2024

include image
include csv
include data-source
# Importa funções e constantes da biblioteca de pokemon
import url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib2.arr") as P

#|
    Este arquivo contém um modelo para a solução dos exercícios do Laboratório 2 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#

#|
    Exercício 1
|#

fun id-primeira-geracao(row :: Row) -> Boolean:
    doc: "Dado uma linha de tabela e um número, devolve True se o id da linha for menor que o número dado."

    row["id"] <= 150
end

POKE-GEN1 :: Table = filter-with(P.POKE-DATA, id-primeira-geracao)

NOMES-POKEMONS :: List<String> = POKE-GEN1.get-column("name")
TIPOS-POKEMONS :: List<String> = POKE-GEN1.get-column("type1")

#|
    Exercício 2
|#

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
                                P.cria-carta(first, tipos.first),  # Cria a carta do primeiro Pokémon e adiciona na
                                cria-lista-de-cartas(rest, tipos.rest))  # lista com as imagens dos Pokémons restantes
    end
end

cria-lista-de-cartas(NOMES-POKEMONS, TIPOS-POKEMONS)
