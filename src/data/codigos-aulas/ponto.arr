use context starter2024


data Ponto:
    | ponto2d(
        coord-x :: Number, 
        coord-y :: Number)
end


P1 :: Ponto = ponto2d(2, 0)
P2 :: Ponto = ponto2d(0, 0)

fun distancia-pontos(p1 :: Ponto, p2 :: Ponto) -> Number:
    doc: "Calcula a distância entre dois pontos."
    sqrt( 
        sqr(p1.coord-x - p2.coord-x) + 
        sqr(p1.coord-y - p2.coord-y) )
where:
    distancia-pontos(P1, P2) is 2
end

fun distancia-origem(p :: Ponto) -> Number:
    distancia-pontos(p, ponto2d(0, 0))
end
