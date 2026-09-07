use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 2 de INF05008 - Pensamento Computacional.

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

NOMES-HEROIS :: List<String> = coluna-heroi("name")
ALINHAMENTOS-HEROIS :: List<String> = coluna-heroi("alignment")
RACAS-HEROIS :: List<String> = coluna-heroi("race")

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
    tamanho([list: "a", "b", "c"]) is 3
    tamanho(empty) is 0
end

#|
    Exercício 3
|#

fun conta-racas(lista-racas :: List<String>, raca :: String) -> Number:
    doc: ```Dado uma lista de raças de heróis e uma raça,
            devolve o número de vezes que a raça aparece na lista.```
    cases (List<String>) lista-racas:
        # Caso base: Uma lista vazia contém a raça procurada zero vezes.
        | empty => 0
        | link(first, rest) =>
        # Caso recursivo: Uma lista não vazia possui o seguinte número de vezes a raça procurada:
            # Se o primeiro elemento da lista for a raça procurada:
            if first == raca:
                # 1 somado ao número de vezes que a raça aparece no resto da lista
                1 + conta-racas(rest, raca)
            else:
                # Caso contrário: o número de vezes que a raça procurada aparece no resto da lista
                conta-racas(rest, raca)
            end
    end
where:
    conta-racas([list: "Human", "Mutant", "Alien", "Mutant", "Human"], "Human") is 2
    conta-racas(empty, "Human") is 0
end

conta-racas(RACAS-HEROIS, "Human")
conta-racas(RACAS-HEROIS, "Mutant")
conta-racas(RACAS-HEROIS, "Alien")



fun remove-racas-repetidas(lista-racas :: List<String>) -> List<String>:
    doc: "Dado uma lista de raças de heróis, devolve uma lista sem raças repetidas, sempre mantendo a última ocorrência de cada raça na lista original."
    cases (List<String>) lista-racas:
        # Caso base: Uma lista vazia não possui raças repetidas.
        | empty => empty
        | link(first, rest) =>
            ask:
                # Se o primeiro elemento ainda aparecer no resto da lista, ele será mantido mais adiante:
                | conta-racas(rest, first) > 0 then:
                    # Retorna o resto da lista filtrada (sem o primeiro elemento)
                    remove-racas-repetidas(rest)
                | otherwise:
                    # Caso contrário: adiciona o primeiro elemento da lista ao resto da lista filtrada
                    link(first, remove-racas-repetidas(rest))
            end
    end
where:
    remove-racas-repetidas([list: "Human", "Mutant", "Alien", "Mutant", "Human"]) is [list: "Alien", "Mutant", "Human"]
    remove-racas-repetidas(empty) is empty
end

tamanho(remove-racas-repetidas(RACAS-HEROIS)) # retorna o número de raças diferentes entre os heróis da Marvel!


#|
    Exercício 4
|#

data ListaDeImagens:
    | i-empty  # Uma lista vazia
    | i-link(first :: Image, rest :: ListaDeImagens)
end

fun cria-lista-de-cartas(nomes :: List<String>) -> ListaDeImagens:
    doc: "Dado uma lista de nomes de heróis, devolve uma lista de imagens de cartas."
    cases (List<String>) nomes:
        # Caso base: Se a lista de nomes for vazia, devolve uma lista de imagens vazia
        | empty => i-empty
        | link(first, rest) =>
            # Passo: Se a lista de nomes não for vazia, devolve a primeira imagem seguida da lista com as cartas do resto da lista
            i-link(
                # Cria a carta do primeiro herói e adiciona na
                cria-carta(first),
                # lista com as imagens dos heróis restantes
                cria-lista-de-cartas(rest))
    end
end

fun desenha-lista-de-cartas(lista-de-cartas :: ListaDeImagens) -> Image:
    doc: "Dado uma lista de imagens de cartas, devolve uma imagem com todas as cartas lado a lado."
    cases (ListaDeImagens) lista-de-cartas:
        # Caso base: Se a lista é vazia, devolve uma imagem vazia
        | i-empty => empty-image
        # Passo: Se a lista não estiver vazia, colocar a primeira imagem da lista ao lado da imagem gerada com as cartas (imagens) do resto da lista, lado a lado
        | i-link(first, rest) => beside(
                                    first,
                                    desenha-lista-de-cartas(rest))
    end
end

CARTAS = cria-lista-de-cartas(NOMES-HEROIS)

desenha-lista-de-cartas(CARTAS)
