use context dcic2024

import color from color
import color as C
include image
include csv
include data-source
include reactors

include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib6.arr")


data World:
    # O mundo é uma estrutura que representa o estado do jogo, contendo os times dos dois jogadores
    | world(
        time-jogador1 :: Time,  # Time do jogador 1
        time-jogador2 :: Time   # Time do jogador 2
    )  
end

BULBASAUR = extrai-pokemon-tabela(1, POKE-DATA)
CHARMANDER = extrai-pokemon-tabela(4, POKE-DATA)
SQUIRTLE = extrai-pokemon-tabela(7, POKE-DATA)
PSYDUCK = extrai-pokemon-tabela(54, POKE-DATA)
MEWTWO = extrai-pokemon-tabela(150, POKE-DATA)
GENGAR = extrai-pokemon-tabela(94, POKE-DATA)

TIME1 = link(BULBASAUR, link(CHARMANDER, link(SQUIRTLE, empty)))
TIME2 = link(PSYDUCK, link(MEWTWO, empty))


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
end

fun inverte-direcao(p :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon, devolve o pokemon resultante de inverter sua direção (dx, dy)."
    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando as direções invertidas
    pokemon(p.nome, p.id, p.tipo, p.x, p.y, -1 * p.dx, -1 * p.dy, p.speed, p.hp, p.max-hp, p.img, p.movimento)
end

fun move-pokemon(p :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon, devolve o pokemon resultante de movê-lo de acordo com sua velocidade (speed) e direção (dx, dy)."
    NOVO-X = p.x + (p.dx * p.speed)
    NOVO-Y = p.y + (p.dy * p.speed)
    NOVO-DX = ask:
        | NOVO-X < 0 then: -1 * p.dx # Inverte a direção horizontal se ultrapassar o limite esquerdo
        | NOVO-X > LARG then: -1 * p.dx # Inverte a direção horizontal se ultrapassar o limite direito
        | otherwise: p.dx # Mantém a direção horizontal
    end
    NOVO-DY = ask:
        | NOVO-Y < 0 then: -1 * p.dy # Inverte a direção vertical se ultrapassar o limite superior
        | NOVO-Y > ALT then: -1 * p.dy # Inverte a direção vertical se ultrapassar o limite inferior
        | otherwise: p.dy # Mantém a direção vertical
    end
    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando as novas coordenadas e direções ajustadas

    pokemon(p.nome, p.id, p.tipo, NOVO-X, NOVO-Y, NOVO-DX, NOVO-DY, p.speed, p.hp, p.max-hp, p.img, p.movimento)
end

fun colidiu(p1 :: Pokemon, p2 :: Pokemon) -> Boolean:
    doc: "Dado dois pokemons, devolve true se eles colidiram (ou seja, se suas imagens se sobrepõem) e false caso contrário."
    # Calcula as bordas dos pokemons com base em suas coordenadas e dimensões da imagem
    left1 = p1.x - (image-width(p1.img) / 2)
    right1 = p1.x + (image-width(p1.img) / 2)
    top1 = p1.y - (image-height(p1.img) / 2)
    bottom1 = p1.y + (image-height(p1.img) / 2)

    left2 = p2.x - (image-width(p2.img) / 2)
    right2 = p2.x + (image-width(p2.img) / 2)
    top2 = p2.y - (image-height(p2.img) / 2)
    bottom2 = p2.y + (image-height(p2.img) / 2)

    # Verifica se as bordas dos pokemons se sobrepõem
    not( 
        (right1 < left2) or (left1 > right2) or (bottom1 < top2) or (top1 > bottom2) 
    )
end

fun desenha-time(t :: Time, cena :: Image, nome-time :: String) -> Image:
    doc: "Dado um time, uma cena e um nome de time, gera uma imagem com os pokemons deste time um ao lado do outro."
    cases (Time) t:
        | empty => cena
        | link(first, rest) => 
            cor = ask:
                    | nome-time == "Jogador 1" then: "blue"
                    | otherwise: "red"
                end
            desenho-pokemon = above(text-font(nome-time, 10, cor, "Arial", "system", "normal", "normal", false), desenha-pokemon(first))
        
        place-image(desenho-pokemon, first.x, first.y, desenha-time(rest, cena, nome-time))
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

fun esta-vivo(p :: Pokemon) -> Boolean:
    doc: "Dado um pokemon, devolve true se o hp deste pokemon for maior que 0, e false caso contrário."
    p.hp > 0
where:
    esta-vivo(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))) is true
    esta-vivo(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 0, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))) is false
end

fun atualiza-mundo(w :: World) -> World:
    doc: "Atualiza o mundo a cada tick do jogo, movendo os pokemons de ambos os jogadores e processando os ataques entre eles. O resultado é um novo mundo com os pokemons atualizados."
    NOVO-TIME1 = map(move-pokemon, w.time-jogador1)
    NOVO-TIME2 = map(move-pokemon, w.time-jogador2)

    world(
        filter(esta-vivo, processa-ataques(NOVO-TIME1, NOVO-TIME2)),
        filter(esta-vivo, processa-ataques(NOVO-TIME2, NOVO-TIME1))
    )
end

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

fun processa-ataques(time1 :: Time, time2 :: Time) -> Time:
    doc: "Dado um time e um time inimigo, devolve o time resultante de processar os ataques do time inimigo sobre cada pokemon do time. Para isso, basta mapear a função `processa-ataque` para cada pokemon do time, utilizando o time inimigo como argumento."
    map(lam(p): processa-ataque(p, time2) end, time1)
end

fun lista-aleatoria(n :: Number, min :: Number, max :: Number) -> List<Number>:
    doc: "Gera uma lista de n números aleatórios no intervalo [min, max]."
    ask:
        | n == 0 then: empty
        | otherwise:
            link(
                random((max - min) + 1) + min,
                lista-aleatoria(n - 1, min, max))
    end
end

# Jogo

fun run-game(w :: World) -> World:
    doc: "Função para rodar o jogo, utilizando um reator para atualizar o mundo a cada tick, desenhar o mundo e verificar quando o jogo acabou."
    r = reactor:
        init: w, # Estado inicial do mundo
        on-tick: lam(x): atualiza-mundo(x) end, # Função para atualizar o mundo a cada tick
        to-draw: desenha-mundo, # Função para desenhar o mundo
        stop-when: acabou-jogo, # Função para verificar quando o jogo acabou
        title: "Pokémon Battle Game - Pensamento Computacional" # Título da janela do jogo
    end

    interact(r)
end

# A função acima é equivalente a:
fun gera-video(w :: World) -> List<Image>:
    doc: "Dado um mundo, gera uma lista de imagens representando a sequência de estados deste mundo ao longo do tempo, até que o jogo acabe."
    ask:
        | acabou-jogo(w) then: empty
        | otherwise: 
            link(
                desenha-mundo(w), 
                gera-video(atualiza-mundo(w)))
    end
end

TIME-JOGADOR1 = cria-time(POKE-DATA, lista-aleatoria(6, 1, 721))
TIME-JOGADOR2 = cria-time(POKE-DATA, lista-aleatoria(6, 1, 721))

#TIME-AGUA = link(SQUIRTLE, empty)
#TIME-FOGO = link(CHARMANDER, empty)

WORLD = world(TIME-JOGADOR1, TIME-JOGADOR2)
# WORLD = world(TIME-AGUA, TIME-FOGO)

run-game(WORLD)
