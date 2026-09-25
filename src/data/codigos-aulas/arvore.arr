use context starter2024
import color from color
import color as C
include image


data Pessoa:
  # Um elemento do tipo Pessoa é:
  | null               # vazio, ou
  | pessoa(
      nome :: String,   # Nome da pessoa
      ano :: Number,    # Ano de nascimento da pessoa
      olhos :: String,  # Cor dos olhos da pessoa
      pai :: Pessoa,    # Pai da pessoa
      mae :: Pessoa)    # Mãe da pessoa
end


BETINA = pessoa("Betina", 1927, "verdes", null, null)
CARLOS = pessoa("Carlos", 1926, "verdes", null, null)
EVA = pessoa("Eva", 1960, "azuis",
      CARLOS,
      BETINA)
FRED = pessoa("Fred", 1958, "castanhos", null, null)
GUSTAVO = pessoa("Gustavo", 1988, "verdes", FRED, EVA)


fun ancestralOlhosAzuis(ps :: Pessoa) -> Boolean:
  doc: "Dada uma pessoa, verificar se ela ou algum de seus ancestrais tem olhos azuis."
  cases (Pessoa) ps:
    | null => false  # caso base
    | pessoa(n, a, o, pai, mae) => (o == "azuis") or 
      ancestralOlhosAzuis(pai) or ancestralOlhosAzuis(mae)
  end
  # Testes:
where:
  ancestralOlhosAzuis(GUSTAVO) is true
  ancestralOlhosAzuis(FRED) is false
end


# A Forma is (forma(n, t, c, a)), where:
#   n :: String   -- the name of the shape
#   t :: String   -- the type of the shape, one of:
#                    "retângulo", "triângulo", "círculo", "estrela"
#   c :: String   -- the color of the shape
#   a :: NumList  -- list of numeric arguments depending on t:
#                    - "retângulo": largura, altura
#                    - "triângulo": lado
#                    - "círculo": raio
#                    - "estrela": num-pontas, raio-interno, raio-externo
data Forma:
  | forma(
      nome :: String, 
      tipo :: String, 
      cor :: String, 
      args :: NumList
   )
end

# Uma ListaDeNúmeros é:
# - nl-empty
# - nl-link(f, r), where
#     f :: Number  -- the first element of the list
#     r :: ListaDeNúmeros -- the rest of the list
data NumList:
  | nl-empty
  | nl-link(first :: Number, rest :: NumList)
end

# A ListaDeForma is one of:
# - f-empty
# - f-link(f, r), where
#     f :: Forma       -- the first shape
#     r :: ListaDeForma  -- the rest of the list
data ListaDeForma:
  | f-empty
  | f-link(first :: Forma, rest :: ListaDeForma)
end

L1 = nl-link(60, nl-link(50, nl-empty))
R1 = forma("r1", "retângulo", "blue", L1)
R2 = forma("r1", "retângulo", "red", L1)
C1 =  forma("c1", "círculo", "red", L1)
LF1 = f-link(R1, f-link(R2, f-empty))


fun segundo(l :: NumList) -> Number:
  doc: "Retorna o segundo elemento de uma lista."
  l.rest.first
where:
  segundo(L1) is 50
end


fun desenha-retangulo(ln :: NumList, cor :: String) -> Image:
  doc: "Given a NumList with two elements [largura, altura] and a color, produces a solid rectangle image."
  rectangle(ln.first, ln.rest.first, "solid", cor)
end

fun desenha(f :: Forma) -> Image:
  doc: "Gera a imagem de uma forma.."
  ask:
    | f.tipo == "retângulo" then: desenha-retangulo(f.args, f.cor)
    | otherwise: raise("Erro")
  end
where:
  desenha(R1) is rectangle(60, 50, "solid", "blue")
  desenha(C1) raises "Erro"
end


fun desenha-lista-formas(lf :: ListaDeForma) -> Image:
  doc: "Consumes a FormaLista and draws all shapes side by side."
  cases (ListaDeForma) lf:
    | f-empty => empty-image
    | f-link(f, r) => beside(desenha(f), desenha-lista-formas(r))
  end
end


desenha-lista-formas(LF1)


fun aleatorio(x :: Number) -> Number:
  doc: "Gera número aleatório entre 0 e 255."
  num-random(255)
end


fun fun-muda-cor(fun-muda-componente :: (Number -> Number)) -> (C.Color -> C.Color):
  lam(cor :: C.Color) -> C.Color: 
    color(
      fun-muda-componente(cor.red), 
      fun-muda-componente(cor.green),
      fun-muda-componente(cor.blue),
      1)
  end
end

fun tapete-sierpinski(lado :: Number, cor :: C.Color) -> Image:
  doc: "Gera um tapete de Sierpinski."
  ask:
    | lado <= 5 then: square(lado, "solid", "black")
    | otherwise:
      NOVO_LADO = lado / 3
      T = tapete-sierpinski(NOVO_LADO, fun-muda-cor(aleatorio)(cor))
      TB = square(NOVO_LADO, "solid", cor)
      above(
        above(
          beside(T, beside(T, T)), 
          beside(T, beside(TB, T))), 
        beside(T, beside(T, T)))
  end
end

tapete-sierpinski(400, color-named("red"))
