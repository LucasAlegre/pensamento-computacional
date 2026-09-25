use context starter2024




fun soma(x :: Number , y :: Number) -> Number:
    x + y
end

fun multiplica(x, y):
    x * y
end

fun magica(x :: Number, y :: Number) -> Number:
    ((2 * x) / y) + 2
end

fun calculadora(
 x :: Number,
 y :: Number, 
 op :: (Number, Number -> Number)) -> Number:
    doc: "..."
    op(x, y)
end


fun dobro(x :: Number) -> Number:
    2 * x
end

fun mapeia(op :: (Number -> Number), l :: List<Number>) -> List<Number>:
    doc: ```Dado uma lista de números,
     e uma função unária de número para número,
     aplica a função em cada elemento da lista.
    ```
    cases (List<Number>) l:
        | empty => empty
        | link(f, r) => link(
                         op(f),
                         mapeia(op, r)) 
    end
where:
    mapeia(sqr, [list: 1, 2, 3]) is [list: 1, 4, 9]
    mapeia(dobro, [list: 1, 5, 10]) is [list: 2, 10, 20]
end

fun filtra-num(criterio :: (Number -> Boolean), l :: List<Number>) -> List<Number>:
    cases (List<Number>) l:
      | empty => empty
      | link(f, r) => ask:
                        | criterio(f) then: link(f, filtra-num(criterio, r))
                        | otherwise: filtra-num(criterio, r)
                    end
    end
end