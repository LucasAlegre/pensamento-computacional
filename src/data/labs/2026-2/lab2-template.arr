use context dcic2024

#|
    Este arquivo contém o template para a solução dos exercícios do Laboratório 2 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
include csv
include data-source
# Importa funções e constantes da biblioteca de heróis
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/herois-lib2.arr")


#|
    Exercício 1
|#

fun eh-marvel(row :: Row) -> Boolean:
    doc: "Dado uma linha de tabela, devolve True se o publisher da linha for \"Marvel Comics\"."

    false # [implemente a função!]
end

HEROIS-MARVEL :: Table = HEROI-DATA  # Filtre a tabela para conter apenas heróis da Marvel

NOMES-HEROIS :: List<String> = empty # [lista com todos os nomes de heróis da tabela (coluna `"name"`)]
ALINHAMENTOS-HEROIS :: List<String> = empty # [lista com todos os alinhamentos de heróis da tabela (coluna `"alignment"`)]

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

fun conta-alinhamentos():
    doc: ```Dado uma lista de alinhamentos de heróis e um alinhamento,
            devolve o número de vezes que o alinhamento aparece na lista.```
    # Se a lista for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento da lista]
        # [solucionar problem para] [resto da lista]
    0
where:
    # Sempre coloque testes nas suas funções!
    true is true
end


fun remove-alinhamentos-repetidos():
    doc: "Dado uma lista de alinhamentos de heróis, devolve uma lista sem alinhamentos repetidos, sempre mantendo a última ocorrência de cada alinhamento na lista original."
    # Se a lista for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento da lista]
        # [solucionar problem para] [resto da lista]
    empty
where:
    remove-alinhamentos-repetidos([list: "good", "bad", "good", "neutral", "bad"]) is [list: "good", "neutral", "bad"]
    remove-alinhamentos-repetidos(empty) is empty
end

# tamanho(remove-alinhamentos-repetidos(ALINHAMENTOS-HEROIS)) retorna o número de alinhamentos diferentes entre os heróis da Marvel!


#|
    Exercício 4
|#

# Complete a definição abaixo:
data ListaDeImagens:
    | i-empty
end

fun cria-lista-de-cartas():
    doc: "Dado uma lista de nomes de heróis e uma lista dos respectivos alinhamentos, devolve uma lista de imagens de cartas."
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

# CARTAS = cria-lista-de-cartas(NOMES-HEROIS, ALINHAMENTOS-HEROIS)

# desenha-lista-de-cartas(CARTAS)
