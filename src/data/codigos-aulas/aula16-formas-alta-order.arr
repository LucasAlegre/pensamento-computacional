use context starter2024

data Forma:
  | retangulo(
      base :: Number,    # tamanho da base do retângulo
      altura :: Number,  # tamanho da altura do retângulo
      cor :: String,     # cor do retângulo
      nome :: String)    # identificador do retângulo
  | triangulo(
      lado :: Number,    # tamanho do lado do triângulo
      cor :: String,     # cor do triângulo
      nome :: String)    # identificador do triângulo
  | elipse(
      largura :: Number, # tamanho da largura da elipse
      altura :: Number,  # tamanho da altura da elipse
      cor :: String,     # cor da elipse
      nome :: String)    # identificador da elipse
  | estrela(
      lado :: Number,    # tamanho do lado da estrela
      cor :: String,     # cor da estrela
      nome :: String)    # identificador da estrela
end

# Tipo Lista de Formas:
type ListaForma = List<Forma>

R1 = retangulo(4, 5, "vermelho", "R1")
R2 = retangulo(300, 600, "azul", "R2")
T1 = triangulo(3, "azul", "T1")
T2 = triangulo(5, "vermelho", "T2")
E1 = elipse(2, 3, "verde", "E1")
E2 = elipse(4, 5, "amarelo", "E2")
S1 = estrela(4, "amarelo", "S1")
S2 = estrela(5, "verde", "S2")

L1 :: ListaForma = [list: R1, T1, E1, S1]
L2 :: ListaForma = [list: R1, R2, T1, T2, E1, E2, S1, S2]


fun troca-laranja(f :: Forma) -> Forma:
    cases (Forma) f:
    | retangulo(b, a, c, n) => retangulo(b, a, "laranja", n)
    | triangulo(l, c, n) => triangulo(l, "laranja", n)
    | elipse(l, a, c, n) => elipse(l, a, "laranja", n)
    | estrela(l, c, n) => estrela(l, "laranja", n)
    end
end

fun ret-quarenta(f :: Forma) -> Boolean:
    if is-retangulo(f):
        if f.base > 40:
            true
        else:
            false
        end
    else:
        false
    end
end

fun filtra(l :: ListaForma, criterio :: (Forma -> Boolean)) -> ListaForma:
    cases (ListaForma) l:
        | empty => empty
        | link(f, r) =>
            if criterio(f):
                link(f, filtra(r, criterio))
            else:
                filtra(r, criterio)
            end
    end
where:
    filtra(L1, is-retangulo) is [list: R1]
end



fun mapear(l :: ListaForma, func :: (Forma -> Any)) -> List<Any>:
    cases (ListaForma) l:
    | empty => empty
    | link(f, r) =>
        link(func(f), mapear(r, func))
    end
end


fun g(x :: Number) -> Number: x * x end

fun h(x :: Number) -> Number:
    (x * x) - (sqrt(x) + 7)
end

fun g-linha(x :: Number) -> Number: 2 * x end

fun d-dx-no-ponto(f :: (Number -> Number), x :: Number) -> Number:
    epsilon = 0.0000001
    (f(x + epsilon) - f(x)) / epsilon
where:
    d-dx-no-ponto(g, 10) is-roughly g-linha(10)
end

fun d-dx(f :: (Number -> Number)) -> (Number -> Number):
  epsilon = 0.00001
  lam(x :: Number) -> Number:
    (f(x + epsilon) - f(x)) / epsilon
  end



fun gera-img(l :: ListaForma, cor :: String) -> Image:
    doc: "Dado uma lista de forma, gera uma imagem das formas desta cor lado a lado"

    lista-filtrada = filter(lam(x): x.cor == cor end, l)
    lista-imagens = map(desenha, lista-filtrada)

    fold(beside, empty-image, lista-imagens)
end