use context starter2024

fun tamanho(l :: List<String>) -> Number:
    cases (List<String>) l:
        | empty => 0
        | link(f, r) => 1 + tamanho(r)
    end
end

#|
tamanho([list: "a", "b", "c"])
1 + tamanho([list: "b", "c"])
1 + 1 + tamanho([list: "c"])
1 + 1 + 1 + tamanho([list: ])
1 + 1 + 1 + 0 = 3
|#

fun contem-b(l :: List<String>) -> Boolean:
    cases (List<String>) l:
        | empty => false
        | link(f, r) => if f == "b":
                          true
                        else:
                          contem-b(r)
                        end
    end
end

fun maior(l :: List<Number>) -> Number:
    ask:
        | is-empty(l.rest) then: l.first
        | maior(l.rest) > l.first then: maior(l.rest)
        | otherwise: l.first
    end
end

fun maior2(l :: List<Number>) -> Number:
    ask:
        | is-empty(l.rest) then: l.first
        | otherwise:
            maior-do-resto = maior2(l.rest)
            ask:
                | maior-do-resto > l.first then: maior-do-resto
                | otherwise: l.first
            end
    end
end

fun ordena(l :: List<Number>) -> List<Number>:
    doc: "Dado uma lista de números, retorna a lista ordenada em ordem crescente."
    cases (List<Number>) l:
        | empty => empty
        | link(f, r) =>  insere(f, ordena(r))
    end
end

fun insere(n :: Number, l :: List<Number>) -> List<Number>:
    doc: "Dado um número e uma lista ordenada em ordem crescente, insere o número na lista mantendo-a ordenada."
    cases (List<Number>) l:
        | empty => link(n, empty)
        | link(f, r) =>  ask:
                            | n < f then: 
                                link(n, l)
                            | otherwise:
                                link(f, insere(n, r))
                        end
    end
end

ordena([list: 2, 1, 3])
insere(2, ordena([list: 1, 3]))
insere(2, insere(1, ordena([list: 3])))
insere(2, insere(1, insere(3, ordena([list:]))))
insere(2, insere(1, insere(3, empty)))
insere(2, insere(1, [list: 3]))
insere(2, link(1, [list: 3]))
insere(2, [list: 1, 3])
link(1, insere(2, [list: 3]))
link(1, [list: 2, 3])
[list: 1, 2, 3]

