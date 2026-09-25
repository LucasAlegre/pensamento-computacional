use context starter2024

# Q1 - 2.0 - completar código

# Um elemento do tipo List<Number> é:
# | empty
# | link(first :: Number, rest :: List<Number>)

fun tamanho(l :: List<Number>) -> Number:
    doc: "Dado uma lista de números, retorna o número de elementos na lista."
    cases (List<Number>) l:
        | empty => 0
        | link(f, r) => 1 + tamanho(r)
    end
end

fun primeiros-n(l :: List<Number>, n :: Number) -> List<Number>:
    doc: "Dado uma lista de números e um número n, retorna uma lista com os primeiros n elementos da lista. Se a lista tiver menos de n elementos, retorna a própria lista."
    cases (List<Number>) l:
        | empty => empty
        | link(f, r) => 
            ask:
                | n <= 0 then: empty
                | otherwise: link(f, primeiros-n(r, n - 1))
            end
    end
where:
    primeiros-n([list: 1, 2, 3, 4, 5], 3) is [list: 1, 2, 3]
    primeiros-n([list: 1, 2], 0) is empty
end

fun remove-primeiros-n(l :: List<Number>, n :: Number) -> List<Number>:
    doc: "Dado uma lista de números e um número n, retorna uma lista com os elementos da lista sem os primeiros n elementos. Se a lista tiver menos de n elementos, retorna a lista vazia."
    cases (List<Number>) l:
        | empty => empty
        | link(f, r) => 
            ask:
                | n <= 0 then: link(f, r)
                | otherwise: remove-primeiros-n(r, n - 1)
            end
    end
where:
    remove-primeiros-n([list: 1, 2, 3, 4, 5], 3) is [list: 4, 5]
    remove-primeiros-n([list: 1, 2], 3) is empty
end

fun busca-binaria(l :: List<Number>, num :: Number) -> Boolean:
    doc: "Dado uma lista de números ordenada em ordem crescente e um número, retorna true se o número está na lista e false caso contrário."
    cases (List<Number>) l:
        | empty => false
        | link(f, r) => 
            meio = num-floor(tamanho(l) / 2) # O índice do meio da lista
            ask:
                | l.get(meio) == num then: true
                | l.get(meio) > num then: busca-binaria(primeiros-n(l, meio), num)
                | otherwise: busca-binaria(remove-primeiros-n(l, meio + 1), num)
            end
    end
where:
    busca-binaria([list: 1, 2, 3, 4, 5], 3) is true
    busca-binaria([list: 1, 2, 3, 4, 5], 6) is false
end


# Q2 (1.2 ponto)

# V ou F justifique

# (F) - A função busca-binaria implementa recursão estrutural.
# (V) - A função tamanho implementa recursão estrutural.
# (V) - As funções tamanho e primeiros-n, no pior caso, realizam O(n) chamadas recursivas, onde n é o número de elementos da lista.
# (F) - É impossível criar um programa que reutilize a função busca-binaria para resolver o problema de encontrar uma string em uma lista de strings.

# Q3 (0.8 ponto) - Escreva um argumento de terminação para a função busca-binaria.

# A função busca-binaria:
# - Possui casos base: quando a lista é vazia, a função retorna false, e quando o elemento do meio da lista é igual ao número buscado, a função retorna true. Nesses casos, a função termina.
# - Em cada chamada recursiva, a função reduz o tamanho da lista pela metade (lista de tamanho 1 gera lista vazia), sempre se aproximando de um caso base. Portanto, a função garantidamente chegará a um caso base.
# - As funções auxiliares tamanho, primeiros-n e remove-primeiros-n também terminam (pois implementam recursão estrutural), assim como ask, link, >, ==, .get, +, /.

# Q4 (6 pontos)

# a) 1 ponto
data AB:
    | vazia
    | no(
        nome :: String,
        idade :: Number,
        id :: Number,
        esq :: AB,
        dir :: AB
    )
end

P3 = no("C", 3, 30, vazia, vazia)
P2 = no("B", 2, 31, vazia, vazia)
P1 = no("A", 1, 32, P2, P3)

# b) 2 pontos

fun busca-idade(ab :: AB, nome :: String) -> Number:
    doc: "Dado uma AB e o nome de uma pessoa, retorna a idade dessa pessoa. Se a pessoa não está na árvore, deve retornar -1."
    cases (AB) ab:
        | vazia => -1
        | no(n, i, id, e, d) =>
            busca-esq = busca-idade(e, nome)
            busca-dir = busca-idade(d, nome)
            ask:
                | n == nome then: id
                | busca-esq <> -1 then: busca-esq
                | busca-dir <> -1 then: busca-dir
                | otherwise: -1
            end                   
    end
where:
    busca-idade(P1, "C") is 30
    busca-idade(P1, "X") is -1
end

# c) 2 pontos

fun nomes-maior-que-20(ab :: AB) -> List<String>:
    doc: "Dado uma AB, retorna uma lista com o nome de todas as pessoas com idade maior que 20."
    cases (AB) ab:
        | vazia => empty
        | no(n, i, id, e, d) => 
            nomes-esq = nomes-maior-que-20(e)
            nomes-dir = nomes-maior-que-20(d)
            ask:
                | id > 20 then: [list: n] + nomes-esq + nomes-dir
                | otherwise: nomes-esq + nomes-dir
            end
    end
where:
    nomes-maior-que-20(vazia) is empty
    nomes-maior-que-20(P1) is [list: "A", "B", "C"]
end

# d) 1 pontos

# Para transformar a AB em uma ABP, seria necessário adicionar a restrição de que, para um dado nodo, os nodos na sua sub-árvore esquerda tenham sempre numeros de "id" menores que seu id, e os nodos na sua sub-árvore direita tenham sempre números de "id" maiores que seu id.
# Exemplo:
# P3 = no("C", 3, 3, vazia, vazia)
# P2 = no("B", 2, 1, vazia, vazia)
# P1 = no("A", 1, 2, P2, P3)