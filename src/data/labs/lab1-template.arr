use context starter2024

#|
    Este arquivo contém um modelo para a solução dos exercícios do Laboratório 1 de INF05008 - Pensamento Computacional.

    Prof. Lucas N. Alegre 
|#


#|
    Constantes Úteis (Exercício 2)
|#

CARTA-ALT = 175
CARTA-LAR = 125

# Imagens de pokemons da internet preparadas para a atividade
BULBASAUR-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/001.png"))
SQUIRTLE-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/007.png"))
CHARMANDER-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/004.png"))
PIKACHU-IMG = scale(0.75, image-url("https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/025.png"))

#| 
    Exercício 1
|#

# TODO: Defina as constantes de texto para os ataques e efeitos


# TODO: Defina as constantes para representar os tipos (ex: TYPE-NORMAL)


#|
    Exercício 2
|#

# TODO: Defina as imagens para os fundos de cartas usando rectangle e solid (ex: FUNDO-NORMAL)


# TODO: Defina a MESA (com circle) e a BORDA (com rectangle e outline)


#| 
    Exercício 3
|#

fun seleciona-fundo(tipo :: String) -> Image:
    doc: "Dado o tipo da carta, devolve a imagem de fundo correspondente a este tipo."
    # TODO: Implemente usando ask
    empty-image
where:
    # TODO: Escreva testes para as cores
    1 is 1 # Teste dummy para compilar, apague e substitua pelos seus testes
end

fun seleciona-imagem-pokemon(nome :: String) -> Image:
    doc: "Dado o nome do pokemon, devolve a imagem correspondente a este pokemon."
    # TODO: Implemente usando ask
    empty-image
where:
    # TODO: Escreva testes para as imagens dos pokemon
    1 is 1
end


#| 
    Exercício 4
|#

# Dica: Para sobrepor imagens de forma alinhada, você pode usar a função overlay-align(horizontal, vertical, imagem-frente, imagem-tras). 
# Os dois primeiros parâmetros indicam o alinhamento. Exemplo: overlay-align("middle", "bottom", img1, img2) 

fun cria-carta(nome :: String, tipo :: String) -> Image:
    doc: "Dado o nome do Pokemon e o tipo da carta, devolve uma imagem com a carta montada."
    # TODO: Siga o passo a passo do enunciado para construir e sobrepor as camadas em ordem
    empty-image
end

# Teste a sua funcão de construir cartas (remova o # abaixo para executar quando sua função estiver pronta):
# cria-carta("Bulbasaur", TYPE-GRASS)


#| 
    Exercício 5
|#

fun verifica-efeito(tipo-ataque :: String, tipo-defesa :: String) -> String:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    # TODO: Implemente as regras de vantagens. Use condicionais (ask) aninhados!
    "TODO"
where:
    # TODO: Escreva testes documentando algums casos de vantagens.
    1 is 1
end


#| 
    Exercício 6
|#

fun desenha-cenario(carta-ataque :: Image, carta-defesa :: Image, mesa :: Image, resultado-efeito :: String) -> Image:
    doc: "Dados as imagens de duas cartas, a mesa de fundo e o resultado do efeito do ataque, desenha o cenário de batalha."
    # TODO: Siga o roteiro do enunciado para criar o layout usando os layouts de imagem combinados (above, beside e afins)
    empty-image
end

# Após implementar tudo, remova os comentários da linha abaixo e veja a mágica acontecer! Você simulou uma batalha em código Pyret!
# desenha-cenario(
#     cria-carta("Bulbasaur", TYPE-GRASS),
#     cria-carta("Charmander", TYPE-FIRE),
#     MESA,
#     verifica-efeito(TYPE-GRASS, TYPE-FIRE)
# )
