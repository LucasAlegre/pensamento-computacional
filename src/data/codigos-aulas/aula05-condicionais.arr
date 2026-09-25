use context starter2024

fun is-5(n :: Number) -> Boolean:
  doc: "Dado um número verifica se ele é 5."
  n == 5
where:
  is-5(5) is true
  is-5(2) is false
end


fun between-5-and-6(n :: Number) -> Boolean:
  doc: "Dado um número verifica se ele está entre 5 e 6."
  (n > 5) and (n < 6)
where:
  between-5-and-6(5.2) is true
  between-5-and-6(5) is false
  between-5-and-6(0) is false
end


fun between-5-and-6-or-over-10(n :: Number) -> Boolean:
  doc: "Dado um número verifica se ele está entre 5 e 6 ou é maior que 10."
  between-5-and-6(n) or (n > 10)
where:
  between-5-and-6-or-over-10(5.5) is true
  between-5-and-6-or-over-10(11) is true
  between-5-and-6-or-over-10(7) is false
end


fun double-or-triple(n :: Number) -> Number:
  doc: "Dado um número retorna o dobro se for par ou o triplo se for ímpar."
  if (n > 10):
    n * 2
  else:
    n * 3
  end
where:
  double-or-triple(12) is 12 * 2
  double-or-triple(4) is 4 * 3
end



fun taxa-juros(valor :: Number) -> Number:
  doc: "Dado um valor de depósito, retorna a taxa de juros correspondente."
  if (valor <= 1000):
    0.04
  else if (valor <= 5000):
    0.045
  else:
    0.05
  end
where:
  taxa-juros(800) is 0.04
  taxa-juros(3000) is 0.045
  taxa-juros(6000) is 0.05
end

fun taxa-juros2(valor :: Number) -> Number:
  doc: "Dado um valor de depósito, retorna a taxa de juros correspondente."
  ask:
    | (valor <= 1000) then: 0.04
    | (valor <= 5000) then: 0.045
    | otherwise: 0.05
  end
where:
  taxa-juros2(800) is 0.04
  taxa-juros2(3000) is 0.045
  taxa-juros2(6000) is 0.05
end



fun f(n :: Number) -> Number:
  2 * g(n)
end

fun g(n :: Number) -> Number:
  ask:
    | n == 1 then: n
    | n > 2 then: n - 1
    | otherwise: n - 2
  end
end
