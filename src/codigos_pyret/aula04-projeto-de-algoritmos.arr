use context starter2024



fun area-circ(raio :: Number) -> Number:
  doc: "Dado um número de raio, computa a área de um círculo com este raio."
  3.14 * sqr(raio)
end
examples:
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
