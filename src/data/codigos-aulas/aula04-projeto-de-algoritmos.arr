use context starter2024


fun area-circ(raio :: Number) -> Number:
  doc: "Dado um número de raio, computa a área de um círculo com este raio."
  3.14 * sqr(raio)
where:
  area-circ(0) is 0
end


fun area-anel(raio-ext :: Number, raio-int :: Number) -> Number:
  doc: "Dados dois números positivos, que correspondem aos raios externo e interno de um anel, respectivamente, calcular sua área. O raio externo deve ser maior que o interno."
  
  # calcula a área do círculo externo e substrai do interno
  area-circ(raio-ext) - area-circ(raio-int)
where:
  area-anel(5, 3) is 50.24
  area-anel(2, 1) is 9.42
end






fun lucro(preco :: Number) -> Number:
  doc: "Dado o preço do ingresso, retorna o lucro do espetáculo."
  receita(preco) - custo(preco)
where:
  lucro(5.0) is (5.0 * 120) - (180 + (0.04 * 120))
end

fun nro-espectadores(preco :: Number) -> Number:
  doc: "Dado o preço do ingresso, calcula o número de espectadores."
  # Público base quando o preço é 5 é 120
  # Para cada variação de 1 no preço, o público varia em 150
  120 + (150 * (5 - preco))
where:
  nro-espectadores(5) is 120
  nro-espectadores(4.9) is 135
  nro-espectadores(4.8) is 150
  nro-espectadores(5.1) is 105
end

fun receita(preco :: Number) -> Number: doc: "Dado o preço do ingresso, calcula a receita do espetáculo."
  # Receita é o número de espectadores vezes o preço do ingresso
  nro-espectadores(preco) * preco
where:
  receita(5) is 600
  receita(4.9) is 661.5
  receita(5.1) is 535.5
end

fun custo(preco :: Number) -> Number:
  doc: "Dado o preço do ingresso, calcula o custo do espetáculo."

  180 + (0.04 * nro-espectadores(preco))

where:
  custo(5) is 180 + (0.04 * 120)
  custo(4.9) is 180 + (0.04 * 135)
end 