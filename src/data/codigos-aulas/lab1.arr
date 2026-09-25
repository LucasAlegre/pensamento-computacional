use context starter2024

# Constantes

IMG_PULA_VEZ = text("Ø", 60, "black")
IMG_COMPRA2 = text("+2", 60, "black")
IMG_INVERTE = text("«", 60, "black")
IMG_CURINGA = empty-image
IMG_CURINGA_COMPRA4 = text("+4", 60, "black")

# Exercício 1

PULA_VEZ = -1
COMPRA2 = -2
INVERTE = -3
CURINGA = -5
CURINGA_COMPRA4 = -4

# Questão: Por que não é necessário definir contratos, objetivos ou exemplos aqui?
# Resposta: Porque não estamos definindo funções, e sim constantes, ou seja, estamos dando nomes para alguns valores.

# Exercício 2

CIRCULO_BRANCO = circle(40, "solid", "white")

QUADRADOS_COLORIDOS =
  above(
    beside(
      rectangle(50, 75, "solid", "red"),
      rectangle(50, 75, "solid", "green")),
    beside(
      rectangle(50, 75, "solid", "yellow"),
      rectangle(50, 75, "solid", "blue"))
  )

CONTORNO_PRETO = rectangle(110, 160, "outline", "black")


# Exercício 3

fun traduz-cor(cor :: String) -> String:
  doc: "Dada uma cor, que pode ser amarelo, verde, vermelho, azul ou 4cores, retorna a respectiva cor em ingles, ou seja, blue, green, yellow, red ou 4colors."
  ask:
    | cor == "azul" then: "blue"
    | cor == "verde" then: "green"
    | cor == "vermelho" then: "red"
    | cor == "amarelo" then: "yellow"
    | otherwise: "4colors"
  end
where:
  traduz-cor("vermelho") is "red"
  traduz-cor("verde") is "green"
  traduz-cor("4cores") is "4colors"
end


# Exercício 4

fun escolhe-fundo(cor :: String) -> Image:
  doc: "Dada uma cor, que pode ser amarelo, verde, vermelho, azul ou 4cores gera a imagem de fundo para uma carta de UNO desta cor."
  overlay-align("center", "center",
    overlay-align("center", "center",
      CIRCULO_BRANCO,
      if cor == "4cores":
        QUADRADOS_COLORIDOS
      else:
        rectangle(100, 150, "solid", traduz-cor(cor))
      end
      ),
    CONTORNO_PRETO
  )
where:
  escolhe-fundo("vermelho") is overlay(overlay(CIRCULO_BRANCO, rectangle(100, 150, "solid", "red")), CONTORNO_PRETO) # desenha o fundo de uma carta vermelha
end


fun escolhe-fundo-v2(cor :: String) -> Image:
    doc: "Dada uma cor, que pode ser amarelo, verde, vermelho, azul ou 4cores gera a imagem de fundo para uma carta de UNO desta cor."
  if cor == "4cores":
    overlay(CIRCULO_BRANCO, overlay(QUADRADOS_COLORIDOS, CONTORNO_PRETO))
  else:
    overlay(
      CIRCULO_BRANCO,
      overlay(
        rectangle(100, 150, "solid", traduz-cor(cor)),
        CONTORNO_PRETO
        )
      )
  end
where:
  escolhe-fundo("vermelho") is overlay(overlay(CIRCULO_BRANCO, rectangle(100, 150, "solid", "red")), CONTORNO_PRETO) # desenha o fundo de uma carta vermelha
end

# Exercício 5

fun desenha-carta(num :: Number, cor :: String) -> Image:
  doc: "Dados um número e uma cor, representando uma carta de UNO, gera uma imagem para esta carta."
  overlay-align("center", "center",
    escolhe-simbolo(num),
    escolhe-fundo(cor)
  )
where:
  desenha-carta(7, "vermelho") is overlay-align(
    "center", "center",
    escolhe-simbolo(7),
    escolhe-fundo("vermelho")
  )
end


fun escolhe-simbolo(num :: Number) -> Image:
  doc: "Dado um número, que pode ser de 0 a 9 ou as constantes referentes às cartas especiais de UNO, devolve uma imagem que representa este número na carta."
  ask:
    | (num >= 0) and (num <= 9) then: text(num-to-string(num), 70, "black")
    | num == COMPRA2 then: IMG_COMPRA2
    | num == INVERTE then: IMG_INVERTE
    | num == PULA_VEZ then: IMG_PULA_VEZ
    | num == CURINGA then: IMG_CURINGA
    | num == CURINGA_COMPRA4 then: IMG_CURINGA_COMPRA4    
  end
end

# Exercício 6

fun jogada-valida(mao-num :: Number, mao-cor :: String,
                 mesa-num :: Number, mesa-cor :: String) -> Boolean:
  doc: "A função analisa duas cartas e verifica se é possível jogar uma sobre a outra."
  ask:
    | mao-cor == "4cores" then: true
    | mesa-cor == "4cores" then: true
    | (mao-cor == mesa-cor) or (mao-num == mesa-num) then:true
    | otherwise: false
  end
end


# Outra versão para esta função, sem usar condicional

fun jogada-valida-v2(mao-num :: Number, mao-cor :: String, mesa-num :: Number, mesa-cor :: String) -> Boolean:
  doc: "A função analiza duas cartas e verifica se é possível jogar uma sobre a outra."
  (mao-cor == "4cores")
  or (mesa-cor == "4cores")
  or (mao-cor == mesa-cor)
  or (mao-num == mesa-num)
end

# Exercício 7

fun mostra-jogada(mao-num :: Number, mao-cor :: String, mesa-num :: Number, mesa-cor :: String) -> Image:
  doc: ```
       A função analiza duas cartas (representadas por 4 argumentos: um número e uma string, representando a carta da mesa e um número e uma string, representando a carta da mão, nesta ordem) e verifica se é possível jogar uma sobre a outra, de acordo com as regras do UNO, desenhando uma imagem mostrando as cartas e se é possível fazer a jogada ou não.
       ```
  beside(
    beside(
      beside(
        text("Carta da mão: ", 20, "black"),
        desenha-carta(mao-num, mao-cor)),
      beside(
        text("   Carta da mesa: ", 20, "black"),
        desenha-carta(mesa-num, mesa-cor))),
    if jogada-valida(mao-num, mao-cor, mesa-num, mesa-cor):
      text("   É possível jogar esta carta!", 20, "green")
    else:
      text("   Não é possível jogar esta carta!", 20, "red")
    end
  )
end


mostra-jogada(CURINGA, "4cores", 2, "vermelho")