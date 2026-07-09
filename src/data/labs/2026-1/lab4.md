# Laboratório 4

## 🎯 Contexto e Objetivos

Neste laboratório, vamos focar no uso de **funções de alta ordem** (como `filter`, `map` e `fold`) vistas em aula, aplicando-as a times de [Pokémon](https://pt.wikipedia.org/wiki/Pok%C3%A9mon).

<br>

Para não precisar reescrever tudo do zero, este laboratório usa uma **biblioteca** (`pokemon-lib4.arr`) que já fornece as funções e constantes desenvolvidas nos laboratórios anteriores (como definição de estruturas, tabela de dados e funções auxiliares). 
Ela é importada no template com o seguinte comando:

```
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib4.arr")
```

Leia o arquivo `pokemon-lib4.arr` (ao final desta página) para entender as funções, tipos de dados e constantes já disponíveis que você poderá reutilizar.

Seu objetivo neste laboratório é criar funções genéricas para manipulação de times de Pokémon, usando **funções de alta-ordem** e **expressões lambda**.

> 💡 **INSTRUÇÕES PARA O LABORATÓRIO:**
> - Siga as dicas de estilo de código do Pyret: https://lucasalegre.github.io/pensamento-computacional/topics/style-guide
> - Use os nomes de funções definidos nas questões.
> - DEVE ser colocada a documentação completa, ou seja, contrato, objetivo, e pelo menos 2 exemplos/testes (cláusula `where:`). Só não precisa incluir testes nas funções que geram imagens.
> - Em todos os condicionais (`ask`, `cases`, `if`) coloque um comentário explicando cada caso.

## Template

Copie o template para o seu ambiente de desenvolvimento (code.pyret.org ou VS Code). Não esqueça de salvar o seu arquivo!

```pyret
file: src/data/labs/lab4-template.arr
```

---

## 📋 Exercício 1: Constantes

1. Use a função `extrai-pokemon-tabela` (fornecida na biblioteca), passando como argumentos o número ID de um pokemon e a tabela de pokemons (`POKE-DATA`) para criar 2 constantes de pokemons.
2. Use a função `cria-time`, passando como argumentos a tabela de pokemons e uma lista com os números dos pokemons que você deseja adicionar ao time, e crie uma constante de time com 6 pokemons diferentes.
3. Use a função `desenha-time` para visualizar seu time recém-criado.

---

## 🔍 Exercício 2: Filter

1. Escreva uma função `testa-tipo` que, dado um Pokemon e um TipoPokemon, devolve `true` se o Pokemon for do TipoPokemon informado, e `false` caso contrário.
2. Escreva uma função `my-filter(f :: (Pokemon -> Boolean), t :: Time) -> Time` que, dado um Time e uma função de critério (que recebe um pokemon e devolve um booleano), devolve um novo Time com apenas os pokemons deste time para os quais esta função devolve `true`.
3. Escreva a função `filtra-tipos(t :: Time, tipo :: TipoPokemon) -> Time` que, dado um Time e um TipoPokemon, devolve um novo Time com apenas os pokemons deste time do tipo informado.

> 🛠️ **Dica:**
>- Reutilize as funções `my-filter` e `testa-tipo` no item 3.
>- A função `testa-tipo` recebe dois argumentos, porém a função de argumento `f` de `my-filter` recebe apenas um argumento. Pense em como fazer para que `testa-tipo` possa ser usada em `my-filter` utilizando uma expressão lambda.

---

## 🔄 Exercício 3: Map

1. Escreva a função `my-map(f :: (Pokemon -> Any), t :: Time) -> List<Any>` que, dado um time e uma função que recebe um pokemon e devolve um valor qualquer (`Any`), devolve uma lista com os resultados da aplicação da função a cada pokemon do time.

2. Na biblioteca, existe a função `aplica-movimento-time`, escrita utilizando recursão estrutural. Escreva uma nova versão desta função, chamada `aplica-movimento-time2(t :: Time, m :: Movimento) -> Time`, que aplica um movimento a todos os pokemons do time, mas agora reutilizando a função `my-map` do item anterior.

---

## 📦 Exercício 4: Fold

1. Escreva a função `my-fold<T>(f :: (T, T -> T), acc :: T, l :: List<T>) -> T` que, dado uma função (que recebe dois valores de um determinado tipo e devolve um valor do mesmo tipo), um valor inicial para o acumulador, e uma lista, devolve o resultado de aplicar esta função sequencialmente a todos os elementos da lista, dois a dois (acumulador e primeiro elemento, resultado e segundo elemento, ...).
2. Escreva a função `desenha-pokemons-tipo(t :: Time, tipo :: TipoPokemon) -> Image` que, dado um time e um tipo de pokemon, gera uma imagem com as cartas dos pokemons deste tipo no time, dispostas lado a lado.

> 🛠️ **Dica:**
>- Combine as funções `my-fold`, `beside`, `my-map`, `desenha-pokemon` e `filtra-tipos`.
>- Lembre-se que o valor inicial do acumulador de uma imagem será `empty-image`.

---

## pokemon-lib4.arr

Biblioteca de Pokémon importada para o Laboratório 4.

```pyret
file: src/data/labs/pokemon-lib4.arr
```
