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
R2 = retangulo(3, 6, "azul", "R2")
T1 = triangulo(3, "azul", "T1")
T2 = triangulo(5, "vermelho", "T2")
E1 = elipse(2, 3, "verde", "E1")
E2 = elipse(4, 5, "amarelo", "E2")
S1 = estrela(4, "amarelo", "S1")
S2 = estrela(5, "verde", "S2")

L1 = [list: R1, T1, E1, S1]
L2 = [list: R1, R2, T1, T2, E1, E2, S1, S2]