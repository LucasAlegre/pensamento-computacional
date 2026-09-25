use context starter2024

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

fun custo(preco :: Number) -> Number:
  doc: "Dado o preço do ingresso, calcula o custo do espetáculo."
  # Custo fixo do espetáculo é 180
  # Acrescenta 0.04 por espectador
  
  180 + (0.04 * nro-espectadores(preco))
where:
  custo(5) is 184.8
  custo(4.9) is 185.4
  custo(5.1) is 184.2
end

fun receita(preco :: Number) -> Number:
  doc: "Dado o preço do ingresso, calcula a receita do espetáculo."
  # Receita é o número de espectadores vezes o preço do ingresso
  nro-espectadores(preco) * preco
where:
  receita(5) is 600
  receita(4.9) is 661.5
  receita(5.1) is 535.5
end


fun lucro(preco :: Number) -> Number:
  doc: "Dado o preço do ingresso, retorna o lucro do espetáculo."
  # Lucro é a diferença entre receita e custo
  receita(preco) - custo(preco)
where:
  lucro(5) is 415.2
  lucro(4.9) is 476.1
  lucro(5.1) is 351.3
end
