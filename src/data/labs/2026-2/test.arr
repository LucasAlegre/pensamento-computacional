use context starter2024


#|
  Exercício Final da Aula
|#

data QuantidadeVencimento:
  # Um elemento do conjunto QuantidadeVencimento tem o formato:
  | quant(n :: Number)   # Onde n é a quantidade de itens não perecíveis
  # ou
  | venc-perecivel(mes :: Number, prox :: Number, seg :: Number) 
  # Onde mes, prox e seg são a quantidade de itens que vencem no mês, próximo mês e meses seguintes.
end

data Produto:
  # Um elemento do conjunto Produto tem o formato:
  produto(
    nome :: String,                       # Nome do produto
    cod :: Number,                        # Código do produto
    preco :: Number,                      # Preço do produto
    quant :: QuantidadeVencimento         # Quantidade e vencimento do produto
  )
end

v-azeite :: QuantidadeVencimento = venc-perecivel(50, 330, 500)
v-sal :: QuantidadeVencimento = venc-perecivel(10, 500, 200)
v-caderno :: QuantidadeVencimento = quant(103)

caderno :: Produto = produto("Caderno", 2999, 3.0, v-caderno)
azeite :: Produto = produto("Azeite", 3547, 7.45, v-azeite)
sal :: Produto = produto("Sal", 3245, 5.0, v-sal)

fun preco(p :: Produto) -> Number:
    doc: "Dado um produto, retorna o preco"

    p.preco
where:
    preco(caderno) is 3.0
    preco(azeite) is 7.45
end

fun quantidade(q :: QuantidadeVencimento) -> Number:
    cases (QuantidadeVencimento) q:
    | quant(n) => n
    | venc-perecivel(m, p, s) => m + p + s
    end
where:
    quantidade(v-caderno) is 103
end

fun quantidade-estoque(p :: Produto) -> Number:
    quantidade(p.quant)
where:
    quantidade-estoque(caderno) is 103
    quantidade-estoque(azeite) is 880
end

fun valor-estoque(p :: Produto) -> Number:
    quantidade-estoque(p) * p.preco
where:
    valor-estoque(caderno) is 309.0
    valor-estoque(azeite) is 6556
end

# a)

fun preco(p :: Produto) -> Number:
  doc: "Retorna o preço do produto p."
  p.preco
where:
  preco(caderno) is 3.0
  preco(azeite) is 7.45
  preco(sal) is 5.0
end

# b)

fun quantidade(q :: QuantidadeVencimento) -> Number:
  doc: "Retorna a quantidade total de itens do produto."
  cases (QuantidadeVencimento) q:
    # Se for um produto não perecível, retorna a quantidade diretamente
    | quant(n) => n
    # Se for um produto perecível, soma as quantidades de todas as categorias
    | venc-perecivel(mes, prox, seg) => mes + prox + seg
  end
where:
  quantidade(v-caderno) is 103
  quantidade(v-azeite) is 880
  quantidade(v-sal) is 710
end

# c)

fun valor-estoque(p :: Produto) -> Number:
  doc: "Calcula o valor total do estoque do produto p."
  preco(p) * quantidade(p.quant)
where:
  valor-estoque(caderno) is 309.0
  valor-estoque(azeite) is 6556.0
  valor-estoque(sal) is 3550.0
end

# d)

fun diminui-preco-30(p :: Produto) -> Produto:
  doc: "Diminui o preço do produto p em 30%."
  produto(p.nome, p.cod, p.preco * 0.7, p.quant)
end

fun atualiza-preco(p :: Produto) -> Produto:
  doc: "Dado um produto, se o produto for perecível e o estoque maior que 30, baixa o preço em 30%, caso contrário, mantém o preço inalterado."
  # Se o produto for perecível e a quantidade total for maior que 30, reduz o preço em 30%
  cases (QuantidadeVencimento) p.quant:
    | venc-perecivel(mes, prox, seg) =>
      ask:
      | quantidade(p.quant) > 30 then: diminui-preco-30(p)
      | otherwise: p
      end
    | quant(n) => p
  end
where:
    atualiza-preco(azeite).preco is 5.215
    atualiza-preco(caderno).preco is 3.0
end

# e) 

fun zera-estoque(p :: Produto) -> Produto:
  doc: "Dado um produto, se o produto for perecível, zera o estoque do mês, caso contrário, mantém o produto inalterado."
  cases (QuantidadeVencimento) p.quant:
    # se p é um produto perecível, montar um novo registro de produto
    | venc-perecivel(mes, prox, seg) => produto(p.nome, p.cod, p.preco, venc-perecivel(0, prox, seg))
    # caso contrário, devolver o registro inalterado
    | quant(n) => p
  end
where:
  zera-estoque(azeite).quant is venc-perecivel(0, 330, 500)
  zera-estoque(caderno).quant is quant(103)
end

# f)

data Resposta:
  # Um elemento do conjunto Resposta tem o formato:
  | vencem-agora(q1 :: Number, q2 :: Number)  # Onde q1 é a quantidade do produto 1 que vence neste mês e q2 é a quantidade do produto 2 que vence neste mês
  # Ou
  | erro(msg :: String)  # Onde msg é uma mensagem de erro
end

fun vencimento-neste-mes(p1 :: Produto, p2 :: Produto) -> Resposta:
  doc: ```Dado dois produtos, retorna a quantidade de itens que vencem neste mês para cada produto. Se algum dos produtos não for perecível, retorna a mensagem "Erro: produto não perecível."```
  ask:
  | is-venc-perecivel(p1.quant) and is-venc-perecivel(p2.quant) then:
      vencem-agora(p1.quant.mes, p2.quant.mes)
  | otherwise:
      erro("Erro: produto não perecível.")
  end
where:
  vencimento-neste-mes(azeite, sal) is vencem-agora(50, 10)
  vencimento-neste-mes(caderno, sal) is erro("Erro: produto não perecível.")
  vencimento-neste-mes(azeite, caderno) is erro("Erro: produto não perecível.")
end