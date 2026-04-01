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

NOMES-POKEMONS :: List<String> = empty # [lista com todos os nomes de pokemons da tabela (coluna `"name"`)]
TIPOS-POKEMONS :: List<String> = empty # [lista com todos os tipos de pokemons da tabela (coluna `"type1"`)]

#|
    Exercício 2
|#

fun tamanho(lista :: List<String>) -> Number:
    doc: "Dado uma lista de strings, devolve o tamanho da lista."
    # Se a lista for vazia, então seu tamanho é 0

    # Senão, o tamanho da lista é a soma de:
        # 1
        # tamanho do resto da lista
    
    0
where:
    tamanho(empty) is 0
    # Complete os testes/exemplos!
end

#|
    Exercício 3
|#

fun conta-tipos():
    doc: ```Dado uma lista de tipos de Pokémons e um tipo, 
            devolve o número de vezes que o tipo aparece na lista.```
    # Se a lista for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento da lista]
        # [solucionar problem para] [resto da lista]
    0
where:
    # Sempre coloque testes nas suas funções!
    true is true
end


fun remove-tipos-repetidos():
    doc: "Dado uma lista de tipos de Pokémons, devolve uma lista sem tipos repetidos, sempre mantendo a última ocorrência de cada tipo na lista original."
    # Se a lista for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento da lista]
        # [solucionar problem para] [resto da lista]
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

fun cria-lista-de-cartas():
    doc: "Dado uma lista de nomes de Pokémons e uma lista dos respectivos tipos, devolve uma lista de imagens de cartas."
    # Se a lista de nomes for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento de cada lista]
        # [solucionar problem para] [resto de cada lista]
    i-empty
end

fun desenha-lista-de-cartas():
    doc: "Dado uma lista de imagens de cartas, devolve uma imagem com todas as cartas lado a lado."
    # Se a lista de imagens for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento da lista]
        # [solucionar problem para] [resto da lista]
    empty-image
end

# Descomente as linhas abaixo ao terminar de implementar as funções:

# CARTAS = cria-lista-de-cartas(NOMES-POKEMONS, TIPOS-POKEMONS)

# desenha-lista-de-cartas(CARTAS)
