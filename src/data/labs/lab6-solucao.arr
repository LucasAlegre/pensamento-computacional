use context starter2024


#|
    Este arquivo contém a solução dos exercícios do Laboratório 6 de INF05008 - Pensamento Computacional.

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
    NOVO-X = p.x + (p.dx * p.speed)  # Cada coordenada é atualizada somando a direção multiplicada pela velocidade do pokemon
    NOVO-Y = p.y + (p.dy * p.speed)
    NOVO-DX = ask:
        | (NOVO-X < 0) or (NOVO-X > LARG) then: -1 * p.dx # Inverte a direção horizontal se ultrapassar o limite esquerdo ou direito
        | otherwise: p.dx # Mantém a direção horizontal
    end
    NOVO-DY = ask:
        | (NOVO-Y < 0) or (NOVO-Y > ALT) then: -1 * p.dy # Inverte a direção vertical se ultrapassar o limite superior ou inferior
        | otherwise: p.dy # Mantém a direção vertical
    end
    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando as novas coordenadas e direções ajustadas

    pokemon(p.nome, p.id, p.tipo, NOVO-X, NOVO-Y, NOVO-DX, NOVO-DY, p.speed, p.hp, p.max-hp, p.img, p.movimento)
end

fun aplica-movimento(p :: Pokemon, m :: Movimento) -> Pokemon:
    doc: "Dado um pokemon e um movimento, devolve o pokemon resultante de aplicar este movimento sobre este pokemon. Em caso do movimento do tipo Ataque, o dado é multiplicado pelo multiplicador do efeito correspondente."
    cases (Movimento) m:
        | ataque(nome, tipo, poder) => 
            # Subtrai o HP transformando o poder do ataque em negativo (-1 * poder)
            # e multiplicando a quantidade de dano pelo multiplicador obtido das fraquezas e resistências
            dano = -1 * (poder * efeito-to-multiplicador(verifica-efeito(tipo, p.tipo)))

            atualiza-hp(p, dano)
            
        | cura(nome, c) => 
            # Apenas incrementa a vida do pokemon utilizando a quantidade de cura `c`
            atualiza-hp(p, c)
    end
end

fun ataque-pokemon(p-atacante :: Pokemon, p-defensor :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon atacante e um pokemon defensor, devolve o pokemon defensor resultante de ser atacado pelo pokemon atacante utilizando seu movimento."
    aplica-movimento(p-defensor, p-atacante.movimento)
where:
    ataque-pokemon(
        pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Ataque", ELECTRIC, 40)), 
        pokemon("Charmander", 4, FIRE, 0, 0, 0, 0, 0, 45, 45, img-pokemon(4), ataque("Ataque", FIRE, 45))) is pokemon("Charmander", 4, FIRE, 0, 0, 0, 0, 0, 5, 45, img-pokemon(4), ataque("Ataque", FIRE, 45))
end

fun inverte-direcao(p :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon, devolve o pokemon resultante de inverter sua direção (dx, dy)."
    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando as direções invertidas
    pokemon(p.nome, p.id, p.tipo, p.x, p.y, -1 * p.dx, -1 * p.dy, p.speed, p.hp, p.max-hp, p.img, p.movimento)
end

fun colidiu(p1 :: Pokemon, p2 :: Pokemon) -> Boolean:
    doc: "Dado dois pokemons, devolve true se eles colidiram (ou seja, se suas imagens se sobrepõem) e false caso contrário."
    distancia = sqrt(sqr((p1.x - p2.x)) + sqr((p1.y - p2.y)))

    distancia <= 115
where:
    colidiu(
        pokemon("Pikachu", 25, ELECTRIC, 50, 50, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), 
        pokemon("Bulbasaur", 1, GRASS, 55, 50, 0, 0, 0, 45, 45, img-pokemon(1), ataque("Vine Whip", GRASS, 45))) is true
    colidiu(
        pokemon("Pikachu", 25, ELECTRIC, 50, 50, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), 
        pokemon("Bulbasaur", 1, GRASS, 200, 200, 0, 0, 0, 45, 45, img-pokemon(1), ataque("Vine Whip", GRASS, 45))) is false
end

fun esta-vivo(p :: Pokemon) -> Boolean:
    doc: "Dado um pokemon, devolve true se o hp deste pokemon for maior que 0, e false caso contrário."
    p.hp > 0
where:
    esta-vivo(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))) is true
    esta-vivo(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 0, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))) is false
end

fun acabou-jogo-v0(w :: Worldv0) -> Boolean:
    doc: "Dado um mundo, devolve true se o jogo acabou (ou seja, se um dos pokemons não está mais vivo) e false caso contrário."
    not(esta-vivo(w.pokemon1)) or not(esta-vivo(w.pokemon2))
where:
    acabou-jogo-v0(worldv0(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), pokemon("Bulbasaur", 1, GRASS, 0, 0, 0, 0, 0, 45, 45, img-pokemon(1), ataque("Vine Whip", GRASS, 45)))) is false
    acabou-jogo-v0(worldv0(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), pokemon("Bulbasaur", 1, GRASS, 0, 0, 0, 0, 0, 0, 45, img-pokemon(1), ataque("Vine Whip", GRASS, 45)))) is true
end

fun desenha-mundo-v0(w :: Worldv0) -> Image:
    doc: "Dado um mundo, gera uma imagem representando o estado deste mundo. Para isso, basta desenhar os pokemons dos jogadores sobre o cenário."
    place-image(
        desenha-pokemon(w.pokemon1), w.pokemon1.x, w.pokemon1.y,
        place-image(
            desenha-pokemon(w.pokemon2), w.pokemon2.x, w.pokemon2.y,
            CENARIO))
end

fun processa-ataque-pokemon(p :: Pokemon, inimigo :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon e um pokemon inimigo, devolve o pokemon atualizado após processar o ataque do pokemon inimigo. O pokemon é atacado pelo pokemon inimigo se eles colidirem, e a direção do pokemon é invertida a cada ataque sofrido."
    ask:
        | colidiu(p, inimigo) then: 
            # Aplica o ataque do pokemon inimigo sobre o pokemon e inverte sua direção
            inverte-direcao(ataque-pokemon(inimigo, p))
        | otherwise: 
            # Se não colidiu, o pokemon não é atacado e é retornado sem alterações
            p
    end
end

fun atualiza-mundo-v0(w :: Worldv0) -> Worldv0:
    doc: "Atualiza o mundo a cada tick do jogo, movendo os pokemons e processando os ataques entre eles. O resultado é um novo mundo com os pokemons atualizados."
    # Movimenta os pokemons de ambos os jogadores
    NOVO-POKEMON1 = move-pokemon(w.pokemon1)
    NOVO-POKEMON2 = move-pokemon(w.pokemon2)
    # Processa os ataques de ambos os pokemons
    POKEMON1-APOS-ATAQUE = processa-ataque-pokemon(NOVO-POKEMON1, NOVO-POKEMON2)
    POKEMON2-APOS-ATAQUE = processa-ataque-pokemon(NOVO-POKEMON2, NOVO-POKEMON1)

    worldv0(POKEMON1-APOS-ATAQUE, POKEMON2-APOS-ATAQUE)  # Mundo com times atualizados
end

fun gera-video-v0(w :: Worldv0, max-frames :: Number) -> List<Image>:
    doc: "Dado um mundo, gera uma lista de imagens representando a sequência de estados deste mundo ao longo do tempo, até que o jogo acabe."
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
# FRAMES = gera-video-v0(W-V0, 2000)
# run-movie(120, FRAMES)

# A função `gera-video-v0`, ao receber um valor positivo para max-frames, irá realizar uma recursão estrutural sobre o número de frames. A função possui um caso base (condição de término), que é max-frames igual a 0. 
# A cada chamada recursiva, o valor de max-frames é decrementado em 1, o que garante que a recursão irá terminar após gerar o número especificado de frames. Assim, a função é garantida a terminar para qualquer valor positivo de max-frames.

# Dê um argumento de terminação para a função `gera-video-v0`, assumindo que o valor do argumento max-frames seja negativo:
# FRAMES2 = gera-video-v0(W-V0, -1)
# run-movie(120, FRAMES2)

# A função `gera-video-v0`, ao receber um valor negativo para max-frames, possui um único caso de término, que acontece quando acabou-jogo-v0(w) retorna true.
# Para que a execução da função termine, é necessário mostrar que ela se aproxima desse caso de término. Isso é verdade nas seguintes condições:
# - Os dois pokemons tem deslocamentos diferentes de 0 e velocidades positivas, o que garante que eles irão se mover e eventualmente colidir.
# - Algum dos pokemon possui movimento do tipo ataque, com custo positivo, e o outro pokemon é vulnerável a esse tipo de ataque (ou seja, tem uma fraqueza que resulta em multiplicador diferente de 0). Isso garante que, quando os pokemons colidirem, um deles irá sofrer dano suficiente para ter seu HP reduzido a 0 ou menos, o que fará com que acabou-jogo-v0(w) retorne true e termine a execução da função.
# Finalmente, as funções auxiliares desenha-mundo-v0, atualiza-mundo-v0 e link também terminam, pois operam sobre dados finitos e não são recursivas em si mesmas. Assim, a função gera-video-v0 é garantida a terminar para qualquer valor negativo de max-frames, desde que as condições acima sejam atendidas.

#|
    Batalha entre 2 Times de Pokémon
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
        # Se time estiver vazio, a imagem resultante é apenas a cena
        | empty => cena
        | link(first, rest) => 
            cor = ask:
                    | nome-time == "Jogador 1" then: "blue"
                    | otherwise: "red"
                end
            desenho-pokemon = 
                above(
                    text-font(nome-time, 10, cor, "Arial", "system", "normal", "normal", false), 
                    desenha-pokemon(first))

            # Desenha o pokemon first na sua posição, sobre a cena resultante de desenhar o resto do time sobre a cena:
            place-image(
                desenho-pokemon, 
                first.x, 
                first.y, 
                desenha-time(rest, cena, nome-time))
    end
end

fun desenha-mundo(w :: World) -> Image:
    doc: "Dado um mundo, gera uma imagem representando o estado deste mundo. Para isso, basta desenhar os times dos jogadores sobre o cenário."
    # Desenha o cenário e sobrepõe as imagens dos times dos jogadores
    CENA = desenha-time(w.time-jogador1, CENARIO, "Jogador 1")

    desenha-time(w.time-jogador2, CENA, "Jogador 2")
end

fun acabou-jogo(w :: World) -> Boolean:
    doc: "Dado um mundo, devolve true se o jogo acabou (ou seja, se um dos jogadores não tem mais pokemons vivos) e false caso contrário."
    is-empty(w.time-jogador1) or is-empty(w.time-jogador2)
where:
    acabou-jogo(world(empty, TIME1)) is true
    acabou-jogo(world(TIME1, empty)) is true
    acabou-jogo(world(TIME1, TIME2)) is false
end


fun atualiza-mundo(w :: World) -> World:
    doc: "Atualiza o mundo a cada tick do jogo, movendo os pokemons de ambos os jogadores e processando os ataques entre eles. O resultado é um novo mundo com os pokemons atualizados."
    NOVO-TIME1 = map(move-pokemon, w.time-jogador1) # Movimenta os pokemons do jogador
    NOVO-TIME2 = map(move-pokemon, w.time-jogador2)

    # Cria novo time, processando os ataques de ambos os jogadores. O time resultante é filtrado para manter apenas os pokemons que estão vivos.
    world(
        filter(esta-vivo, processa-ataques(NOVO-TIME1, NOVO-TIME2)),
        filter(esta-vivo, processa-ataques(NOVO-TIME2, NOVO-TIME1))
    )
end
# Complexidade de tempo da função `atualiza-mundo` em termos do tamanho dos times dos jogadores (N): O(N^2)
# Para mover cada pokemon, a função move-pokemon faz recursão estrutural (através da função map) sobre o time, o que tem complexidade O(N) pois cada poémon é processado uma vez.
# Já a funçao processa-ataques tem complexidade O(N^2) porque, para cada pokemon do time defensor, ela processa os ataques de todos os pokemons do time atacante. Assim, se ambos os times tiverem N pokemons, serão N pokemons defensores processando ataques de N pokemons atacantes, resultando em N * N = O(N^2) para processar os ataques.
# Por fim, a filtragem para manter apenas os pokemons vivos tem complexidade O(N) para cada time, resultando em O(N) + O(N) = O(N) para a filtragem. 
# Portanto, a complexidade total da função atualiza-mundo é O(N^2) devido à etapa de processamento dos ataques, que tem o maior impacto na complexidade.

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
# A função `gera-video` possui um caso de término definido pela condição acabou-jogo(w). Para garantir que a função termine, é necessário mostrar que a execução da função se aproxima desse caso de término. Isso é verdade nas seguintes condições:
# - Os pokemons dos jogadores tem deslocamentos diferentes de 0 e velocidades positivas, o que garante que eles irão se mover e eventualmente colidir.
# - Algum dos pokemons possui movimento do tipo ataque, com custo positivo, e o outro pokemon é vulnerável a esse tipo de ataque (ou seja, tem uma fraqueza que resulta em multiplicador diferente de 0). Isso garante que, quando os pokemons colidirem, um deles irá sofrer dano suficiente para ter seu HP reduzido a 0 ou menos, o que fará com que acabou-jogo(w) retorne true e termine a execução da função.
# Finalmente, as funções auxiliares acabou-jogo, desenha-mundo, atualiza-mundo e link também terminam, pois ou não são recursivas ou operam sobre recursão estrutural sobre dados finitos. Assim, a função gera-video é garantida a terminar, desde que as condições acima sejam atendidas.


TIME-JOGADOR1 = cria-time(POKE-DATA, lista-aleatoria(6, 1, 721))
TIME-JOGADOR2 = cria-time(POKE-DATA, lista-aleatoria(6, 1, 721))

WORLD = world(TIME-JOGADOR1, TIME-JOGADOR2)
# run-movie(20, gera-video(WORLD))
