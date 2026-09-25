use context starter2024


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

# Ex 1:

V1 = venc-perecivel(100, 100, 100)
P1 = produto("Ovos", 01, 0.5, V1)

V2 = quant(50)
P2 = produto("Papel Higiênico", 02, 30.0, V2)

# 2a)
fun produto-preco(p :: Produto) -> Number:
    doc: "Dado um produto, retorna o preço"

    p.preco
where:
    produto-preco(P1) is 0.5
    produto-preco(P2) is 30
end

# 2b)
fun total-produtos(q :: QuantidadeVencimento) -> Number:
    doc: "Dado uma quantidade de vencimento, retorna o total em estoque."

    cases (QuantidadeVencimento) q:
        | quant(n) => n
        | venc-perecivel(m, p, s) => m + p + s
    end
where:
    total-produtos(V1) is 300
    total-produtos(V2) is 50
end

#2c)

fun valor-estoque(p :: Produto) -> Number:
    doc: "Dado um produto, retorna o valor total em estoque."

    total-produtos(p.quant) * p.preco
where:
    valor-estoque(P1) is 150
    valor-estoque(P2) is 1500
end

fun diminui-preco-30(p :: Produto, d :: Number) -> Produto:
  doc: "Diminui o preço do produto p em 30%."
  produto(p.nome, p.cod, p.preco * (1 - d), p.quant)
end

# 2d) 
fun aplica-desconto(p :: Produto) -> Produto:
    doc: "..."

    cases (QuantidadeVencimento) p.quant:
        | quant(n) => p
        | venc-perecivel(m, pr, s) => 
            ask:
                | m > 30 then: diminui-preco-30(p, 0.3)
                | otherwise: p
            end
    end
where:
    aplica-desconto(P1) is produto("Ovos", 01, 0.35, V1)
end

data Resposta:
    | numero-itens(n1 :: Number, n2 :: Number)
    | erro(s :: String)
end

fun vencem-este-mes(p1 :: Produto, p2 :: Produto) -> Resposta:
    => numero-itens(total-produtos(p1), total-produtos(p2))
    => erro("Erro: produto não perecível.")
end