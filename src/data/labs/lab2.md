# Laboratório 2

## 🎯 Contexto e Objetivos

Neste laboratório, vamos praticar os conceitos de **recursão e listas** vistos em aula, aplicando-os ao universo de [Pokémon](https://pt.wikipedia.org/wiki/Pok%C3%A9mon)!

<br>

Para não precisar reescrever tudo do zero, este laboratório usa uma **biblioteca** (`pokemon-lib2.arr`) que já fornece as funções e constantes desenvolvidas no Lab 1 (como `cria-carta`, as constantes de tipo, etc.). 
Você pode consultá-la para entender o que está disponível — ela é importada no template assim:

```
import url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib2.arr") as P
```

Leia o arquivo `pokemon-lib2.arr` para entender as funções e constantes já disponíveis (ver ao final desta página).
Você pode acessar as funções e constantes da biblioteca usando o operador `P.`. Exemplo: `P.cria-carta`, `P.POKE-DATA`.

Sua missão neste laboratório é **explorar a tabela de Pokémons da primeira geração** usando funções recursivas sobre listas, e ao final **desenhar todas as cartas lado a lado** usando uma lista de imagens definida por você!

> 💡 **INSTRUÇÕES PARA O LABORATÓRIO:**
> - Siga as dicas de estilo de código do Pyret: https://lucasalegre.github.io/pensamento-computacional/topics/style-guide
> - Use os nomes de funções definidos nas questões.
> - DEVE ser colocada a documentação completa, ou seja, contrato, objetivo, e pelo menos 2 exemplos/testes (só não precisa incluir testes nas funções que geram imagens).
> - Em todos os condicionais (`ask`, `cases`, `if`) coloque um comentário explicando cada caso.

## Template

Copie o template para o seu ambiente de desenvolvimento (code.pyret.org ou VS Code). Não esqueça de salvar o seu arquivo!

```pyret
file: src/data/labs/lab2-template.arr
```

---

## 📋 Exercício 1: Pokémons da Primeira Geração

A biblioteca importada já fornece uma tabela com todos os Pokémons em `P.POKE-DATA`. No entanto, queremos trabalhar apenas com os **151 Pokémons da primeira geração** (aqueles com `id <= 151`).

1. Implemente a função `id-primeira-geracao` que recebe uma linha (`Row`) da tabela e devolve `true` se o `id` da linha for menor ou igual a `151`, e `false` caso contrário.

2. Use `filter-with` e a função `id-primeira-geracao` para criar a constante do tipo Table `POKE-GEN1`, que deve conter apenas os Pokémons da primeira geração.

3. A partir de `POKE-GEN1`, extrai as seguintes colunas como constantes do tipo `List<String>`:
   - `NOMES-POKEMONS` — coluna `"name"`
   - `TIPOS-POKEMONS` — coluna `"type1"`

> 🛠️ **Dica:** Use o método `.get-column("nome-da-coluna")` para extrair uma coluna da tabela como lista.

---

## 🔢 Exercício 2: Contando o Número de Pokémons

Implemente a função recursiva `tamanho` que recebe uma lista de qualquer tipo (`List<Any>`) e devolve o número de elementos dela, i.e., seu tamanho.

- **Caso base:** uma lista vazia tem tamanho `0`.
- **Caso recursivo:** o tamanho de uma lista não vazia é `1` mais o tamanho do restante (`rest`).

> 📝 Preencha a cláusula `where:` com pelo menos 2 testes.

---

## 🔍 Exercício 3: Contando e Filtrando Tipos

### Parte A — `conta-tipos`

Implemente a função recursiva `conta-tipos` que recebe uma lista de tipos (`List<String>`) e um tipo (`String`), e devolve quantas vezes esse tipo aparece na lista.

- **Caso base:** uma lista vazia contém o tipo `0` vezes.
- **Caso recursivo:** se o primeiro elemento (`first`) for igual ao tipo buscado, some `1` e continue; caso contrário, apenas continue.

```
conta-tipos([list: "FIRE", "WATER", "FIRE"], "FIRE")  # deve ser 2
conta-tipos(empty, "FIRE")                            # deve ser 0
```

### Parte B — `remove-tipos-repetidos`

Implemente a função recursiva `remove-tipos-repetidos` que recebe uma lista de tipos e devolve uma nova lista **sem elementos repetidos**, mantendo a última ocorrência de cada tipo.

- **Caso base:** lista vazia devolve lista vazia.
- **Caso recursivo:** use `conta-tipos` para verificar se o primeiro elemento já aparece no restante. Se aparecer, descarte-o e processe apenas o `rest`; caso contrário, mantenha-o na frente do resultado recursivo.

```
remove-tipos-repetidos([list: "FIRE", "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"])
# deve ser [list: "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]
remove-tipos-repetidos(empty) # deve ser empty
```

---

## 🖼️ Exercício 4: Lista de Imagens e Mesa de Cartas

Neste exercício vamos definir nossa própria lista de imagens.

### Parte A — Definição do tipo `ListaDeImagens`

Complete a definição do tipo `ListaDeImagens` presente no template.

### Parte B — `cria-lista-de-cartas`

Implemente a função `cria-lista-de-cartas` que recebe duas listas paralelas — `nomes :: List<String>` e `tipos :: List<String>` — e devolve uma `ListaDeImagens` com a carta de cada Pokémon.

- **Dica:** Reutilize a função presente na biblioteca, `P.cria-carta :: String, String -> Image`, para criar as cartas.

### Parte C — `desenha-lista-de-cartas`

Implemente a função `desenha-lista-de-cartas` que recebe uma `ListaDeImagens` e devolve uma única `Image` com todas as cartas posicionadas **lado a lado**.

- **Caso base:** uma lista vazia deve devolver `empty-image`.
- **Caso recursivo:** coloque a primeira carta ao lado (`beside`) da imagem resultante da recursão sobre o restante da lista.

Por fim, crie a constante `CARTAS` chamando `cria-lista-de-cartas(NOMES-POKEMONS, TIPOS-POKEMONS)` e exiba o resultado com `desenha-lista-de-cartas(CARTAS)`.

> 🛠️ **Dicas:**
> - `beside(img1 :: Image, img2 :: Image) -> Image`: coloca `img1` imediatamente à esquerda de `img2`.
> - `empty-image`: uma imagem de largura e altura zero, útil como caso base para `beside`.


## pokemon-lib2.arr

Biblioteca de Pokémon para o Laboratório 2.

```pyret
file: src/data/labs/pokemon-lib2.arr
```