use context starter2024


#|
    Este arquivo contém o modelo da solução dos exercícios do Laboratório 6 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
include csv
include data-source
include reactors

include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib6.arr")

#|
    Batalha entre 2 Pokémon - v0
|#

data Worldv0:
    # O mundo representa o estado do jogo e guarda os dois pokemons que estão batalhando.
    | worldv0(
        pokemon1 :: Pokemon,
        pokemon2 :: Pokemon
    )
end

BULBASAUR = extrai-pokemon-tabela(1, POKE-DATA)
CHARMANDER = extrai-pokemon-tabela(4, POKE-DATA)


fun move-pokemon(p :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon, devolve o pokemon resultante de movê-lo de acordo com sua velocidade (speed) e direção (dx, dy)."
    # Calcule as novas coordenadas do pokemon utilizando sua velocidade, direção e velocidade (speed)
    NOVO-X = p.x
    NOVO-Y = p.y
    # Se o pokemon estiver for dos limites, deve trocar o sentido de sua direção (dx, dy) e ser movido de acordo com a nova direção
    NOVO-DX = 0
    NOVO-DY = 0

    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando as novas coordenadas e direções ajustadas
    pokemon(p.nome, p.id, p.tipo, NOVO-X, NOVO-Y, NOVO-DX, NOVO-DY, p.speed, p.hp, p.max-hp, p.img, p.movimento)
end

fun aplica-movimento(p :: Pokemon, m :: Movimento) -> Pokemon:
    doc: "Dado um pokemon e um movimento, devolve o pokemon resultante de aplicar este movimento sobre este pokemon. Em caso do movimento do tipo Ataque, o dado é multiplicado pelo multiplicador do efeito correspondente."
    cases (Movimento) m:
        | ataque(nome, tipo, poder) => 
            # Subtrai o HP transformando o poder do ataque em negativo (-1 * poder)
            # e multiplicando a quantidade de dano pelo multiplicador obtido das fraquezas e resistências
            dano = 0 # COMPLETE AQUI calcule o dano usando as funções verifica-efeito e efeito-to-multiplicador e o poder do ataque

            atualiza-hp(p, dano)
            
        | cura(nome, c) => 
            # Apenas incrementa a vida do pokemon utilizando a quantidade de cura `c`
            atualiza-hp(p, c)
    end
end

fun ataque-pokemon(p-atacante :: Pokemon, p-defensor :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon atacante e um pokemon defensor, devolve o pokemon defensor resultante de ser atacado pelo pokemon atacante utilizando seu movimento."
    p-defensor # COMPLETE AQUI
end

fun inverte-direcao(p :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon, devolve o pokemon resultante de inverter sua direção (dx, dy)."
    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando as direções invertidas
    # CORRIJA o código abaixo para inverter as direções dx e dy do pokemon:
    pokemon(p.nome, p.id, p.tipo, p.x, p.y, p.dx, p.dy, p.speed, p.hp, p.max-hp, p.img, p.movimento)
end

fun colidiu(p1 :: Pokemon, p2 :: Pokemon) -> Boolean:
    doc: "Dado dois pokemons, devolve true se eles colidiram (ou seja, se suas imagens se sobrepõem) e false caso contrário. O critério para colisão é se a distância euclidiana entre as coordenadas dos pokemons for menor que image-width(p1.img)."
    distancia = -1

    false
where:
    colidiu(
        pokemon("Pikachu", 25, ELECTRIC, 50, 50, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), 
        pokemon("Bulbasaur", 1, GRASS, 55, 50, 0, 0, 0, 45, 45, img-pokemon(1), ataque("Vine Whip", GRASS, 45))) is true
    colidiu(
        pokemon("Pikachu", 25, ELECTRIC, 50, 50, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), 
        pokemon("Bulbasaur", 1, GRASS, 200, 200, 0, 0, 0, 45, 45, img-pokemon(1), ataque("Vine Whip", GRASS, 45))) is false
end

fun processa-ataque-pokemon(p :: Pokemon, inimigo :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon e um pokemon inimigo, devolve o pokemon atualizado após processar o ataque do pokemon inimigo. O pokemon é atacado pelo pokemon inimigo se eles colidirem, e a direção do pokemon é invertida a cada ataque sofrido."
    ask:
        | colidiu(p, inimigo) then: 
            # Aplica o ataque do pokemon inimigo sobre o pokemon e inverte sua direção
            p # COMPLETE AQUI
        | otherwise: 
            # Se não colidiu, o pokemon não é atacado e é retornado sem alterações
            p
    end
end

fun esta-vivo(p :: Pokemon) -> Boolean:
    doc: "Dado um pokemon, devolve true se o mesmo está vivo (ou seja, se seu hp for maior que 0), e false caso contrário."
    true # COMPLETE AQUI
where:
    esta-vivo(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))) is true
    esta-vivo(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 0, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))) is false
end

fun acabou-jogo-v0(w :: Worldv0) -> Boolean:
    doc: "Dado um mundo, devolve true se o jogo acabou (ou seja, se um dos pokemons não está mais vivo) e false caso contrário."
    false # COMPLETE AQUI
end

fun desenha-mundo-v0(w :: Worldv0) -> Image:
    doc: "Dado um mundo, gera uma imagem representando o estado deste mundo. Para isso, basta desenhar os pokemons dos jogadores sobre o cenário."
    place-image(
        desenha-pokemon(w.pokemon1), w.pokemon1.x, w.pokemon1.y,
        place-image(
            desenha-pokemon(w.pokemon2), w.pokemon2.x, w.pokemon2.y,
            CENARIO))
end

fun atualiza-mundo-v0(w :: Worldv0) -> Worldv0:
    doc: "Atualiza o mundo a cada tick do jogo, movendo os pokemons e processando os ataques entre eles. O resultado é um novo mundo com os pokemons atualizados."
    # Movimenta os pokemons de ambos os jogadores
    NOVO-POKEMON1 = move-pokemon(w.pokemon1)
    NOVO-POKEMON2 = move-pokemon(w.pokemon2)
    # Processa os ataques de ambos os pokemons
    POKEMON1-APOS-ATAQUE = processa-ataque-pokemon(NOVO-POKEMON1, NOVO-POKEMON2)
    POKEMON2-APOS-ATAQUE = processa-ataque-pokemon(NOVO-POKEMON2, NOVO-POKEMON1)

    worldv0(POKEMON1-APOS-ATAQUE, POKEMON2-APOS-ATAQUE)
end

fun gera-video-v0(w :: Worldv0, max-frames :: Number) -> List<Image>:
    doc: "Dado um mundo e um número máximo de frames, gera uma lista de imagens representando a sequência de estados deste mundo ao longo do tempo, até que o jogo acabe ou chegue no limite de frames."
    ask:
        # Se o jogo acabou, a lista de imagens é vazia
        | acabou-jogo-v0(w) or (max-frames == 0) then: empty
        # Se não, gera lista com
        | otherwise: 
            link(
                # Imagem do frame atual do mundo
                desenha-mundo-v0(w), 
                # Lista de imagens dos frames seguintes, gerada a partir do mundo atualizado
                gera-video-v0(atualiza-mundo-v0(w), max-frames - 1))
    end
end

W-V0 = worldv0(BULBASAUR, CHARMANDER)

# Dê um argumento de terminação para a função `gera-video-v0`, assumindo que o valor do argumento max-frames seja positivo:
FRAMES = gera-video-v0(W-V0, 2000)
run-movie(120, FRAMES)

# Dê um argumento de terminação para a função `gera-video-v0`, assumindo que o valor do argumento max-frames seja negativo:
# FRAMES2 = gera-video-v0(W-V0, -1)
# run-movie(120, FRAMES2)


#|
    Batalha entre 2 Times de Pokémon

    Vamos agora expandir o jogo para considerar dois times de Pokemon batalhando!
|#

data World:
    # O mundo é uma estrutura que representa o estado do jogo, contendo os times dos dois jogadores
    | world(
        time-jogador1 :: Time,  # Time do jogador 1
        time-jogador2 :: Time   # Time do jogador 2
    )  
end

TIME1 = link(BULBASAUR, empty)
TIME2 = link(CHARMANDER, empty)

fun desenha-time(t :: Time, cena :: Image, nome-time :: String) -> Image:
    doc: "Dado um time, uma cena e um nome de time, gera uma imagem com os pokemons deste time sobre a cena, colocando o nome do time acima de cada pokémon."
    cases (Time) t:
        # Se o time estiver vazio, a imagem é apenas a cena
        | empty => cena
        # Senão,
        | link(first, rest) => 
            cor = ask:
                    | nome-time == "Jogador 1" then: "blue"
                    | otherwise: "red"
                end
            desenho-pokemon = 
                above(
                    text-font(nome-time, 10, cor, "Arial", "system", "normal", "normal", false), 
                    desenha-pokemon(first))

            # Desenha o pokemon first na sua posição sobre a cena resultante de desenhar o resto do time sobre a cena:
            desenho-pokemon
            # COMPLETE aqui usando a função place-image
    end
end

fun desenha-mundo(w :: World) -> Image:
    doc: "Dado um mundo, gera uma imagem representando o estado deste mundo. Para isso, basta desenhar os times dos jogadores sobre o cenário."
    # Desenha o cenário e sobrepõe as imagens dos times dos jogadores
    CENARIO # COMPLETE AQUI
end

fun acabou-jogo(w :: World) -> Boolean:
    doc: "Dado um mundo, devolve true se o jogo acabou (ou seja, se um dos jogadores não tem mais pokemons vivos) e false caso contrário."

    false # COMPLETE AQUI
where:
    acabou-jogo(world(empty, TIME1)) is true
    acabou-jogo(world(TIME1, empty)) is true
    acabou-jogo(world(TIME1, TIME2)) is false
end


fun atualiza-mundo(w :: World) -> World:
    doc: "Atualiza o mundo a cada tick do jogo, movendo os pokemons de ambos os jogadores e processando os ataques entre eles. O resultado é um novo mundo com os pokemons atualizados."
    # COMPLETE AQUI: movimente os pokemons do time do jogador 1 usando a função move-pokemon. Dica: use a função map para aplicar move-pokemon a cada pokemon do time.
    NOVO-TIME1 = w.time-jogador1 
    NOVO-TIME2 = w.time-jogador2

    world(
        filter(esta-vivo, processa-ataques(NOVO-TIME1, NOVO-TIME2)),
        filter(esta-vivo, processa-ataques(NOVO-TIME2, NOVO-TIME1))
    )
end
# Complexidade de tempo da função `atualiza-mundo` em termos do tamanho dos times dos jogadores (N):
# COMPLETE AQUI

fun processa-ataque(p :: Pokemon, time-inimigo :: Time) -> Pokemon:
    doc: "Dado um pokemon e um time inimigo, devolve o pokemon atualizado após processar os ataques do time inimigo. O pokemon é atacado pelo primeiro pokemon do time inimigo que colidir com ele, e a direção do pokemon é invertida a cada ataque sofrido."

    cases (Time) time-inimigo:
        # Se o time inimigo estiver vazio, o pokemon não é atacado e é retornado sem alterações
        | empty => p
        | link(f, r) =>
            ask:
                # Se o pokemon colidiu com o primeiro inimigo
                | colidiu(p, f) then: 
                    # Aplica o ataque do pokemon inimigo sobre o pokemon e inverte sua direção
                    inverte-direcao(ataque-pokemon(f, p))
                | otherwise: 
                    # Se não colidiu, continua verificando os ataques do resto do time inimigo
                    processa-ataque(p, r)
            end
    end
end

fun processa-ataques(time-defensor :: Time, time-atacante :: Time) -> Time:
    doc: "Dado um time defensor e um time atacante, devolve o time resultante de processar os ataques do time atacante sobre cada pokemon do time defensor."
    map(lam(p): processa-ataque(p, time-atacante) end, time-defensor)
end


#|
    Jogo
|#

fun gera-video(w :: World) -> List<Image>:
    doc: "Dado um mundo, gera uma lista de imagens representando a sequência de estados deste mundo ao longo do tempo, até que o jogo acabe."
    ask:
        # Se o jogo acabou, a lista de imagens é vazia
        | acabou-jogo(w) then: empty
        | otherwise: 
        # Se não, gera lista com a imagem do frame atual do mundo seguida da lista de imagens dos frames seguintes, gerada a partir do mundo atualizado
            link(
                desenha-mundo(w), 
                gera-video(atualiza-mundo(w)))
    end
end

# Argumento de Terminação para a função `gera-video`:
# COMPLETE AQUI

# TIME-JOGADOR1 = cria-time(POKE-DATA, lista-aleatoria(6, 1, 721))
# TIME-JOGADOR2 = cria-time(POKE-DATA, lista-aleatoria(6, 1, 721))

# WORLD = world(TIME-JOGADOR1, TIME-JOGADOR2)
# run-movie(120, gera-video(WORLD))
