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
    
    # Coloca a borda sobre a carta
    overlay-align("center", "center",
        # Coloca o nome no topo da carta
        overlay-align("middle", "top", 
            text(nome, 20, "black"),
            # Coloca o tipo na parte inferior da carta
            overlay-align("middle", "bottom",
                text(tipo, 20, "black"),
                # Coloca o fundo da carta
                overlay(
                    # Coloca a imagem do pokemon sobre o círculo branco
                    overlay(
                        seleciona-imagem-pokemon(nome), 
                        circle(60, "solid", "white")),
                    seleciona-fundo(tipo)))), 
    BORDA)
end

cria-carta("Bulbasaur", TYPE-GRASS)

fun cria-carta-v2(nome :: String, tipo :: String) -> Image:
    doc: "Dado o nome do Pokemon e o tipo da carta, devolve uma imagem com a carta montada."
    
    # Definições Locais:
    # Gera imagem do pokemon sobre o círculo
    pokemon-sobre-circulo = overlay(seleciona-imagem-pokemon(nome), circle(60, "solid", "white"))
    # Gera fundo com o pokemon
    fundo-com-pokemon = overlay(pokemon-sobre-circulo, seleciona-fundo(tipo))
    # Gera carta com o tipo
    carta-com-tipo = overlay-align("middle", "bottom", text(tipo, 20, "black"), fundo-com-pokemon)
    # Gera carta com o nome
    carta-com-nome = overlay-align("middle", "top", text(nome, 20, "black"), carta-com-tipo)
    # Gera carta final com a borda
    carta-final = overlay-align("center", "center", carta-com-nome, BORDA)

    # Expressão:
    carta-final
end

#| 
    Exercício 5
|#

fun testa-superefetivo(tipo-ataque :: String, tipo-defesa :: String) -> Boolean:
    doc: "Dado o tipo de ataque e o tipo de defesa, true se o ataque for super efetivo e false caso contrário."
    ask:
        | (tipo-ataque == TYPE-FIRE) and (tipo-defesa == TYPE-GRASS) then: true
        | (tipo-ataque == TYPE-WATER) and (tipo-defesa == TYPE-FIRE) then: true
        | (tipo-ataque == TYPE-ELECTRIC) and (tipo-defesa == TYPE-WATER) then: true
        | (tipo-ataque == TYPE-GRASS) and (tipo-defesa == TYPE-WATER) then: true
        | otherwise: false
    end
where:
    testa-superefetivo(TYPE-FIRE, TYPE-GRASS) is true
    testa-superefetivo(TYPE-WATER, TYPE-FIRE) is true
    testa-superefetivo(TYPE-ELECTRIC, TYPE-WATER) is true
    testa-superefetivo(TYPE-GRASS, TYPE-FIRE) is false
end

fun testa-naoefetivo(tipo-ataque :: String, tipo-defesa :: String) -> Boolean:
    doc: "Dado o tipo de ataque e o tipo de defesa, true se o ataque for não efetivo e false caso contrário."
    # um tipo é não efetivo se ele for igual ao tipo de defesa ou se a defesa for super efetiva
    (tipo-ataque == tipo-defesa) or testa-superefetivo(tipo-defesa, tipo-ataque)
where:
    testa-naoefetivo(TYPE-FIRE, TYPE-WATER) is true
    testa-naoefetivo(TYPE-WATER, TYPE-ELECTRIC) is true
    testa-naoefetivo(TYPE-ELECTRIC, TYPE-GRASS) is false
    testa-naoefetivo(TYPE-GRASS, TYPE-FIRE) is true
end

fun verifica-efeito(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    ask:
        | testa-superefetivo(tipo-ataque, tipo-defesa) then: EFEITO-SUPEREFETIVO
        | testa-naoefetivo(tipo-ataque, tipo-defesa) then: EFEITO-NAOEFETIVO
        | otherwise: EFEITO-EFETIVO  # Em todos outros casos, o efeito é efetivo
    end
where:
    verifica-efeito(TYPE-FIRE, TYPE-GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-WATER) is EFEITO-NAOEFETIVO
    verifica-efeito(TYPE-FIRE, TYPE-ELECTRIC) is EFEITO-EFETIVO
end

fun verifica-efeitov2(tipo-ataque :: String, tipo-defesa :: String) -> String:
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
    verifica-efeitov2(TYPE-FIRE, TYPE-GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeitov2(TYPE-FIRE, TYPE-WATER) is EFEITO-NAOEFETIVO
    verifica-efeitov2(TYPE-FIRE, TYPE-ELECTRIC) is EFEITO-EFETIVO
end

fun verifica-efeito-v3(tipo-ataque :: String, tipo-defesa :: String) -> String:
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
    verifica-efeito-v3(TYPE-FIRE, TYPE-GRASS) is EFEITO-SUPEREFETIVO
    verifica-efeito-v3(TYPE-FIRE, TYPE-WATER) is EFEITO-NAOEFETIVO
    verifica-efeito-v3(TYPE-FIRE, TYPE-ELECTRIC) is EFEITO-EFETIVO
end


#| 
    Exercício 6
|#

fun desenha-cenario(nome-atacante :: String, tipo-atacante :: String, nome-defensor :: String, tipo-defensor :: String) -> Image:
    doc: "Dados o nome e o tipo de um Pokémon atacante e de um Pokémon defensor, desenha uma imagem colocando as cartas lado a lado em cima da MESA (ATAQUE na esquerda e DEFESA na direita), escrito 'Attack' em cima da carta atacante e 'Defense' em cima da carta defendendo, e o resultado do efeito embaixo da MESA."

    # Coloca o resultado abaixo da imagem
    above(
        # Coloca a mesa abaixo das cartas
        overlay-align("center", "center",
            # Coloca as cartas lado a lado
            beside(
                # Crita carta ataque
                above(text(ATAQUE, 20, "black"), cria-carta(nome-atacante, tipo-atacante)),
                # Cria carta defesa
                above(text(DEFESA, 20, "black"), cria-carta(nome-defensor, tipo-defensor))
            ),
            MESA),
        text(verifica-efeito(tipo-atacante, tipo-defensor), 20, "black"))
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