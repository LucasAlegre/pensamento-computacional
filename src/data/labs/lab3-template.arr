use context dcic2024

include image
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib3.arr")


#| 
    Exercício 1: Estrutura: Pokémons e Movimentos
|#


data Pokemon:
    # Estrutura para representar um Pokemon
    | pokemon # Complete!
end

# Constantes:

data Movimento:
    # Um movimento pokemon pode ser de ataque ou cura:
end

# Constantes movimentos:



fun barra-hp(p :: Pokemon) -> Image:
    doc: "Dado um pokemon, gera uma imagem da sua barra de pontos de vida (HP). A barra é verde se o HP for maior que 75%, amarela se o HP for maior que 25% e vermelha se o HP for menor ou igual a 25%."
    porcentagem-vida = p.hp / p.max-hp
    cor = ask:
            | porcentagem-vida > 0.75 then: "green"
            | porcentagem-vida > 0.25 then: "yellow"
            | otherwise: "red"
        end
    borda = rectangle(CARTA-LAR, 20, "outline", "black")
    barra = overlay-align("left", "top", rectangle(CARTA-LAR * porcentagem-vida, 20, "solid", cor), borda)
    texto-hp = text("HP: " + num-to-string(p.hp) + " / " + num-to-string(p.max-hp), 10, "black")

    overlay-align("center", "center", texto-hp, barra)
end

fun desenha-pokemon(p :: Pokemon) -> Image:
    doc: "Dado um Pokemon, devolve uma imagem deste Pokemon."
    # Definições Locais:
    # Gera imagem do pokemon sobre o círculo
    pokemon-sobre-circulo = overlay(img-pokemon(p.id), circle(60, "solid", "white"))
    # Gera fundo com o pokemon
    fundo-com-pokemon = overlay(pokemon-sobre-circulo, seleciona-fundo(p.tipo))
    # Gera carta com o tipo
    carta-com-tipo = overlay-align("middle", "bottom", text(tipo-to-string(p.tipo), 20, "black"), fundo-com-pokemon)
    # Gera carta com o nome
    carta-com-nome = overlay-align("middle", "top", text(p.nome, 20, "black"), carta-com-tipo)
    # Gera carta final com a borda
    carta-final = overlay-align("center", "center", carta-com-nome, BORDA)
    # Coloca barra de vida
    carta-com-hp = above(barra-hp(p), carta-final)

    # Expressão:
    carta-com-hp
end


# Veja o resultado de desenha-pokemon para suas constantes criadas:
# desenha-pokemon(...)
# ...

#| 
    Exercício 2: Time Pokémon
|#


data Time:
    # Um Time é uma lista de Pokemons
    # Complete!
end

# Constantes:


#| 
    Exercício 3: Extraindo Times de Pokémons da Tabela
|#

fun extrai-pokemon-tabela(id :: Number, table :: Table) -> Pokemon:
    doc: "Dado um id e uma tabela de pokemons, devolve o pokemon correspondente a este id nesta tabela."
    row = filter-with(table, lam(row): row["id"] == id end).row-n(0)

    # Complete Aqui!
    -1
where:
    2 + 2 is 5
    #extrai-pokemon-tabela(1, POKE-DATA) is pokemon("Bulbasaur", 1, GRASS, 45, 45)
end


fun cria-time(tabela :: Table, lista-ids :: List<Number>) -> Time:
    doc: "Dada uma tabela de pokemons e uma lista de IDs, devolve um time com todos os pokemons desta tabela."

    # Se a lista for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento da lista]
        # [solucionar problem para] [resto da lista]
    -1
where:
    2 + 2 is 5
end

#| 
    Exercício 4: Atualizando o HP de um Pokemon
|#

# fun atualiza-hp
#     ...
# where:
#     ...
# end


#| 
    Exercício 5: Ataques entre Pokémons
|#

# fun aplica-movimento
#     ...
# where:
#     ...
# end


#| 
    Exercício 6: Aplicando um Movimento a um Time
|#

# fun aplica-movimento-no-time(t :: Time, m :: Movimento) -> Time:
    # Se a lista for vazia, então [...]

    # Senão, []
        # [fazer algo com] [primeiro elemento da lista]
        # [solucionar problem para] [resto da lista]
# where:
#     ...
# end


fun desenha-time(t :: Time) -> Image:
    doc: "Dado um time Pokémon, gera uma imagem das cartas dos Pokemons do time lado a lado."
    cases (Time) t:
        # Se o time é vazio, desenhá-lo é trivial, retornando uma imagem vazia
        | t-empty => empty-image
        # Para um time com integrantes:
        | t-link(f, r) => 
            # A imagem do time completo é então construída desenhando a carta do primeiro pokemon (`f`)
            # sendo em seguida colocada lado a lado da imagem já construída do resto da lista
            beside(desenha-pokemon(f), desenha-time(r))
    end
end

# Ao terminar o Exercício 6, gere uma imagem do resultado de um movimento aplicado em um Time:

#desenha-time(cria-time(POKE-DATA, [list: 42, 120, 133]))
#desenha-time(aplica-movimento-no-time(TIME1, EMBER))
