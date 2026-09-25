use context dcic2024

fun desconto(valor :: Number, p :: Number) - > Number:
  doc: "Dado um valor e um percentual de desconto, retorna o valor com o desconto aplicado."
  valor * (1 - p)
where:
  desconto(100, 0.1) is 90
  desconto(100, 0.5) is 50
end

fun categoria(valor :: Number) -> String:
  doc: "..."
  ask:
    | valor > 30 then: "Caro"
    | (valor <= 30) and (valor >= 25) then: "Normal"
    | otherwise: "Barato"
  end
where:
  categoria(32) is "Caro"
  categoria(26) is "Normal"
  categoria(24) is "Barato"
end


data ListaDePrecos:
  | vazia
  | elo(first :: Number, rest :: ListaDePrecos)
end

L1 = vazia
L2 = elo(32.0, elo(26, elo(24, vazia)))
L3 = elo(3, vazia)

fun encontra-caro(ldp :: ListaDePrecos) -> Number:
  doc: "..."
  cases (ListaDePrecos) ldp:
    | vazia => 0
    | elo(f, r) => 
      ask:
        | categoria(f) == "Caro" then: desconto(f, 0.2)
        | otherwise: encontra-caro(r)
      end
  end
where:
  encontra-caro(L1) is 0
  encontra-caro(L2) is desconto(32, 0.2) 
end