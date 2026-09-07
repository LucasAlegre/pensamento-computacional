use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 2 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
include csv
include data-source
# Importa funções e constantes da biblioteca de heróis
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/2026-2/herois-lib2.arr")


#|
    Exercício 1
|#

fun eh-marvel(row :: Row) -> Boolean:
    doc: "Dado uma linha de tabela, devolve True se o publisher da linha for \"Marvel Comics\"."

    row["publisher"] == "Marvel Comics"
end

HEROIS-MARVEL :: Table = filter-with(HEROI-DATA, eh-marvel)

NOMES-HEROIS :: List<String> = HEROIS-MARVEL.get-column("name")
ALINHAMENTOS-HEROIS :: List<String> = HEROIS-MARVEL.get-column("alignment")

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

fun conta-alinhamentos(lista-alinhamentos :: List<String>, alinhamento :: String) -> Number:
    doc: ```Dado uma lista de alinhamentos de heróis e um alinhamento,
            devolve o número de vezes que o alinhamento aparece na lista.```
    cases (List<String>) lista-alinhamentos:
        # Caso base: Uma lista vazia contém o alinhamento procurado zero vezes.
        | empty => 0
        | link(first, rest) =>
        # Caso recursivo: Uma lista não vazia possui o seguinte número de vezes o alinhamento procurado:
            # Se o primeiro elemento da lista for o alinhamento procurado:
            if first == alinhamento:
                # 1 somado ao número de vezes que o alinhamento aparece no resto da lista
                1 + conta-alinhamentos(rest, alinhamento)
            else:
                # Caso contrário: o número de vezes que o alinhamento procurado aparece no resto da lista
                conta-alinhamentos(rest, alinhamento)
            end
    end
where:
    conta-alinhamentos([list: "good", "bad", "good", "neutral", "bad"], "good") is 2
    conta-alinhamentos(empty, "good") is 0
end


fun remove-alinhamentos-repetidos(lista-alinhamentos :: List<String>) -> List<String>:
    doc: "Dado uma lista de alinhamentos de heróis, devolve uma lista sem alinhamentos repetidos, sempre mantendo a última ocorrência de cada alinhamento na lista original."
    cases (List<String>) lista-alinhamentos:
        # Caso base: Uma lista vazia não possui alinhamentos repetidos.
        | empty => empty
        | link(first, rest) =>
            ask:
                # Se o primeiro elemento ainda aparecer no resto da lista, ele será mantido mais adiante:
                | conta-alinhamentos(rest, first) > 0 then:
                    # Retorna o resto da lista filtrada (sem o primeiro elemento)
                    remove-alinhamentos-repetidos(rest)
                | otherwise:
                    # Caso contrário: adiciona o primeiro elemento da lista ao resto da lista filtrada
                    link(first, remove-alinhamentos-repetidos(rest))
            end
    end
where:
    remove-alinhamentos-repetidos([list: "good", "bad", "good", "neutral", "bad"]) is [list: "good", "neutral", "bad"]
    remove-alinhamentos-repetidos(empty) is empty
end

# tamanho(remove-alinhamentos-repetidos(ALINHAMENTOS-HEROIS)) retorna o número de alinhamentos diferentes entre os heróis da Marvel!


#|
    Exercício 4
|#

data ListaDeImagens:
    | i-empty  # Uma lista vazia
    | i-link(first :: Image, rest :: ListaDeImagens)
end

fun cria-lista-de-cartas(nomes :: List<String>, alinhamentos :: List<String>) -> ListaDeImagens:
    doc: "Dado uma lista de nomes de heróis e uma lista dos respectivos alinhamentos, devolve uma lista de imagens de cartas."
    cases (List<String>) nomes:
        # Caso base: Se a lista de nomes for vazia, devolve uma lista de imagens vazia
        | empty => i-empty
        | link(first, rest) =>
            # Passo: Se a lista de nomes não for vazia, devolve a primeira imagem seguida da lista com as cartas do resto da lista
            i-link(
                # Cria a carta do primeiro herói e adiciona na
                cria-carta(first, alinhamentos.first),
                # lista com as imagens dos heróis restantes
                cria-lista-de-cartas(rest, alinhamentos.rest))
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

CARTAS = cria-lista-de-cartas(NOMES-HEROIS, ALINHAMENTOS-HEROIS)

desenha-lista-de-cartas(CARTAS)
