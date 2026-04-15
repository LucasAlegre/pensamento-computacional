use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 3 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib3.arr")


#| 
    Exercício 1
|#

data Pokemon:
    # Estrutura para representar um Pokemon
    | pokemon(
        nome :: String,       # Nome do pokemon 
        id :: Number,         # Identificador do pokemon
        tipo :: TipoPokemon,  # Tipo do Pokémon  
        hp :: Number,         # Quantidade de pontos de vida (HP) do pokemon
        max-hp :: Number)     # Quantidade máxima de pontos de vida (HP) do pokemon
end

BULBASAUR = pokemon("Bulbasaur", 1, GRASS, 45, 45)
CHARMANDER = pokemon("Charmander", 4, FIRE, 39, 39)
SQUIRTLE = pokemon("Squirtle", 7, WATER, 44, 44)
MEWTWO = pokemon("Mewtwo", 150, PSYCHIC, 106, 106)
PSYDUCK = pokemon("Psyduck", 54, WATER, 50, 50)
GENGAR = pokemon("Gengar", 94, GHOST, 60, 60)

data Movimento:
    # Um movimento pokemon pode ser de ataque ou cura:
    | ataque(
        nome :: String,       # Nome do movimento
        tipo :: TipoPokemon,  # Tipo do movimento
        poder :: Number)      # Poder do movimento
    | cura(
        nome :: String,       # Nome do movimento
        cura :: Number)       # Quantidade de pontos de vida curados
end

# Constantes movimentos
EMBER = ataque("Ember", FIRE, 40)
TACKLE = ataque("Tackle", NORMAL, 40)
SLEEP = cura("Sleep", 50)


fun barra-hp(p :: Pokemon) -> Image:
    doc: "Dado um pokemon, gera uma imagem da sua barra de pontos de vida (HP). A barra é verde se o HP for maior que 75%, amarela se o HP for maior que 25% e vermelha se o HP for menor ou igual a 25%."
    # Calcula a proporção de vida atual do Pokemon
    porcentagem-vida = p.hp / p.max-hp
    
    # Define a cor da barra baseada na porcentagem de vida
    cor = ask:
            | porcentagem-vida > 0.75 then: "green"
            | porcentagem-vida > 0.25 then: "yellow"
            | otherwise: "red"
        end
        
    # Cria a borda preta (contorno) para a barra de HP
    borda = rectangle(CARTA-LAR, 20, "outline", "black")
    
    # Cria o preenchimento da barra de vida com a cor correspondente 
    # e a sobrepõe alinhada à esquerda dentro da borda para representar a proporção preenchida
    barra = overlay-align("left", "top", rectangle(CARTA-LAR * porcentagem-vida, 20, "solid", cor), borda)
    
    # Cria o texto que indica o HP no formato "Atual / Máximo"
    texto-hp = text("HP: " + num-to-string(p.hp) + " / " + num-to-string(p.max-hp), 10, "black")

    # Centraliza o texto sobre a barra e a retorna
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

desenha-pokemon(SQUIRTLE)
save-image(desenha-pokemon(SQUIRTLE), "images/lab3/squirtle_card.png")


#| 
    Exercício 2
|#

data Time:
    # Um Time é uma lista de Pokemons
    | t-empty
    | t-link(first :: Pokemon, rest :: Time)
end

TIME1 = t-link(BULBASAUR, t-link(CHARMANDER, t-link(SQUIRTLE, t-empty)))
TIME2 = t-link(PSYDUCK, t-link(MEWTWO, t-empty))
TIME3 = t-link(BULBASAUR, t-link(CHARMANDER, t-link(SQUIRTLE, t-link(GENGAR, t-empty))))

#|
    Exercício 3
|#

fun extrai-pokemon-tabela(id :: Number, table :: Table) -> Pokemon:
    doc: "Dado um id e uma tabela de pokemons, devolve o pokemon correspondente a este id nesta tabela."
    # Filtra a tabela procurando as linhas (rows) com o mesmo id fornecido
    # e assume o primeiro elemento encontrado usando a função .row-n(0)
    row = filter-with(table, lam(row): row["id"] == id end).row-n(0)

    # Cria e retorna a instância do Pokemon utilizando os dados obtidos da linha filtrada
    # (assumindo que inicialmente o hp atual e o max-hp sejam os mesmos)
    pokemon(row["name"], row["id"], string-to-tipo(row["type1"]), row["hp"], row["hp"])
where:
    extrai-pokemon-tabela(1, POKE-DATA) is pokemon("Bulbasaur", 1, GRASS, 45, 45)
end


fun cria-time(tabela :: Table, lista-ids :: List<Number>) -> Time:
    doc: "Dada uma tabela de pokemons e uma lista de IDs, devolve um time com todos os pokemons desta tabela."
    cases (List<Number>) lista-ids:
        # Se a lista de IDs está vazia, o problema de gerar um time está resolvido: é um time vazio
        | empty => t-empty
        # Para uma lista de IDs com elementos:
        | link(f, r) => 
            t-link(
                # Busca-se na tabela o pokemon referente ao primeiro ID (`f`)
                extrai-pokemon-tabela(f, tabela),
                # E o adiciona na frente do time já criado a partir do resto da lista
                cria-time(tabela, r))
    end
where:
    cria-time(POKE-DATA, [list: 1, 4, 7]) is t-link(BULBASAUR, t-link(CHARMANDER, t-link(SQUIRTLE, t-empty)))
end


#|
    Exercício 4
|#

fun atualiza-hp(p :: Pokemon, valor :: Number) -> Pokemon:
    doc: "Dado um pokemon e um valor (positivo para cura ou negativo para dano), atualiza o hp (vida) do pokemon, respeitando os limites de hp mínimo (0) e máximo (hp-max)."
    # Calcula o novo hp avaliando se não passa dos limites estipulados de vida
    novo-hp = ask:
        | (p.hp + valor) < 0 then: 0 # Não pode ficar com hp negativo
        | (p.hp + valor) > p.max-hp then: p.max-hp # Não pode ter mais hp que o máximo permitido
        | otherwise: p.hp + valor # Atualização normal
    end
    # Obs: Linha comentada abaixo seria uma forma alternativa para garantir o limite de vida com funções
    # novo-hp = num-min(p.max-hp, num-max(0, p.hp + valor))

    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando a vida ajustada (novo-hp)
    pokemon(p.nome, p.id, p.tipo, novo-hp, p.max-hp)
where:
    atualiza-hp(BULBASAUR, -10) is pokemon("Bulbasaur", 1, GRASS, 35, 45)
    atualiza-hp(BULBASAUR, -50) is pokemon("Bulbasaur", 1, GRASS, 0, 45)
    atualiza-hp(BULBASAUR, 100) is pokemon("Bulbasaur", 1, GRASS, 45, 45)
end


#|
    Exercício 5
|#

fun efeito-to-multiplicador(e :: Efeito) -> Number:
    doc: "Dado um tipo de efeito, devolve o multiplicador de dano correspondente."
    ask:
        | e == SEM-EFEITO then: 0       # Absorve tudo (nenhum dano recebido)
        | e == NAO-EFETIVO then: 0.5    # Recebe apenas metade do dano (resistente)
        | e == EFETIVO then: 1          # Dano segue normal (neutro)
        | e == SUPER-EFETIVO then: 2    # Recebe o dobro do dano (fraqueza)
    end
where:
    efeito-to-multiplicador(SEM-EFEITO) is 0
    efeito-to-multiplicador(NAO-EFETIVO) is 0.5
    efeito-to-multiplicador(EFETIVO) is 1
    efeito-to-multiplicador(SUPER-EFETIVO) is 2
end
fun aplica-movimento(p :: Pokemon, m :: Movimento) -> Pokemon:
    doc: "Dado um pokemon e um movimento, devolve o pokemon resultante de aplicar este movimento sobre este pokemon. Em caso do movimento do tipo Ataque, o dado é multiplicado pelo multiplicador do efeito correspondente."
    cases (Movimento) m:
        | ataque(nome, tipo, poder) => 
            # Subtrai o HP transformando o poder do ataque em negativo (-1 * poder)
            # e multiplicando a quantidade de dano pelo multiplicador obtido das fraquezas e resistências
            atualiza-hp(p, (-1 * poder) * efeito-to-multiplicador(verifica-efeito(tipo, p.tipo)))
            
        | cura(nome, c) => 
            # Apenas incrementa a vida do pokemon utilizando a quantidade de cura `c`
            atualiza-hp(p, c)
    end
where:
    aplica-movimento(BULBASAUR, EMBER) is pokemon("Bulbasaur", 1, GRASS, 0, 45)
    aplica-movimento(BULBASAUR, TACKLE) is pokemon("Bulbasaur", 1, GRASS, 5, 45)
    aplica-movimento(BULBASAUR, SLEEP) is pokemon("Bulbasaur", 1, GRASS, 45, 45)
end


#|
    Exercício 6
|#

fun aplica-movimento-no-time(t :: Time, m :: Movimento) -> Time:
    doc: "Dado um time e um movimento, devolve o time resultante de aplicar este movimento sobre todos os pokemons deste time."
    cases (Time) t:
        # Se o time é vazio, aplicar o movimento sobre ele está resolvido, resultando no próprio time vazio
        | t-empty => t-empty
        # Para um time com integrantes:
        | t-link(p, rest) => 
            t-link(
                # Aplica o movimento isoladamente sobre o primeiro pokemon (`p`)
                aplica-movimento(p, m), 
                # E conecta esse pokemon ao time obtido aplicando o movimento ao resto da lista
                aplica-movimento-no-time(rest, m))  
    end
where:
    aplica-movimento-no-time(t-empty, EMBER) is t-empty
    aplica-movimento-no-time(TIME1, EMBER) is t-link(pokemon("Bulbasaur", 1, GRASS, 0, 45), t-link(pokemon("Charmander", 4, FIRE, 19, 39), t-link(pokemon("Squirtle", 7, WATER, 24, 44), t-empty)))
end


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

desenha-time(cria-time(POKE-DATA, [list: 42, 120, 133]))

desenha-time(aplica-movimento-no-time(TIME1, EMBER))

save-image(desenha-time(aplica-movimento-no-time(TIME3, EMBER)), "images/lab3/time3_ember.png")