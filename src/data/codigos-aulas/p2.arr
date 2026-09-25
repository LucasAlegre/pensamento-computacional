use context starter2024


# Completar (1.0)

# V ou F (2.0)

# Código (6)
    # Dados (tipo misto e lista) (2.0)
    # Atualiza estrutura (2.0)
    # Filter/map sem alta-ordem (2.0)

# Filter/map com alta-ordem da função da questão 1 (1.0)
# só o corpo da função e contrato, sem teste
# Dá o teste e o objetivo, e pede o contrato e o corpo da função

data Prato:
    | principal(
        nome :: String,      # Nome do prato
        calorias :: Number,  # Quantidade de calorias do prato
        preco :: Number,      # Preço do prato
        vegetariano :: Boolean # Indica se o prato é vegetariano ou não
    )
    | sobremesa(
        nome :: String,      # Nome da sobremesa
        calorias :: Number,  # Quantidade de calorias da sobremesa
        preco :: Number      # Preço da sobremesa
    )
end

data ListaDePratos:
    | vazia
    | elo(first :: Prato, rest :: ListaDePratos)
end

PRATO1 = prato("Salada", 150, 10.0, true)
PRATO2 = prato("Hambúrguer", 500, 20.0, false)
PRATO3 = prato("Pizza", 300, 15.0, false)

L1 = elo(PRATO1, elo(PRATO2, elo(PRATO3, vazia)))

fun atualiza-prato(p :: Prato) -> Prato:
    doc: "Dado um prato e um novo preço, devolve um novo prato com o preço atualizado."
    cases (Prato) p:
        | principal(n, c, pr, v) => principal(n, c, p.preco * 2, v)
        | sobremesa(n, c, pr) => sobremesa(n, c, p.preco)
    end
end

fun atualiza-prato-caros(l :: ListaDePratos) -> ListaDePratos:
    doc: "Dada uma lista de pratos, devolve uma nova lista onde os pratos com mais de 15.0 de preço têm seu preço atualizado para 15.0."
    cases (ListaDePratos) l:
        | vazia => vazia
        | elo(f, r) =>
            ask:
                | f.preco > 15.0 then: elo(atualiza-prato(f, 15.0), atualiza-prato-caros(r))
                | otherwise: elo(f, atualiza-prato-caros(r))
            end
    end
end

fun atualiza-prato-caros(l :: ListaDePratos, criterio :: (Prato -> Boolean)) -> ListaDePratos:
    doc: "Dada uma lista de pratos, devolve uma nova lista onde os pratos com mais de 15.0 de preço têm seu preço atualizado para 15.0."
    cases (ListaDePratos) l:
        | vazia => vazia
        | elo(f, r) =>
            ask:
                | criterio(f) then: elo(atualiza-prato(f, 15.0), atualiza-prato-caros(r))
                | otherwise: elo(f, atualiza-prato-caros(r))
            end
    end
end