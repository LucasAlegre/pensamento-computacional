use context dcic2024

include image

#|
    Este arquivo contém um modelo para a solução dos exercícios do Laboratório 1 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#


#|
    Constantes
|#

carta-alt = 175
carta-lar = 125

#| 
    Exercício 1
|#

ataque = "Attack"
defesa = "Defense"
efeito-naoefetivo = "Not very effective"
efeito-efetivo = "Effective"
efeito-superefetivo = "Super-effective!"
type-normal = "NORMAL"
type-fire = "FIRE"
type-water = "WATER"
type-electric = "ELECTRIC"
type-grass = "GRASS"

#|
    Exercício 2
|#

fundo-normal = rectangle(carta-lar, carta-alt, "solid", "darkgray")
fundo-fire = rectangle(carta-lar, carta-alt, "solid", "red")
fundo-water = rectangle(carta-lar, carta-alt, "solid", "blue")
fundo-electric = rectangle(carta-lar, carta-alt, "solid", "yellow")
fundo-grass = rectangle(carta-lar, carta-alt, "solid", "green")

# Mesa redonda onde vamos desenhar as cartas
mesa = circle(20 + carta-alt, "solid", "lightgray")
borda = rectangle(carta-lar + 10, carta-alt + 10, "outline", "black")

# Imagens de pokemons
bulbasaur-img = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/001.png"))
squirtle-img = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/007.png"))
charmander-img = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/004.png"))
pikachu-img = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/025.png"))

#| 
    Exercício 3
|#

fun seleciona-fundo(tipo :: String) -> Image:
    doc: "Dado o tipo da carta, devolve a imagem de fundo correspondente a este tipo."
    ask:
        | tipo == type-normal then: fundo-normal
        | tipo == type-fire then: fundo-fire
        | tipo == type-water then: fundo-water
        | tipo == type-electric then: fundo-electric
        | tipo == type-grass then: fundo-grass
    end
where:
    seleciona-fundo(type-normal) is fundo-normal
    seleciona-fundo(type-fire) is fundo-fire
end

fun seleciona-imagem-pokemon(nome :: String) -> Image:
    doc: "Dado o nome do pokemon, devolve a imagem correspondente a este pokemon."
    ask:
        | nome == "Bulbasaur" then: bulbasaur-img
        | nome == "Charmander" then: charmander-img
        | nome == "Squirtle" then: squirtle-img
        | nome == "Pikachu" then: pikachu-img
    end
where:
    seleciona-imagem-pokemon("Bulbasaur") is bulbasaur-img
    seleciona-imagem-pokemon("Charmander") is charmander-img
    seleciona-imagem-pokemon("Squirtle") is squirtle-img
end


#| 
    Exercício 4
|#

# Dica: Para sobrepor imagens de forma alinhada, usar overlay-align("middle", "bottom", imagem1, imagem2). O primeiro parâmetro indica o alinhamento horizontal, o segundo o alinhamento vertical, o terceiro a imagem que ficará em cima e o quarto a imagem que ficará embaixo.

fun cria-carta(nome :: String, tipo :: String) -> Image:
    doc: "Dado a borda da carta, o fundo escolhido referente ao tipo da carta e a String com o tipo da carta, devolve uma imagem com a carta montada (colocar o texto em cima do fundo em cima da borda)."
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
    # Sobrepõe a borda no centro da imagem da carta
    im5 = overlay-align("center", "center", im4, borda)
    im5
end

cria-carta("Bulbasaur", type-grass)


#| 
    Exercício 5
|#

fun verifica-efeito(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    ask:
        | (tipo-ataque == type-fire) then:
            ask:
                | (tipo-defesa == type-grass) then: efeito-superefetivo
                | (tipo-defesa == type-water) or (tipo-defesa == type-fire) then: efeito-naoefetivo
                | otherwise: efeito-efetivo
            end
        | (tipo-ataque == type-water) then:
            ask:
                | (tipo-defesa == type-fire) then: efeito-superefetivo
                | (tipo-defesa == type-grass) or (tipo-defesa == type-water) then: efeito-naoefetivo
                | otherwise: efeito-efetivo
            end
        | (tipo-ataque == type-electric) then:
            ask:
                | (tipo-defesa == type-water) then: efeito-superefetivo
                | (tipo-defesa == type-grass) or (tipo-defesa == type-electric) then: efeito-naoefetivo
                | otherwise: efeito-efetivo
            end
        | (tipo-ataque == type-grass) then:
            ask:
                | (tipo-defesa == type-water) then: efeito-superefetivo
                | (tipo-defesa == type-fire) or (tipo-defesa == type-grass) then: efeito-naoefetivo
                | otherwise: efeito-efetivo
            end
        | otherwise: efeito-efetivo
    end
where:
    verifica-efeito(type-fire, type-grass) is efeito-superefetivo
    verifica-efeito(type-fire, type-water) is efeito-naoefetivo
    verifica-efeito(type-fire, type-electric) is efeito-efetivo
end

fun verifica-efeito-v2(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    if ((tipo-ataque == type-fire) and (tipo-defesa == type-grass)):
        efeito-superefetivo
    else if ((tipo-ataque == type-fire) and (tipo-defesa == type-water)):
        efeito-naoefetivo
    else if ((tipo-ataque == type-fire) and (tipo-defesa == type-fire)):
        efeito-naoefetivo
    else if ((tipo-ataque == type-water) and (tipo-defesa == type-fire)):
        efeito-superefetivo
    else if ((tipo-ataque == type-water) and (tipo-defesa == type-grass)):
        efeito-naoefetivo
    else if ((tipo-ataque == type-water) and (tipo-defesa == type-water)):
        efeito-naoefetivo
    else if ((tipo-ataque == type-electric) and (tipo-defesa == type-water)):
        efeito-superefetivo
    else if ((tipo-ataque == type-electric) and (tipo-defesa == type-grass)):
        efeito-naoefetivo
    else if ((tipo-ataque == type-electric) and (tipo-defesa == type-electric)):
        efeito-naoefetivo
    else if ((tipo-ataque == type-grass) and (tipo-defesa == type-water)):
        efeito-superefetivo
    else if ((tipo-ataque == type-grass) and (tipo-defesa == type-fire)):
        efeito-naoefetivo
    else if ((tipo-ataque == type-grass) and (tipo-defesa == type-grass)):
        efeito-naoefetivo
    else:
        efeito-efetivo
    end
where:
    verifica-efeito-v2(type-fire, type-grass) is efeito-superefetivo
    verifica-efeito-v2(type-fire, type-water) is efeito-naoefetivo
    verifica-efeito-v2(type-fire, type-electric) is efeito-efetivo
end


#| 
    Exercício 6
|#

fun desenha-cenario(carta-ataque :: Image, carta-defesa :: Image, mesa-img :: Image, resultado-efeito :: String) -> Image:
    doc: "Dados as imagens de duas cartas, a mesa de fundo e o resultado do efeito do ataque, desenha uma imagem colocando as cartas lado a lado em cima da mesa (ataque na esquerda e defesa na direita), escrito 'Attack' em cima da carta atacante e 'Defense' em cima da carta defendendo, e o resultado do efeito embaixo da mesa."
    # Desenha a carta de ataque com o texto "Attack" em cima
    desenho-ataque = above(
        text(ataque, 20, "black"),
        carta-ataque
    )
    # Desenha a carta de defesa com o texto "Defense" em cima
    desenho-defesa = above(
        text(defesa, 20, "black"),
        carta-defesa
    )
    # Coloca as cartas lado a lado
    beside-cartas = beside(desenho-ataque, desenho-defesa)
    # Coloca as cartas em cima da mesa
    cartas-na-mesa = overlay-align("center", "center", beside-cartas, mesa-img)
    # Coloca o resultado do efeito embaixo da mesa
    resultado = text(resultado-efeito, 20, "black")
    above(cartas-na-mesa, resultado)
end

# Teste a sua funcão de construir cartas:
carta-teste = cria-carta("Bulbasaur", type-grass)
carta-teste

# Imagem do cenário de batalha 1
cenario-teste = desenha-cenario(
    cria-carta("Bulbasaur", type-grass),
    cria-carta("Charmander", type-fire),
    mesa,
    verifica-efeito(type-grass, type-fire)
)
cenario-teste

cenario-teste2 = desenha-cenario(
    cria-carta("Pikachu", type-electric),
    cria-carta("Squirtle", type-water),
    mesa,
    verifica-efeito(type-electric, type-water)
)
cenario-teste2

# Salvar imagens para o roteiro
save-image(carta-teste, "bulbasaur_card.png")
save-image(cenario-teste, "cenario1.png")
save-image(cenario-teste2, "cenario2.png")