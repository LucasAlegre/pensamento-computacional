use context starter2024

# 3 + 3 * 5 -> Erro
3 + (3 * 5)  # Correto


# Figuras

circle(30, "solid", "red")

circle(30, "outline", "blue")

rectangle(30, 30, "solid", "green")

star(50, "solid", "Pale Green")

# Composição

overlay(
  rectangle(30, 30, "solid", "green"), 
  star(50, "solid", "yellow"))

beside(
  rectangle(30, 30, "solid", "green"), 
  star(50, "solid", "yellow"))

above(
  rectangle(30, 30, "solid", "green"), 
  star(50, "solid", "yellow"))

# Bandeiras

barra_branca = rectangle(30, 60, "solid", "white")
barra_azul = rectangle(30, 60, "solid", "blue")
barra_vermelha = rectangle(30, 60, "solid", "red")
barra_verde = rectangle(30, 60, "solid", "darkgreen")
barra_preta = rectangle(30, 60, "solid", "black")
barra_amarela = rectangle(30, 60, "solid", "gold")

fun beside3(i1, i2, i3):
  beside(i1, (beside(i2, i3)))
end

beside(beside(barra_azul, barra_branca), barra_vermelha)

bandeira_franca = beside3(barra_azul, barra_branca, barra_vermelha)
bandeira_belgica = beside(beside(barra_preta, barra_amarela), barra_vermelha)
bandeira_nigeria = beside(beside(barra_verde, barra_branca), barra_verde)
bandeira_italia = 
  beside(
    beside(
      barra_verde, 
      barra_branca), 
    barra_vermelha)

bandeira_italia
bandeira_belgica
bandeira_franca
bandeira_nigeria


#bandeira_italia = 
#  beside(
#    beside(
#      rectangle(30, 60, "solid", "darkgreen"),
#      rectangle(30, 60, "solid", "white")), 
#    rectangle(30, 60, "solid", "red"))
#```


fun barra(cor :: String) -> Image: 
  rectangle(30, 60, "solid", cor)
end
  



