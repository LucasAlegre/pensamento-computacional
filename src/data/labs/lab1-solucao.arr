use context dcic2024

include image

#|
    Este arquivo contém um modelo para a solução dos exercícios do Laboratório 1 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#


#|
    Constantes
|#

CARTA-ALT = 175
CARTA-LAR = 125

#| 
    Exercício 1
|#

ATAQUE = "Attack"
DEFESA = "Defense"
EFEITO-NAOEFETIVO = "Not very effective"
EFEITO-EFETIVO = "Effective"
EFEITO-SUPEREFETIVO = "Super-effective!"
TYPE-NORMAL = "NORMAL"
TYPE-FIRE = "FIRE"
TYPE-WATER = "WATER"
TYPE-ELECTRIC = "ELECTRIC"
TYPE-GRASS = "GRASS"

#|
    Exercício 2
|#

FUNDO-NORMAL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "darkgray")
FUNDO-FIRE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "red")
FUNDO-WATER = rectangle(CARTA-LAR, CARTA-ALT, "solid", "blue")
FUNDO-ELECTRIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "yellow")
FUNDO-GRASS = rectangle(CARTA-LAR, CARTA-ALT, "solid", "green")

# Mesa redonda onde vamos desenhar as cartas
MESA = circle(20 + CARTA-ALT, "solid", "lightgray")
BORDA = rectangle(CARTA-LAR + 10, CARTA-ALT + 10, "outline", "black")

# Imagens de pokemons
BULBASAUR-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/001.png"))
SQUIRTLE-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/007.png"))
CHARMANDER-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/004.png"))
PIKACHU-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/025.png"))

#| 
    Exercício 3
|#

fun seleciona-fundo(tipo :: String) -> Image:
    doc: "Dado o tipo da carta, devolve a imagem de fundo correspondente a este tipo."
    ask:
        | tipo == TYPE-NORMAL then: FUNDO-NORMAL
        | tipo == TYPE-FIRE then: FUNDO-FIRE
        | tipo == TYPE-WATER then: FUNDO-WATER
        | tipo == TYPE-ELECTRIC then: FUNDO-ELECTRIC
        | tipo == TYPE-GRASS then: FUNDO-GRASS
    end
where:
    seleciona-fundo(TYPE-NORMAL) is FUNDO-NORMAL
    seleciona-fundo(TYPE-FIRE) is FUNDO-FIRE
end

fun seleciona-imagem-pokemon(nome :: String) -> Image:
    doc: "Dado o nome do pokemon, devolve a imagem correspondente a este pokemon."
    ask:
        | nome == "Bulbasaur" then: BULBASAUR-IMG
        | nome == "Charmander" then: CHARMANDER-IMG
        | nome == "Squirtle" then: SQUIRTLE-IMG
        | nome == "Pikachu" then: PIKACHU-IMG
    end
where:
    seleciona-imagem-pokemon("Bulbasaur") is BULBASAUR-IMG
    seleciona-imagem-pokemon("Charmander") is CHARMANDER-IMG
    seleciona-imagem-pokemon("Squirtle") is SQUIRTLE-IMG
end


#| 
    Exercício 4
|#

# Dica: Para sobrepor imagens de forma alinhada, usar overlay-align("middle", "bottom", imagem1, imagem2). O primeiro parâmetro indica o alinhamento horizontal, o segundo o alinhamento vertical, o terceiro a imagem que ficará em cima e o quarto a imagem que ficará embaixo.

fun cria-carta(nome :: String, tipo :: String) -> Image:
    doc: "Dado o nome do Pokemon e o tipo da carta, devolve uma imagem com a carta montada."
    # Seleciona a imagem do pokemon
    img-pokemon = seleciona-imagem-pokemon(nome)
    # Desenha um círculo branco no centro do fundo
    im1 = overlay(circle(60, "solid", "white"), seleciona-fundo(tipo))
    # Sobrepõe a imagem do pokemon no círculo branco
    im2 = overlay(img-pokemon, im1)
    # Sobrepõe o texto do tipo na parte inferior da imagem do pokemon
    im3 = overlay-align("middle", "bottom", text(tipo, 20, "black"), im2)
    # Sobrepõe o texto do nome na parte superior da imagem do pokemon
    im4 = overlay-align("middle", "top", text(nome, 20, "black"), im3)
    # Sobrepõe a BORDA no centro da imagem da carta
    im5 = overlay-align("center", "center", im4, BORDA)
    im5
end

cria-carta("Bulbasaur", TYPE-GRASS)


#| 
    Exercício 5
|#

fun verifica-efeito(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    ask:
        | (tipo-ataque == TYPE-FIRE) then:
            ask:
                | (tipo-defesa == TYPE-GRASS) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-WATER) or (tipo-defesa == TYPE-FIRE) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | (tipo-ataque == TYPE-WATER) then:
            ask:
                | (tipo-defesa == TYPE-FIRE) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-GRASS) or (tipo-defesa == TYPE-WATER) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | (tipo-ataque == TYPE-ELECTRIC) then:
            ask:
                | (tipo-defesa == TYPE-WATER) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-GRASS) or (tipo-defesa == TYPE-ELECTRIC) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | (tipo-ataque == TYPE-GRASS) then:
            ask:
                | (tipo-defesa == TYPE-WATER) then: EFEITO-SUPEREFETIVO
                | (tipo-defesa == TYPE-FIRE) or (tipo-defesa == TYPE-GRASS) then: EFEITO-NAOEFETIVO
                | otherwise: EFEITO-EFETIVO
            end
        | otherwise: EFEITO-EFETIVO
    end
where:
    verifica-efeito(TYPE-FIRE, TYPE-GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-WATER) is EFEITO-NAOEFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-ELECTRIC) is EFEITO-EFETIVO
end

fun verifica-efeito-v2(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    if ((tipo-ataque == TYPE-FIRE) and (tipo-defesa == TYPE-GRASS)):
        EFEITO-SUPEREFETIVO
    else if ((tipo-ataque == TYPE-FIRE) and (tipo-defesa == TYPE-WATER)):
        EFEITO-NAOEFETIVO
    else if ((tipo-ataque == TYPE-FIRE) and (tipo-defesa == TYPE-FIRE)):
        EFEITO-NAOEFETIVO
    else if ((tipo-ataque == TYPE-WATER) and (tipo-defesa == TYPE-FIRE)):
        EFEITO-SUPEREFETIVO
    else if ((tipo-ataque == TYPE-WATER) and (tipo-defesa == TYPE-GRASS)):
        EFEITO-NAOEFETIVO
    else if ((tipo-ataque == TYPE-WATER) and (tipo-defesa == TYPE-WATER)):
        EFEITO-NAOEFETIVO
    else if ((tipo-ataque == TYPE-ELECTRIC) and (tipo-defesa == TYPE-WATER)):
        EFEITO-SUPEREFETIVO
    else if ((tipo-ataque == TYPE-ELECTRIC) and (tipo-defesa == TYPE-GRASS)):
        EFEITO-NAOEFETIVO
    else if ((tipo-ataque == TYPE-ELECTRIC) and (tipo-defesa == TYPE-ELECTRIC)):
        EFEITO-NAOEFETIVO
    else if ((tipo-ataque == TYPE-GRASS) and (tipo-defesa == TYPE-WATER)):
        EFEITO-SUPEREFETIVO
    else if ((tipo-ataque == TYPE-GRASS) and (tipo-defesa == TYPE-FIRE)):
        EFEITO-NAOEFETIVO
    else if ((tipo-ataque == TYPE-GRASS) and (tipo-defesa == TYPE-GRASS)):
        EFEITO-NAOEFETIVO
    else:
        EFEITO-EFETIVO
    end
where:
    verifica-efeito-v2(TYPE-FIRE, TYPE-GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito-v2(TYPE-FIRE, TYPE-WATER) is EFEITO-NAOEFETIVO
    verifica-efeito-v2(TYPE-FIRE, TYPE-ELECTRIC) is EFEITO-EFETIVO
end


#| 
    Exercício 6
|#

fun desenha-cenario(nome-atacante :: String, tipo-atacante :: String, nome-defensor :: String, tipo-defensor :: String) -> Image:
    doc: "Dados o nome e o tipo de um Pokémon atacante e de um Pokémon defensor, desenha uma imagem colocando as cartas lado a lado em cima da MESA (ATAQUE na esquerda e DEFESA na direita), escrito 'Attack' em cima da carta atacante e 'Defense' em cima da carta defendendo, e o resultado do efeito embaixo da MESA."
    # Cria as cartas
    carta-atacante = cria-carta(nome-atacante, tipo-atacante)
    carta-defesa = cria-carta(nome-defensor, tipo-defensor)
    # Verifica o efeito do ataque
    resultado-efeito = verifica-efeito(tipo-atacante, tipo-defensor)

    # Desenha a carta de ataque com o texto "Attack" em cima
    desenho-ataque = above(
        text(ATAQUE, 20, "black"),
        carta-atacante
    )
    # Desenha a carta de defesa com o texto "Defense" em cima
    desenho-defesa = above(
        text(DEFESA, 20, "black"),
        carta-defesa
    )
    # Coloca as cartas lado a lado
    beside-cartas = beside(desenho-ataque, desenho-defesa)
    # Coloca as cartas em cima da MESA
    cartas-na-mesa = overlay-align("center", "center", beside-cartas, MESA)
    # Coloca o resultado do efeito embaixo da MESA
    resultado = text(resultado-efeito, 20, "black")
    above(cartas-na-mesa, resultado)
end

# Teste a sua funcão de construir cartas:
carta-teste = cria-carta("Bulbasaur", TYPE-GRASS)
carta-teste

# Imagem do cenário de batalha 1
cenario-teste = desenha-cenario(
    "Bulbasaur",
    TYPE-GRASS,
    "Charmander",
    TYPE-FIRE
)
cenario-teste

cenario-teste2 = desenha-cenario(
    "Pikachu",
    TYPE-ELECTRIC,
    "Squirtle",
    TYPE-WATER
)
cenario-teste2

# Salvar imagens para o roteiro
# save-image(carta-teste, "bulbasaur_card.png")
# save-image(cenario-teste, "cenario1.png")
# save-image(cenario-teste2, "cenario2.png")