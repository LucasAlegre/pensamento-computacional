use context dcic2024


data Carta:
    carta(
        naipe :: String, # Naipe da carta
        numero :: Number  # Número da carta
    )
end

# Exemplos de elementos de Carta:
AS-COPAS = carta("copas", 1)
DEZ-OUROS = carta("ouro", 10)
RAINHA-PAUS = carta("paus", 12)


data PilhaDeCartas:
    | vazia
    | elo(first :: Carta, rest :: PilhaDeCartas)
end

P1 = elo(RAINHA-PAUS, 
        elo(DEZ-OUROS, 
           elo(AS-COPAS, 
              vazia)))

fun tem-copas(p :: PilhaDeCartas) -> Boolean:
    doc: "Dado uma pilha de cartas, verifica se há uma carta de copas."
    cases (PilhaDeCartas) p:
        # Se a pilha é vazia, devolver false
        | vazia => false
        | elo(f, r) =>
            ask:
                # Se o naipe da primeira carta é copas, devolver true
                | string-equal(f.naipe, "copas") then: true
                # Senão, verificar se tem copas no resto da pilha p
                | otherwise: tem-copas(r)
            end
    end
where:
    tem-copas(P1) is true
    tem-copas(vazia) is false
end

fun tem-naipe(p :: PilhaDeCartas, naipe :: String) -> Boolean:
    doc: "Dado uma pilha de cartas e um naipe, verifica se há uma carta deste naipe."
    cases (PilhaDeCartas) p:
        # Se a pilha é vazia, devolver false
        | vazia => false
        | elo(f, r) =>
            ask:
                # Se o naipe da primeira carta é naipe, devolver true
                | string-equal(f.naipe, naipe) then: true
                # Senão, verificar se tem naipe no resto da pilha p
                | otherwise: tem-naipe(r, naipe)
            end
    end
where:
    tem-naipe(P1, "copas") is true
    tem-naipe(vazia, "copas") is false
end

fun eh-ouros(c :: Carta) -> Boolean:
    doc: "Dada uma carta, verifica se o seu naipe é ouro."
    string-equal(c.naipe, "ouro")
end

fun filtra-ouros(p :: PilhaDeCartas) -> PilhaDeCartas:
    doc: "Dado uma pilha de cartas, devolve uma nova pilha contendo apenas as cartas de ouros."
    cases (PilhaDeCartas) p:
        # Se a pilha é vazia, devolver vazia
        | vazia => vazia
        | elo(f, r) =>
            ask:
                # Se o naipe da primeira carta é ouro, 
                # construir uma nova pilha com esta carta 
                # e com as cartas de ouros do resto da pilha p
                | eh-ouros(f) then: elo(f, filtra-ouros(r))
                # Senão, devolver as cartas de ouros do resto da pilha p
                | otherwise: filtra-ouros(r)
            end
    end
end


fun filtra(p :: PilhaDeCartas, criterio :: (Carta -> Boolean)) -> PilhaDeCartas:
    doc: "Dado uma pilha de cartas e um critério, devolve uma nova pilha contendo apenas as cartas que satisfazem o critério."
    cases (PilhaDeCartas) p:
        # Se a pilha é vazia, devolver vazia
        | vazia => vazia
        | elo(f, r) =>
            ask:
                # Se a primeira carta satisfaz o critério, 
                # construir uma nova pilha com esta carta 
                # e com as cartas que satisfazem o critério do resto da pilha p
                | criterio(f) then: elo(f, filtra(r, criterio))
                # Senão, devolver as cartas que satisfazem o critério do resto da pilha p
                | otherwise: filtra(r, criterio)
            end
    end
end

fun filtraX(p :: PilhaDeCartas, s :: String) -> PilhaDeCartas:
    cases (PilhaDeCartas) p:
        | vazia => vazia
        | elo(f, r) =>
            ask:
               | (s == "eh-ouros") and (f.naipe == "ouros") then: elo(f, filtraX(r, s))
               | (s == "eh-copas") and (f.naipe == "copas") then: elo(f, filtraX(r, s))
               | (s == "eh-paus") and (f.naipe == "paus") then: elo(f, filtraX(r, s))
               | (s == "eh-espadas") and (f.naipe == "espadas") then: elo(f, filtraX(r, s))
               | otherwise: filtraX(r, s)
            end
    end
end


fun g(x :: Number) -> Number: x * x end

#fun g-linha(x :: Number) -> Number: 2 * x end

fun d-dx-no-ponto(f :: (Number -> Number), x :: Number) -> Number:
    epsilon = 0.00001

    (f(x + epsilon) - f(x)) / epsilon
where:
    d-dx-no-ponto(g, 10) is-roughly 2 * 10
end

fun d-dx(f :: (Number -> Number)) -> (Number -> Number):
  epsilon = 0.00001

  lam(x :: Number) -> Number:
    (f(x + epsilon) - f(x)) / epsilon
  end
end

g-linha = d-dx(g)

check:
    g-linha(10) is-roughly 20
end



shuttle :: Table = table: month, riders
  row: "Jan", 1123
  row: "Feb", 1045
  row: "Mar", 1087
  row: "Apr", 999
end

filter-with(shuttle, lam(r): r["riders"] < 1000 end)

# lam(x1, ..., xn): e end

lam(x): x + 1 end

lam(x): x + 1 end(2)

check:
 filter(num-is-positive, [list: 1, -2, 3, -4]) is [list: 1, 3]
 filter(lam(s): string-length(s) > 3 end, [list: "hi", "hello", "hey"]) is [list: "hello"]
end

check:
   # map(sqr, [list: 2, 4, -5, 10]) is [list: 4, 16, 25, 100]
   map(lam(s): s + "!" end, [list: "hi", "hello", "hey"]) is [list: "hi!", "hello!", "hey!"]
end

check:
    fold(lam(x, y): x + y end, 0, [list: 1, 2, 3, 4]) is 10
    fold(num-max, 0, [list: 2, 1, 10, -4]) is 10
    fold(string-append, "", [list: "hi", " ", "there"]) is "hi there"
end

fun my-filter(criterio :: (Number -> Boolean), l :: List<Number>) -> List<Number>:
    doc: "Dados um critério e uma lista de números, devolve uma nova lista contendo apenas os elementos da lista que satisfazem o critério."
    cases (List<Number>) l:
      | empty => empty
      | link(f, r) => ask:
                        | criterio(f) then: link(f, my-filter(criterio, r))
                        | otherwise: my-filter(criterio, r)
                    end
    end
end

fun my-map(funcao :: (Number -> Number), l :: List<Number>) -> List<Number>:
    doc: "Dados uma função unária de número para número e uma lista de números, devolve uma nova lista contendo o resultado da aplicação da função a cada elemento da lista."
    cases (List<Number>) l:
        | empty => empty
        | link(f, r) => link(
                         funcao(f),
                         my-map(funcao, r)) 
    end
end

fun my-fold(funcao :: (Number, Number -> Number), valor-inicial :: Number, l :: List<Number>) -> Number:
    doc: "Dados uma função binária de número para número, um valor inicial e uma lista de números, devolve o resultado da aplicação da função a cada elemento da lista, começando pelo valor inicial."
    cases (List<Number>) l:
        | empty => valor-inicial
        | link(f, r) => my-fold(funcao, funcao(f, valor-inicial), r)
    end
end

fun soma(x, y): x + y end

fold(soma, 0, [list: 1, 2, 3])


fold(string-append, "", [list: "hi", " ", "there"])
