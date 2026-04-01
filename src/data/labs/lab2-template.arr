use context dcic2024

#|
    Este arquivo contém o template para a solução dos exercícios do Laboratório 2 de INF05008 - Pensamento Computacional.

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

    false
end

POKE-GEN1 :: Table = POKE-DATA  # Filtre a tabela para conter apenas pokémons da primeira geração

NOMES-POKEMONS :: List<String> = empty
TIPOS-POKEMONS :: List<String> = empty

#|
    Exercício 2
|#

fun tamanho(lista :: List<Any>) -> Number:
    doc: "Dado uma lista, devolve o tamanho da lista."

    0
where:
    tamanho(empty) is 0
end

#|
    Exercício 3
|#

fun conta-tipos(lista-tipos :: List<String>, tipo :: String) -> Number:
    doc: ```Dado uma lista de tipos de Pokémons e um tipo, 
            devolve o número de vezes que o tipo aparece na lista.```
    
    0
where:
    conta-tipos([list: "FIRE", "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"], "FIRE") is 2
    conta-tipos(empty, "FIRE") is 0
end


fun remove-tipos-repetidos(lista-tipos :: List<String>) -> List<String>:
    doc: "Dado uma lista de tipos de Pokémons, devolve uma lista sem tipos repetidos."
    
    empty
where:
    remove-tipos-repetidos([list: "FIRE", "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]) is [list: "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]
    remove-tipos-repetidos(empty) is empty
end


#|
    Exercício 4
|#

data ListaDeImagens:
    | i-empty
    # Completar a definição
end

fun cria-lista-de-cartas(nomes :: List<String>, tipos :: List<String>) -> ListaDeImagens:
    doc: "Dado uma lista de nomes de Pokémons e uma lista dos respectivos tipos, devolve uma lista de imagens de cartas."
    
    i-empty
end

fun desenha-lista-de-cartas(lista-de-cartas :: ListaDeImagens) -> Image:
    doc: "Dado uma lista de imagens de cartas, devolve uma imagem com todas as cartas lado a lado."
    
    empty-image
end

CARTAS = cria-lista-de-cartas(NOMES-POKEMONS, TIPOS-POKEMONS)

desenha-lista-de-cartas(CARTAS)
