use context starter2024

fun calculadora(x :: Number, y :: Number, op :: (Number, Number -> Number)) -> Number:
    op(x, y)
end


fun soma(x :: Number, y :: Number) -> Number:
    x + y
end

fun mult(x :: Number, y :: Number) -> Number:
    x * y
end

fun divisao(x :: Number, y :: Number) -> Number:
    x / y
end


fun mapeia(op :: (Number -> Number), l :: List<Number>) -> List<Number>:
    cases (List<Number>) l:
    | empty => empty
    | link(f, r) =>
        link(
            op(f),
            mapeia(op, r))
    end
where:
    mapeia(sqr, [list: 1, 2, 4]) is [list: 1, 4, 16]
end


fun g(x :: Number) -> Number:
    sqr((x * 2) + 7)
end