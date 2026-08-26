use context dcic2024

include image

#|
    Solução de Referência: Laboratório 1 (2026/2) - INF05008 Pensamento Computacional
    Tema: Truco Gaúcho (Gaudério)
    Regras de Referência: https://www.jogatina.com/regras-como-jogar-truco-gauderio.html

    Autor: Prof. Lucas N. Alegre
|#

#|
    Constantes Visuais Base
|#

CARTA-ALT = 175
CARTA-LAR = 125

# Imagens dos quatro naipes do baralho espanhol preparadas para a atividade
ICONE-ESPADAS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/espadas.jpg"))
ICONE-PAUS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/paus.jpg"))
ICONE-OUROS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/ouros.jpg"))
ICONE-COPAS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/copas.jpg"))


#| 
    Exercício 1: Constantes de Texto
|#

NAIPE-ESPADAS = "ESPADAS"
NAIPE-PAUS = "PAUS"
NAIPE-OUROS = "OUROS"
NAIPE-COPAS = "COPAS"

VITORIA-J1 = "Jogador 1 venceu a rodada!"
VITORIA-J2 = "Jogador 2 venceu a rodada!"
EMPATE = "Empatou a rodada!"


#|
    Exercício 2: Constantes Visuais e Mesa
|#

FUNDO-CARTA = rectangle(CARTA-LAR - 10, CARTA-ALT - 10, "solid", "white")

MESA = circle(20 + CARTA-ALT, "solid", "darkgreen")
BORDA = rectangle(CARTA-LAR, CARTA-ALT, "solid", "white")


#| 
    Exercício 3: Composição Básica de Imagens (Sem Condicionais)
|#

fun fundo-com-icone(icone :: Image) -> Image:
  doc: "Dado o ícone de um naipe, centraliza o ícone sobre o fundo da carta."
  overlay(icone, FUNDO-CARTA)
end

fun adiciona-borda(carta :: Image) -> Image:
  doc: "Dada a imagem de uma carta, devolve a mesma carta com borda externa."
  overlay-align("middle", "middle", frame(carta), BORDA)
end


#| 
    Exercício 4: Expressões Condicionais (Seleção de Ícone e Manilhas)
|#

fun seleciona-icone-naipe(naipe :: String) -> Image:
  doc: "Dado o nome de um naipe, devolve o ícone correspondente."
  ask:
    | naipe == NAIPE-ESPADAS then: ICONE-ESPADAS
    | naipe == NAIPE-PAUS then: ICONE-PAUS
    | naipe == NAIPE-OUROS then: ICONE-OUROS
    | naipe == NAIPE-COPAS then: ICONE-COPAS
    | otherwise: empty-image
  end
where:
  seleciona-icone-naipe(NAIPE-ESPADAS) is ICONE-ESPADAS
  seleciona-icone-naipe(NAIPE-PAUS) is ICONE-PAUS
  seleciona-icone-naipe(NAIPE-OUROS) is ICONE-OUROS
  seleciona-icone-naipe(NAIPE-COPAS) is ICONE-COPAS
end

fun eh-manilha(valor :: Number, naipe :: String) -> Boolean:
  doc: "Dado o valor numérico e o naipe de uma carta, devolve true se ela for uma das 4 manilhas fixas do Truco Gaúcho, e false caso contrário."
  ask:
    | (valor == 1) and (naipe == NAIPE-ESPADAS) then: true # Espadilha
    | (valor == 1) and (naipe == NAIPE-PAUS) then: true    # Bastilho
    | (valor == 7) and (naipe == NAIPE-ESPADAS) then: true # 7 de Espadas
    | (valor == 7) and (naipe == NAIPE-OUROS) then: true   # 7 de Ouros
    | otherwise: false
  end
where:
  eh-manilha(1, NAIPE-ESPADAS) is true
  eh-manilha(1, NAIPE-PAUS) is true
  eh-manilha(7, NAIPE-ESPADAS) is true
  eh-manilha(7, NAIPE-OUROS) is true
  eh-manilha(1, NAIPE-COPAS) is false
  eh-manilha(7, NAIPE-COPAS) is false
  eh-manilha(3, NAIPE-ESPADAS) is false
  eh-manilha(4, NAIPE-PAUS) is false
end


#| 
    Exercício 5: Montagem da Carta
|#

fun cria-carta(valor :: Number, naipe :: String) -> Image:
  doc: "Dado o valor numérico e o naipe da carta, devolve a imagem da carta montada com valor, ícone, nome do naipe e borda."
  adiciona-borda(
    overlay-align("middle", "bottom",
      text(naipe, 14, "black"),
      overlay-align("middle", "top",
        text(num-to-string(valor), 24, "black"),
        fundo-com-icone(seleciona-icone-naipe(naipe)))))
end


#| 
    Exercício 6: Força da Carta no Truco Gaúcho
|#

fun forca-carta(valor :: Number, naipe :: String) -> Number:
  doc: ```Dado o valor numérico e o naipe de uma carta, devolve o seu peso de força no Truco Gaúcho (escala de 1 a 14).
  Regras: https://www.jogatina.com/regras-como-jogar-truco-gauderio.html
  ```
  ask:
    # 1. As 4 Manilhas Fixas
    | (valor == 1) and (naipe == NAIPE-ESPADAS) then: 14  # Espadilha
    | (valor == 1) and (naipe == NAIPE-PAUS) then: 13     # Bastilho
    | (valor == 7) and (naipe == NAIPE-ESPADAS) then: 12  # 7 de Espadas
    | (valor == 7) and (naipe == NAIPE-OUROS) then: 11    # 7 de Ouros

    # 2. Cartas Comuns
    | valor == 3 then: 10                                 # Todos os 3s
    | valor == 2 then: 9                                  # Todos os 2s
    | (valor == 1) and ((naipe == NAIPE-COPAS) or (naipe == NAIPE-OUROS)) then: 8 # Ases comuns
    | valor == 12 then: 7                                 # Todos os 12s (Reis)
    | valor == 11 then: 6                                 # Todos os 11s (Cavalos)
    | valor == 10 then: 5                                 # Todos os 10s (Valetes)
    | (valor == 7) and ((naipe == NAIPE-COPAS) or (naipe == NAIPE-PAUS)) then: 4  # 7s comuns
    | valor == 6 then: 3                                  # Todos os 6s
    | valor == 5 then: 2                                  # Todos os 5s
    | valor == 4 then: 1                                  # Todos os 4s
  end
where:
  forca-carta(1, NAIPE-ESPADAS) is 14
  forca-carta(1, NAIPE-PAUS) is 13
  forca-carta(7, NAIPE-ESPADAS) is 12
  forca-carta(7, NAIPE-OUROS) is 11
  forca-carta(3, NAIPE-COPAS) is 10
  forca-carta(2, NAIPE-OUROS) is 9
  forca-carta(1, NAIPE-COPAS) is 8
  forca-carta(1, NAIPE-OUROS) is 8
  forca-carta(12, NAIPE-ESPADAS) is 7
  forca-carta(11, NAIPE-PAUS) is 6
  forca-carta(10, NAIPE-COPAS) is 5
  forca-carta(7, NAIPE-COPAS) is 4
  forca-carta(7, NAIPE-PAUS) is 4
  forca-carta(6, NAIPE-ESPADAS) is 3
  forca-carta(5, NAIPE-OUROS) is 2
  forca-carta(4, NAIPE-PAUS) is 1
end


#| 
    Exercício 7: Duelo e Montagem da Rodada na Mesa
|#

fun compara-cartas(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> String:
  doc: "Dadas duas cartas (Jogador 1 vs Jogador 2), devolve a constante de resultado: VITORIA-J1, VITORIA-J2 ou EMPATE."
  ask:
    | forca-carta(valor1, naipe1) > forca-carta(valor2, naipe2) then: VITORIA-J1
    | forca-carta(valor2, naipe2) > forca-carta(valor1, naipe1) then: VITORIA-J2
    | otherwise: EMPATE
  end
where:
  compara-cartas(1, NAIPE-ESPADAS, 1, NAIPE-PAUS) is VITORIA-J1
  compara-cartas(7, NAIPE-OUROS, 7, NAIPE-ESPADAS) is VITORIA-J2
  compara-cartas(3, NAIPE-ESPADAS, 3, NAIPE-COPAS) is EMPATE
  compara-cartas(4, NAIPE-PAUS, 4, NAIPE-OUROS) is EMPATE
  compara-cartas(1, NAIPE-COPAS, 12, NAIPE-ESPADAS) is VITORIA-J1
end

fun rotula-carta(nome-jogador :: String, valor :: Number, naipe :: String) -> Image:
  doc: "Dado o nome do jogador e a carta, devolve a carta com o rótulo do jogador posicionado acima dela."
  above(
    text(nome-jogador, 16, "white"),
    cria-carta(valor, naipe)
  )
end

fun desenha-duelo(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> Image:
  doc: "Desenha as cartas rotuladas de ambos os jogadores lado a lado e centralizadas sobre a MESA."
  overlay-align("middle", "middle",
    beside(
      rotula-carta("Jogador 1", valor1, naipe1),
      rotula-carta("Jogador 2", valor2, naipe2)),
    MESA)
end

fun desenha-cenario(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> Image:
  doc: "Dadas as cartas jogadas pelo Jogador 1 e pelo Jogador 2, desenha o cenário do duelo sobre a MESA verde com rótulos dos jogadores e o resultado abaixo da mesa."
  above(
    desenha-duelo(valor1, naipe1, valor2, naipe2),
    above(
      rectangle(10, 15, "solid", "transparent"),
      text(compara-cartas(valor1, naipe1, valor2, naipe2), 20, "black")
    )
  )
end

desenha-cenario(1, NAIPE-ESPADAS, 7, NAIPE-OUROS)
