use context starter2024

#|
    Constantes
|#

PULA_VEZ = "Ø"
COMPRA2 = "+2"
INVERTE = "«"
CURINGA_COMPRA4 = "+4"
CURINGA = ""

CIRCULO_BRANCO = circle(40, "solid", "white")
QUADRADOS_COLORIDOS = above(
    beside(rectangle(50, 75, "solid", "red"), rectangle(50, 75, "solid", "green")),
    beside(rectangle(50, 75, "solid", "yellow"), rectangle(50, 75, "solid", "blue"))
)
CONTORNO_PRETO = rectangle(110, 160, "outline", "black")


fun escolhe-fundo(carta :: CartaUNO) -> Image:
    doc: "Dada uma carta, gera a imagem de fundo para uma carta de UNO desta cor."

    ask:
        | is-carta-curinga(carta) then: QUADRADOS_COLORIDOS
        | otherwise: rectangle(100, 150, "solid", traduz-cor(carta.cor))
    end
end

fun escolhe-simbolo(carta :: CartaUNO) -> Image:
    doc: "Dada uma carta UNO, devolve uma imagem que representa este número/simbolo na carta."
    cases (CartaUNO) carta:
        | carta-normal(cor, valor) => text(num-to-string(valor), 70, "black")
        | carta-especial(cor, simbolo) => text(simbolo, 60, "black")
        | carta-curinga(simbolo) => text(simbolo, 60, "black")
    end
end

fun desenha-carta(carta :: CartaUNO) -> Image:
    doc: "Dada uma carta de UNO, gera uma imagem para esta carta."
    overlay(
        escolhe-simbolo(carta),
        escolhe-fundo(carta)
    )
end

#|
    Exercício 1
|#

data CartaUNO:
    # Um elemento de CartaUNO tem o formato:
    | carta-normal(cor :: String, valor :: Number)
    # onde cor é uma das seguintes: "vermelho", "verde", "azul", "amarelo", e valor é um número entre 0 e 9.; ou
    | carta-especial(cor :: String, simbolo :: String)
    # onde cor é uma das seguintes: "vermelho", "verde", "azul", "amarelo", e simbolo é um dos seguintes: "Ø" (pula vez), "+2" (compra 2), "«" (inverte); ou
    | carta-curinga(simbolo :: String)
    # onde simbolo é um dos seguintes: "+4" (curinga compra 4) ou "" (curinga normal)
end

# Constantes do tipo CartaUNO
CARTA_VERDE_5 = carta-normal("verde", 5)
CARTA_VERMELHA_PULA_VEZ = carta-especial("vermelho", PULA_VEZ)
CARTA_CURINGA_COMPRA4 = carta-curinga(CURINGA_COMPRA4)
CARTA_AZUL_3 = carta-normal("azul", 3)


#|
    Exercício 3
|#

fun mesmo-numero-ou-simbolo(carta1 :: CartaUNO, carta2 :: CartaUNO) -> Boolean:
    doc: "Determina se as cartas têm o mesmo número ou símbolo (ignorando a cor)."
    ask:
        | is-carta-curinga(carta1) and is-carta-curinga(carta2) then: carta1.simbolo == carta2.simbolo
        | is-carta-normal(carta1) and is-carta-normal(carta2) then: carta1.valor == carta2.valor
        | is-carta-especial(carta1) and is-carta-especial(carta2) then: carta1.simbolo == carta2.simbolo
        | otherwise: false
    end
where:
    mesmo-numero-ou-simbolo(CARTA_VERDE_5, carta-normal("vermelho", 5)) is true
    mesmo-numero-ou-simbolo(CARTA_VERMELHA_PULA_VEZ, carta-especial("azul", PULA_VEZ)) is true
    mesmo-numero-ou-simbolo(CARTA_VERDE_5, CARTA_VERMELHA_PULA_VEZ) is false
end