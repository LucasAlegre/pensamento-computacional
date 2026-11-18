# Laboratório 6: Voo do Quero-Quero

## 🎯 Contexto e Objetivos

Neste laboratório, vamos construir um jogo: o **Voo do Quero-Quero**. Um quero-quero voa pelo cenário, e muros com um vão (uma passagem) vêm da direita na direção dele. O pássaro precisa bater as asas na hora certa para passar pelos vãos sem encostar nos muros.

Você vai poder jogar pelo teclado, mas o foco do laboratório é outro: um **piloto automático** decide quando o pássaro bate as asas, e o programa gera o filme da partida com **recursão generativa**, como a função `move-ate-que-fora` da Aula 25. No final, vamos analisar a **terminação** e o **custo** do programa (Aulas 25 e 27).

<br>

O template já traz uma **parte pronta**, no início do arquivo, com as definições de dados, as medidas do cenário, exemplos para os testes e toda a parte gráfica do jogo. Leia essa parte para conhecer os tipos, as constantes e as funções já disponíveis. Não é preciso alterá-la.

> 💡 **INSTRUÇÕES PARA O LABORATÓRIO:**
> - Siga as dicas de estilo de código do Pyret: https://lucasalegre.github.io/pensamento-computacional/topics/style-guide
> - Use exatamente os nomes de constantes e funções definidos nos enunciados.
> - Todas as funções devem conter documentação completa: **contrato de tipos**, string de objetivo (`doc:`) e pelo menos **2 exemplos/testes** na cláusula `where:` (só não é obrigatório incluir testes nas funções que geram imagens).
> - Em todas as cláusulas condicionais (`ask`, `cases`, `if`), inclua um comentário explicando cada caso.

---

## Template

Copie o template para o seu ambiente de desenvolvimento (code.pyret.org ou VS Code). Não esqueça de salvar o seu arquivo!

```pyret
file: src/data/labs/2026-2/lab6-template.arr
```

### 🕹️ O jogo vai funcionando aos poucos

Rode o template assim que copiá-lo: abre uma janela com o jogo **parado**. A última linha do template, `jogar(10)`, abre o jogo para você jogar pelo teclado (a barra de espaço ou a seta para cima faz o pássaro bater as asas), usando as funções que você vai escrever. Com elas incompletas, nada se mexe. A cada exercício, uma parte passa a funcionar:

| Depois do... | O que muda no jogo |
|---|---|
| Exercício 1 | O pássaro cai e bate as asas quando você aperta a tecla; o jogo acaba se ele sai da tela |
| Exercício 2 | Os muros andam para a esquerda e somem depois de sair da tela |
| Exercício 3 | O jogo acaba quando o pássaro bate em um muro |

> 💡 Os resultados dos testes só aparecem depois que você fecha a janela do jogo. Para rodar só os testes, comente a linha `jogar(10)`.

---

## 🔍 Exercício 0: Entendendo o Jogo

O cenário tem `LARG` × `ALT` pixels (600 × 400). Lembre que, em imagens, **y cresce para baixo**: um pássaro "abaixo" do vão tem y **maior** que o centro do vão.

A parte pronta do template define os dados do jogo:

```
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
```

A cada **tick** do jogo acontece, **nesta ordem**:

1. **O piloto decide.** O pássaro bate as asas se estiver abaixo do centro do vão do **primeiro muro** da lista (`y > vao`).
2. **O pássaro voa.** Se bateu as asas, a velocidade vertical passa a ser `PULO` (um valor negativo, para cima). Senão, a velocidade aumenta `GRAVIDADE`. Depois, `y` muda de acordo com a **nova** velocidade.
3. **Os muros andam.** Cada muro anda `VEL-MUROS` pixels para a esquerda.
4. **Os muros que saíram da tela são removidos.**

O jogo **acaba** quando o pássaro passou por todos os muros (não há mais muros), saiu da tela ou bateu em um muro.

As constantes `GRAVIDADE = 1`, `PULO = -6` e `VEL-MUROS = 4` estão no início do template. As medidas do cenário e os exemplos para os testes estão na parte pronta:

| Nome | O que é |
|---|---|
| `LARG`, `ALT`, `CENARIO` | Tamanho do cenário (600 × 400) e a imagem de fundo |
| `X-PASSARO`, `RAIO-PASSARO` | Coluna em que o pássaro voa (120) e metade do tamanho dele (15) |
| `LARG-MURO`, `ALT-VAO` | Largura de um muro (60) e altura do vão (90) |
| `PASSARO-TESTE` | `passaro(200, 0)`: no meio da altura do cenário, parado |
| `MURO-LONGE` | `muro(400, 200)`: longe do pássaro |
| `MURO-NO-MEIO` | `muro(130, 200)`: na frente do pássaro, com o vão no meio. O `PASSARO-TESTE` passa por ele |
| `MURO-ALTO` | `muro(130, 100)`: na frente do pássaro, com o vão no alto. O `PASSARO-TESTE` bate nele |
| `MUNDO-TESTE` | `mundo(PASSARO-TESTE, [list: MURO-LONGE])` |

> 💡 **Não é necessário escrever código neste exercício.**

---

## 🐦 Exercício 1: O Pássaro

1. `voa(p :: Passaro, bate-asas :: Boolean) -> Passaro`
Objetivo: devolver o pássaro um tick depois. Se `bate-asas` é `true`, a nova velocidade vertical é `PULO`; senão, é a velocidade atual mais `GRAVIDADE`. A nova altura é a altura atual mais a **nova** velocidade.
Por exemplo, `voa(PASSARO-TESTE, false)` é `passaro(201, 1)` e `voa(PASSARO-TESTE, true)` é `passaro(194, -6)`.

2. `piloto(p :: Passaro, muros :: List<Muro>) -> Boolean`
Objetivo: decidir se o pássaro bate as asas. Devolve `true` se o pássaro está abaixo do centro do vão do primeiro muro da lista (`p.y > vao`), e `false` caso contrário. Se a lista de muros é vazia, devolve `false`.

3. `fora-da-tela(p :: Passaro) -> Boolean`
Objetivo: verificar se o pássaro passou da borda de cima (`y - RAIO-PASSARO < 0`) ou da borda de baixo (`y + RAIO-PASSARO > ALT`) do cenário.

---

## 🧱 Exercício 2: Os Muros

1. `move-muro(m :: Muro) -> Muro`
Objetivo: devolver o muro `VEL-MUROS` pixels para a esquerda.

2. `saiu-da-tela(m :: Muro) -> Boolean`
Objetivo: verificar se o muro já saiu inteiro pela borda esquerda do cenário, ou seja, se `x + LARG-MURO / 2 < 0`.

3. `move-muros(l :: List<Muro>) -> List<Muro>`
Objetivo: devolver a lista com cada muro movido para a esquerda, **sem** os muros que saíram da tela.
Por exemplo, `move-muros([list: muro(-29, 250), MURO-LONGE])` é `[list: muro(396, 200)]`: o primeiro muro vai para `x = -33` e sai da tela.

> 🛠️ **Dica:** Use as funções `map` e `filter`.

---

## 💥 Exercício 3: Colisão

1. `bateu-no-muro(p :: Passaro, m :: Muro) -> Boolean`
Objetivo: verificar se o pássaro encosta no muro. Isso acontece quando as duas condições abaixo valem:
    - o pássaro está **na frente** do muro: `|x - X-PASSARO| < LARG-MURO / 2 + RAIO-PASSARO`;
    - o pássaro **não está inteiro dentro do vão**: `y - RAIO-PASSARO < vao - ALT-VAO / 2` ou `y + RAIO-PASSARO > vao + ALT-VAO / 2`.

    Por exemplo, o `PASSARO-TESTE` bate no `MURO-ALTO`, mas não bate no `MURO-NO-MEIO` nem no `MURO-LONGE`.

2. `bateu-em-algum(p :: Passaro, l :: List<Muro>) -> Boolean`
Objetivo: verificar se o pássaro encosta em algum muro da lista.

> 🛠️ **Dicas:**
> - `num-abs(n)` devolve o valor absoluto de `n`. Por exemplo, `num-abs(-10)` é `10`.
> - Em Pyret, operadores diferentes precisam de parênteses: escreva `(LARG-MURO / 2) + RAIO-PASSARO`, e não `LARG-MURO / 2 + RAIO-PASSARO`.

---

## 🎮 Exercício 4: A Função Principal do Jogo

No Exercício 4, o pássaro não é controlado pelo teclado: quem decide é o `piloto`. A função principal, `gera-video`, já está pronta no template. Ela gera, com **recursão generativa**, a lista de cenas do jogo a partir de um mundo, até o jogo acabar:

```
fun gera-video(jogo :: Mundo) -> List<Image>:
  ask:
    | acabou-jogo(jogo) then: [list: desenha-mundo(jogo)]
    | otherwise: link(desenha-mundo(jogo), gera-video(atualiza-mundo(jogo)))
  end
end
```

1. **Leia `gera-video`** e preencha, no comentário do Exercício 4 do template, o modelo de recursão generativa da Aula 25: qual é o **problema trivial** e a sua solução, como se **gera** o problema "menor" e qual é a solução dele, e como se **combinam** as soluções. Compare com `move-ate-que-fora` da Aula 25.

2. Implemente as duas funções auxiliares que `gera-video` usa, com as funções dos Exercícios 1 a 3:

    `acabou-jogo(jogo :: Mundo) -> Boolean`
    Objetivo: devolver `true` se o jogo acabou: o pássaro passou por todos os muros (não há mais muros), saiu da tela ou bateu em um muro.

    `atualiza-mundo(jogo :: Mundo) -> Mundo`
    Objetivo: devolver o mundo um tick depois, seguindo a ordem do Exercício 0: o piloto decide se o pássaro bate as asas e o pássaro voa; depois os muros andam e os que saíram da tela são removidos.

    > ⚠️ No template, as duas funções devolvem respostas provisórias que fazem `gera-video` terminar logo. Se `gera-video` nunca terminar depois que você as implementar, confira se `acabou-jogo` reconhece o fim do jogo e se `atualiza-mundo` realmente move os muros.

Quando os testes de `gera-video` passarem, assista ao filme descomentando as duas linhas no final do Exercício 4:

```
CENAS = gera-video(mundo-inicial(5))
run-movie(30, CENAS)
```

> ⏳ Gerar as cenas leva alguns segundos, e o filme só começa depois que `gera-video` termina. Se estiver demorando demais, talvez o jogo nunca acabe... Para interromper, use o botão **Stop**.

**Para pensar:** por que não dá para usar `gera-video` para gerar o filme de uma partida jogada pelo teclado?

---

## ♾️ Exercício 5: Terminação

Responda em comentários, no lugar indicado no template.

1. Escreva um argumento de terminação para `gera-video`. Lembre dos três pontos da Aula 25: a função tem um caso trivial; cada chamada recursiva se aproxima do caso trivial; e as funções auxiliares também terminam. Quais premissas o seu argumento usa?

    > 💡 **Dica:** O jogo pode acabar de duas formas: o pássaro bate, ou os muros acabam. Qual das duas você consegue garantir que acontece? Pense na posição `x` do último muro.

2. Mude `VEL-MUROS` para 0 e rode o jogo. Ele termina? O jogo poderia terminar mesmo com `VEL-MUROS = 0`? Em que situação?

3. **Modo infinito:** imagine que, sempre que um muro sai da tela, um muro novo entra pela direita. O argumento do item 1 ainda vale? Que mudança nas regras garantiria que o jogo sempre termina?

---

## ⏱️ Exercício 6: Custo

Responda em comentários, no lugar indicado no template. Considere que o jogo tem N muros.

1. Qual é o custo de uma chamada de `gera-video`, sem contar a chamada recursiva, em notação O, em função de N? Justifique a partir das funções auxiliares: quantas vezes cada uma percorre a lista de muros?
2. Rode o jogo com 3, 6 e 12 muros e anote o número de cenas (`length(CENAS)`). Como o número de chamadas recursivas cresce com N?
3. Qual é, aproximadamente, o custo total de `gera-video`?

---

## 🚀 Desafios Bônus

1. **Modo infinito:** implemente o modo infinito do Exercício 5, junto com a mudança nas regras que você propôs para garantir que o jogo termina.
2. **Pontos:** mostre no placar quantos muros o pássaro já ultrapassou.
3. **Colisão mais rápida:** para saber se o pássaro bateu, é preciso testar todos os muros? Quais muros podem estar na frente do pássaro? Escreva uma versão de `bateu-em-algum` que teste só esses muros, e diga qual é o custo dela.
