use context dcic2024

# Definições Locais

fun raizes(a :: Number, b :: Number, c :: Number) -> List<Number>:
  doc: "Dado os coeficientes de uma equação quadrática, retorna as suas raízes."
  ask:
  | (num-sqr(b) - ((4 * a) * c)) < 0 then: empty # lista vazia
  | (num-sqr(b) - ((4 * a) * c)) == 0 then: [list: ((0 - b) / (2 * a))]
  | otherwise:
    [list:  ((0 - b) + num-sqrt(num-sqr(b) - ((4 * a) * c))) / (2 * a),
            ((0 - b) - num-sqrt(num-sqr(b) - ((4 * a) * c))) / (2 * a)]
  end
end

fun raizes-v2(a :: Number, b :: Number, c :: Number) -> List<Number>:
  doc: "Dado os coeficientes de uma equação quadrática, retorna as suas raízes."
  delta = num-sqr(b) - ((4 * a) * c)

  ask:
  | delta < 0 then: empty # lista vazia
  | delta == 0 then: [list: ((0 - b) / (2 * a))]
  | otherwise:
    raiz1 = ((0 - b) + num-sqrt(delta)) / (2 * a)
    raiz2 = ((0 - b) - num-sqrt(delta)) / (2 * a)
    [list: raiz1, raiz2]
  end
end

PI = 3.14
MESA = circle(200, "solid", "lightgray")
fun media(a :: Number, b :: Number) -> Number:
  doc: "Dado dois números, retorna a média entre eles."
  (a + b) / 2
end
