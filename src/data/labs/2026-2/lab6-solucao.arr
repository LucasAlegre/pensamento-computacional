use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 6 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
include reactors


#|
    Regras do jogo (constantes)
|#

GRAVIDADE = 1   # Quanto a velocidade vertical do pássaro aumenta a cada tick em que ele não bate as asas
PULO = -6       # Velocidade vertical do pássaro logo depois de bater as asas (negativa: para cima)
VEL-MUROS = 4   # Quantos pixels os muros andam para a esquerda a cada tick


#|
    ============================================================================
    PARTE PRONTA: medidas, definições de dados, exemplos, desenho e exibição do jogo.
    Leia esta parte para conhecer os dados e as funções disponíveis, mas não precisa alterá-la.
    ============================================================================
|#

#|
    Medidas do cenário
|#

LARG = 600           # Largura do cenário, em pixels
ALT = 400            # Altura do cenário, em pixels (lembre: y cresce para baixo)
X-PASSARO = 120      # O pássaro voa sempre na coluna x = X-PASSARO
RAIO-PASSARO = 15    # O pássaro ocupa um quadrado de lado 2 * RAIO-PASSARO em volta do seu centro
LARG-MURO = 60       # Largura de um muro
ALT-VAO = 90         # Altura do vão (a passagem) de um muro
ESPACO-MUROS = 300   # Distância horizontal entre dois muros seguidos no mundo inicial

NUVEM = beside(circle(18, "solid", "white"), beside(circle(26, "solid", "white"), circle(18, "solid", "white")))
CENARIO = place-image(NUVEM, 150, 90,
  place-image(NUVEM, 460, 160,
    place-image(NUVEM, 330, 320,
      rectangle(LARG, ALT, "solid", "skyblue"))))


#|
    Definições de Dados
|#

data Passaro:
  # O quero-quero. Ele voa sempre na coluna x = X-PASSARO: só a altura muda.
  | passaro(
      y :: Number,   # Coordenada y do centro do pássaro
      vy :: Number)  # Velocidade vertical: quanto y muda a cada tick (negativa: subindo; positiva: descendo)
end

data Muro:
  # Um muro com um vão (uma passagem) por onde o pássaro pode passar
  | muro(
      x :: Number,    # Coordenada x do centro do muro
      vao :: Number)  # Coordenada y do centro do vão
end

data Mundo:
  # O estado do jogo em um instante
  | mundo(
      passaro :: Passaro,   # O pássaro
      muros :: List<Muro>)  # Os muros que ainda não saíram da tela, da esquerda para a direita
end


#|
    Exemplos para usar nas cláusulas where:
|#

PASSARO-TESTE = passaro(200, 0)  # No meio da altura do cenário, parado
MURO-LONGE = muro(400, 200)      # Longe do pássaro, com o vão no meio da altura
MURO-NO-MEIO = muro(130, 200)    # Na frente do pássaro, com o vão no meio da altura: o PASSARO-TESTE passa pelo vão
MURO-ALTO = muro(130, 100)       # Na frente do pássaro, com o vão no alto: o PASSARO-TESTE bate no muro

MUNDO-TESTE = mundo(PASSARO-TESTE, [list: MURO-LONGE])


#|
    Desenho
|#

CORPO = overlay(ellipse(16, 8, "solid", "dim-gray"), circle(RAIO-PASSARO, "solid", "lightgray"))
OLHO = overlay(circle(2, "solid", "black"), circle(4, "solid", "red"))
BICO = rotate(-90, triangle(10, "solid", "orange"))
IMG-PASSARO = beside(place-image(OLHO, 22, 10, CORPO), BICO)

fun desenha-passaro(p :: Passaro, cena :: Image) -> Image:
  doc: "Dados o pássaro e uma cena, devolve a cena com o pássaro desenhado na posição (X-PASSARO, p.y)."
  place-image(IMG-PASSARO, X-PASSARO, p.y, cena)
end

fun bloco(altura :: Number) -> Image:
  doc: "Dada uma altura, devolve um bloco de muro com largura LARG-MURO e esta altura."
  overlay(rectangle(LARG-MURO, altura, "outline", "brown"), rectangle(LARG-MURO, altura, "solid", "fire-brick"))
end

fun desenha-muro(m :: Muro, cena :: Image) -> Image:
  doc: "Dados um muro e uma cena, devolve a cena com o muro desenhado: um bloco acima do vão e outro abaixo."
  alt-cima = num-max(m.vao - (ALT-VAO / 2), 0)          # Altura do bloco acima do vão
  alt-baixo = num-max(ALT - (m.vao + (ALT-VAO / 2)), 0)  # Altura do bloco abaixo do vão
  com-cima = place-image(bloco(alt-cima), m.x, alt-cima / 2, cena)
  place-image(bloco(alt-baixo), m.x, ALT - (alt-baixo / 2), com-cima)
end

fun desenha-placar(restantes :: Number, cena :: Image) -> Image:
  doc: "Dados o número de muros restantes e uma cena, devolve a cena com o placar escrito no topo."
  place-image(text("Muros restantes: " + num-to-string(restantes), 20, "black"), LARG / 2, 20, cena)
end

fun desenha-muros(l :: List<Muro>, cena :: Image) -> Image:
  doc: "Dados uma lista de muros e uma cena, devolve a cena com todos os muros desenhados."
  cases (List) l:
    # Sem muros: a cena não muda
    | empty => cena
    # Desenha o primeiro muro sobre a cena com o resto dos muros
    | link(m, r) => desenha-muro(m, desenha-muros(r, cena))
  end
end

fun desenha-mundo(jogo :: Mundo) -> Image:
  doc: "Dado um mundo, devolve a cena do jogo: os muros e o pássaro sobre o CENARIO, com o número de muros restantes no topo."
  com-muros = desenha-muros(jogo.muros, CENARIO)
  com-passaro = desenha-passaro(jogo.passaro, com-muros)
  desenha-placar(length(jogo.muros), com-passaro)
end


#|
    Criação do mundo inicial
|#

fun cria-muros(n :: Number, x :: Number) -> List<Muro>:
  doc: ```Dados um número n e uma posição x, devolve uma lista com n muros: o primeiro na posição x e cada
       um ESPACO-MUROS pixels à direita do anterior. O centro de cada vão fica em uma altura aleatória
       entre 130 e 270.```
  ask:
    # Nenhum muro a criar
    | n <= 0 then: empty
    # Um muro na posição x, seguido dos outros n - 1 muros
    | otherwise: link(muro(x, num-random(141) + 130), cria-muros(n - 1, x + ESPACO-MUROS))
  end
where:
  cria-muros(0, LARG) is empty
  map(lam(m): m.x end, cria-muros(3, LARG)) is [list: 600, 900, 1200]
end

fun mundo-inicial(n :: Number) -> Mundo:
  doc: "Dado um número n, devolve o mundo no início do jogo: o pássaro parado no meio da altura do cenário e n muros, o primeiro na borda direita do cenário."
  mundo(passaro(ALT / 2, 0), cria-muros(n, LARG))
where:
  mundo-inicial(4).passaro is passaro(200, 0)
  length(mundo-inicial(4).muros) is 4
end


#|
    Exibição do jogo
|#

fun run-movie(fps :: Number, cenas :: List<Image>):
  doc: ```Dados um número de quadros por segundo e uma lista de cenas, exibe as cenas como um filme,
       mostrando cada cena por 1/fps segundos. A última cena fica na tela até a janela ser fechada.```
  cases (List) cenas:
    # Sem cenas: não há o que exibir
    | empty => nothing
    # Exibe as cenas, uma por tick
    | link(_, _) =>
      n = length(cenas)
      r = reactor:
        init: 0,
        on-tick: lam(i): i + 1 end,
        to-draw: lam(i): cenas.get(i) end,
        seconds-per-tick: 1 / fps,
        stop-when: lam(i): i >= (n - 1) end,
        close-when-stop: false
      end
      interact(r)
  end
end


#|
    ============================================================================
    FIM DA PARTE PRONTA. Os exercícios começam abaixo.
    ============================================================================
|#


#|
    Exercício 1: O Pássaro
|#

fun voa(p :: Passaro, bate-asas :: Boolean) -> Passaro:
  doc: ```Dados o pássaro e se ele bate as asas, devolve o pássaro um tick depois. Se bate as asas, a
       velocidade vertical passa a ser PULO; senão, ela aumenta GRAVIDADE. Depois, y muda de acordo com a
       nova velocidade.```
  novo-vy = ask:
    # Bateu as asas: impulso para cima
    | bate-asas then: PULO
    # Não bateu as asas: a gravidade puxa para baixo
    | otherwise: p.vy + GRAVIDADE
  end
  passaro(p.y + novo-vy, novo-vy)
where:
  voa(PASSARO-TESTE, false) is passaro(201, 1)
  voa(PASSARO-TESTE, true) is passaro(194, -6)
  voa(passaro(300, 5), false) is passaro(306, 6)
end

fun piloto(p :: Passaro, muros :: List<Muro>) -> Boolean:
  doc: ```Dados o pássaro e a lista de muros, decide se o pássaro bate as asas: devolve true se o pássaro está
       abaixo do centro do vão do primeiro muro da lista, e false caso contrário (ou se não há muros).```
  cases (List) muros:
    # Sem muros: não precisa bater as asas
    | empty => false
    # Bate as asas se está abaixo do centro do vão do primeiro muro (y maior é mais para baixo)
    | link(m, _) => p.y > m.vao
  end
where:
  piloto(PASSARO-TESTE, [list: MURO-ALTO, MURO-LONGE]) is true
  piloto(PASSARO-TESTE, [list: MURO-NO-MEIO]) is false
  piloto(PASSARO-TESTE, empty) is false
end

fun fora-da-tela(p :: Passaro) -> Boolean:
  doc: "Dado o pássaro, devolve true se ele passou da borda de cima ou da borda de baixo do cenário, e false caso contrário."
  ((p.y - RAIO-PASSARO) < 0) or ((p.y + RAIO-PASSARO) > ALT)
where:
  fora-da-tela(PASSARO-TESTE) is false
  fora-da-tela(passaro(390, 3)) is true
  fora-da-tela(passaro(10, -6)) is true
end


#|
    Exercício 2: Os Muros
|#

fun move-muro(m :: Muro) -> Muro:
  doc: "Dado um muro, devolve o muro VEL-MUROS pixels para a esquerda."
  muro(m.x - VEL-MUROS, m.vao)
where:
  move-muro(MURO-LONGE) is muro(396, 200)
  move-muro(muro(0, 150)) is muro(-4, 150)
end

fun saiu-da-tela(m :: Muro) -> Boolean:
  doc: "Dado um muro, devolve true se ele já saiu inteiro pela borda esquerda do cenário, e false caso contrário."
  (m.x + (LARG-MURO / 2)) < 0
where:
  saiu-da-tela(muro(-31, 200)) is true
  saiu-da-tela(muro(-29, 200)) is false
  saiu-da-tela(MURO-LONGE) is false
end

fun move-muros(l :: List<Muro>) -> List<Muro>:
  doc: "Dada a lista de muros, devolve a lista com cada muro VEL-MUROS pixels para a esquerda, sem os muros que saíram da tela."
  filter(lam(m): not(saiu-da-tela(m)) end, map(move-muro, l))
where:
  move-muros(empty) is empty
  # O primeiro muro vai para x = -33 e sai da tela
  move-muros([list: muro(-29, 250), MURO-LONGE]) is [list: muro(396, 200)]
end


#|
    Exercício 3: Colisão
|#

fun bateu-no-muro(p :: Passaro, m :: Muro) -> Boolean:
  doc: ```Dados o pássaro e um muro, devolve true se o pássaro encosta no muro: o pássaro está na frente do muro
       e não está inteiro dentro do vão. Devolve false caso contrário.```
  na-frente = num-abs(m.x - X-PASSARO) < ((LARG-MURO / 2) + RAIO-PASSARO)
  fora-do-vao = ((p.y - RAIO-PASSARO) < (m.vao - (ALT-VAO / 2))) or ((p.y + RAIO-PASSARO) > (m.vao + (ALT-VAO / 2)))
  na-frente and fora-do-vao
where:
  bateu-no-muro(PASSARO-TESTE, MURO-ALTO) is true
  bateu-no-muro(PASSARO-TESTE, MURO-NO-MEIO) is false
  bateu-no-muro(PASSARO-TESTE, MURO-LONGE) is false
end

fun bateu-em-algum(p :: Passaro, l :: List<Muro>) -> Boolean:
  doc: "Dados o pássaro e uma lista de muros, devolve true se o pássaro encosta em algum muro da lista, e false caso contrário."
  cases (List) l:
    # Sem muros: não bateu
    | empty => false
    # Bateu no primeiro muro ou em algum muro do resto da lista
    | link(m, r) => bateu-no-muro(p, m) or bateu-em-algum(p, r)
  end
where:
  bateu-em-algum(PASSARO-TESTE, [list: MURO-LONGE, MURO-ALTO]) is true
  bateu-em-algum(PASSARO-TESTE, [list: MURO-NO-MEIO, MURO-LONGE]) is false
  bateu-em-algum(PASSARO-TESTE, empty) is false
end

#|
    Exercício 4: A Função Principal do Jogo

    Modelo de recursão generativa em gera-video, dado um mundo jogo:
    - Problema trivial: o jogo acabou (o pássaro passou por todos os muros, saiu da tela ou bateu).
      Solução: a lista só com a cena final, desenha-mundo(jogo).
    - Problema "menor": o mundo um tick depois.                -> atualiza-mundo(jogo)
      Solução: as cenas do jogo a partir do mundo seguinte.    -> gera-video(atualiza-mundo(jogo))
    - Combinação: a cena do mundo atual seguida dessas cenas.  -> link(desenha-mundo(jogo), ...)
|#

fun acabou-jogo(jogo :: Mundo) -> Boolean:
  doc: ```Dado um mundo, devolve true se o jogo acabou: o pássaro passou por todos os muros (não há mais muros),
       saiu da tela ou bateu em um muro. Devolve false caso contrário.```
  is-empty(jogo.muros) or fora-da-tela(jogo.passaro) or bateu-em-algum(jogo.passaro, jogo.muros)
where:
  acabou-jogo(mundo(PASSARO-TESTE, empty)) is true
  acabou-jogo(mundo(PASSARO-TESTE, [list: MURO-ALTO])) is true
  acabou-jogo(mundo(passaro(395, 0), [list: MURO-LONGE])) is true
  acabou-jogo(MUNDO-TESTE) is false
end

fun atualiza-mundo(jogo :: Mundo) -> Mundo:
  doc: ```Dado um mundo, devolve o mundo um tick depois: (1) o piloto decide se o pássaro bate as asas e o
       pássaro voa; (2) os muros andam VEL-MUROS pixels para a esquerda; (3) os muros que saíram da tela
       são removidos.```
  bate-asas = piloto(jogo.passaro, jogo.muros)
  mundo(voa(jogo.passaro, bate-asas), move-muros(jogo.muros))
where:
  # O pássaro está na altura do centro do vão: não bate as asas e cai
  atualiza-mundo(MUNDO-TESTE) is mundo(passaro(201, 1), [list: muro(396, 200)])
  # O pássaro está abaixo do centro do vão: bate as asas e sobe
  atualiza-mundo(mundo(passaro(250, 2), [list: MURO-LONGE])) is mundo(passaro(244, -6), [list: muro(396, 200)])
  # O primeiro muro sai da tela e é removido
  atualiza-mundo(mundo(PASSARO-TESTE, [list: muro(-29, 250), MURO-LONGE])) is mundo(passaro(201, 1), [list: muro(396, 200)])
end

fun gera-video(jogo :: Mundo) -> List<Image>:
  doc: ```Dado um mundo, devolve a lista de cenas do jogo a partir deste mundo, até o jogo acabar.
       A última cena da lista mostra o mundo em que o jogo acabou.```
  ask:
    # O jogo acabou: a lista só com a cena final
    | acabou-jogo(jogo) then: [list: desenha-mundo(jogo)]
    # Senão: a cena deste mundo, seguida das cenas geradas a partir do mundo um tick depois
    | otherwise: link(desenha-mundo(jogo), gera-video(atualiza-mundo(jogo)))
  end
where:
  # O jogo já acabou: só a cena final
  length(gera-video(mundo(PASSARO-TESTE, empty))) is 1
  # O pássaro já bateu no muro: só a cena final
  length(gera-video(mundo(PASSARO-TESTE, [list: MURO-ALTO]))) is 1
  # O único muro sai da tela no primeiro tick: a cena inicial e a cena final
  length(gera-video(mundo(PASSARO-TESTE, [list: muro(-29, 250)]))) is 2
end

CENAS = gera-video(mundo-inicial(5))
run-movie(30, CENAS)


#|
    Exercício 5: Terminação

    1. Caso trivial: acabou-jogo(jogo), que não faz chamada recursiva.
       Aproximação do caso trivial: a cada tick, todos os muros andam VEL-MUROS = 4 pixels para a esquerda,
       e nenhum muro novo é criado. Então a posição x do último muro diminui 4 a cada chamada recursiva.
       Um muro é removido quando x + LARG-MURO / 2 < 0. Se o último muro começa na posição x0, depois de no
       máximo (x0 + 30) / 4 + 1 ticks todos os muros foram removidos, a lista fica vazia e acabou-jogo é true.
       O jogo pode acabar antes, se o pássaro bater, mas não depois.
       As funções auxiliares terminam: ou não são recursivas, ou fazem recursão estrutural (map, filter ou
       cases) sobre listas finitas.
       Premissas: VEL-MUROS > 0, lista de muros finita e nenhum muro novo durante o jogo.
       O movimento do pássaro não aparece no argumento: o jogo termina com qualquer piloto.

    2. Com VEL-MUROS = 0, os muros ficam parados e a lista nunca fica vazia. O jogo só acaba se o pássaro bater.
       Com este piloto, o pássaro fica subindo e descendo perto do centro do vão do primeiro muro e nunca
       bate: o programa não termina (é preciso clicar em Stop). Com um piloto ruim (por exemplo, que nunca bate
       as asas), o pássaro cai, sai da tela e o jogo termina. Ou seja, sem a premissa VEL-MUROS > 0, a
       terminação passa a depender do pássaro, e o argumento do item 1 não vale mais.

    3. No modo infinito, a lista de muros nunca fica vazia, e o jogo só acaba quando o pássaro bate.
       Um piloto que nunca erra faz o jogo nunca terminar. Para garantir a terminação, é preciso um limite:
       por exemplo, guardar no mundo quantos muros o pássaro já passou e terminar o jogo quando chegar a um
       número máximo (ou limitar o número de ticks). LIMITE - muros passados diminui a cada muro que sai da
       tela, e cada muro sai da tela em no máximo (LARG + ESPACO-MUROS + 30) / VEL-MUROS ticks.
|#


#|
    Exercício 6: Custo (N = número de muros)

    1. Em cada chamada de gera-video (sem contar a chamada recursiva): acabou-jogo percorre a lista uma vez
       (bateu-em-algum); desenha-mundo percorre a lista uma vez (desenha-muros); atualiza-mundo chama piloto
       e voa, que são O(1), e move-muros, que percorre a lista duas vezes (map e filter).
       Então cada chamada custa O(N).

    2. O último muro começa na posição LARG + (N - 1) * ESPACO-MUROS, então o jogo tem cerca de
       (600 + 300 * (N - 1) + 30) / 4 ticks (se o pássaro não bater): 3 muros dão 309 cenas,
       6 muros dão 534 e 12 muros dão 984. Cada muro a mais acrescenta 75 ticks: o número de ticks
       cresce linearmente com N, O(N).

    3. Custo total de gera-video: O(N) ticks * O(N) por tick = O(N²).

    Desafio 3: como os muros estão a 300 pixels um do outro, no máximo um muro está na frente do pássaro
    em cada tick, e ele é um dos dois primeiros da lista. Testando só esses dois, a colisão custa O(1)
    (mas mover e desenhar os muros continua O(N)).
|#


#|
    ============================================================================
    O JOGO (pronto): jogue você mesmo, controlando o pássaro pelo teclado.
    A barra de espaço (ou a seta para cima) faz o pássaro bater as asas.

    O jogo usa as suas funções dos Exercícios 1 a 3: voa, fora-da-tela, move-muros e bateu-em-algum.
    No começo, com essas funções incompletas, o jogo fica parado. A cada exercício, uma parte passa a
    funcionar: o pássaro voa e cai (Ex. 1), os muros andam (Ex. 2) e o jogo acaba quando o pássaro
    bate (Ex. 3). Feche a janela do jogo para ver o resultado dos testes.
    ============================================================================
|#

data Partida:
  # O estado de uma partida jogada pelo teclado
  | partida(
      jogo :: Mundo,          # O mundo do jogo
      bate-asas :: Boolean)   # Se uma tecla foi apertada desde o último tick
end

fun jogar(n :: Number):
  doc: ```Abre o jogo com n muros, controlado pelo teclado. No lugar do piloto, quem decide se o pássaro
       bate as asas é você: apertar espaço (ou a seta para cima) faz ele bater as asas no próximo tick.```
  r = reactor:
    init: partida(mundo-inicial(n), false),
    on-tick: lam(s):
        j = s.jogo
        partida(mundo(voa(j.passaro, s.bate-asas), move-muros(j.muros)), false)
      end,
    on-key: lam(s, tecla):
        if (tecla == " ") or (tecla == "up"): partida(s.jogo, true)
        else: s
        end
      end,
    to-draw: lam(s): desenha-mundo(s.jogo) end,
    stop-when: lam(s):
        j = s.jogo
        is-empty(j.muros) or fora-da-tela(j.passaro) or bateu-em-algum(j.passaro, j.muros)
      end,
    seconds-per-tick: 1 / 30,
    close-when-stop: false
  end
  interact(r)
end

# Para rodar só os testes, sem abrir o jogo, comente a linha abaixo:
jogar(10)
