# Laboratório 2

## 🎯 Contexto e Objetivos

Neste laboratório, vamos praticar os conceitos de **recursão e listas** vistos em aula, aplicando-os ao universo de [Pokémon](https://pt.wikipedia.org/wiki/Pok%C3%A9mon)!

<br>

Para não precisar reescrever tudo do zero, este laboratório usa uma **biblioteca** (`pokemon-lib2.arr`) que já fornece as funções e constantes desenvolvidas no Lab 1 (como `cria-carta`, as constantes de tipo, etc.). 
Você pode consultá-la para entender o que está disponível. Ela é importada no template com o seguinte comando:

```
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib2.arr")
```

Leia o arquivo `pokemon-lib2.arr` (ao final desta página) para entender as funções e constantes já disponíveis que você poderá reutilizar.


Seu objetivo neste laboratório é **explorar a tabela de Pokémons da primeira geração** usando funções recursivas sobre listas, e ao final **desenhar todas as cartas lado a lado** usando uma lista de imagens definida por você.

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

A biblioteca importada já fornece uma tabela com todos os Pokémons em `POKE-DATA`. No entanto, queremos trabalhar apenas com os **151 Pokémons da primeira geração** (aqueles com `id <= 151`).

1. Implemente a função `id-primeira-geracao` que recebe uma linha (`Row`) da tabela e devolve `true` se o `id` da linha for menor ou igual a `151`, e `false` caso contrário.

2. Use a função `filter-with` e a função `id-primeira-geracao` para criar a constante `POKE-GEN1` do tipo Table, que deve conter apenas os Pokémons da primeira geração.

3. Usando a tabela `POKE-GEN1`, crie as seguintes constantes:
   - `NOMES-POKEMONS` — cujo valor deve ser uma lista com todos os nomes de pokemons a tabela (coluna `"name"`)
   - `TIPOS-POKEMONS` — cujo valor deve ser uma lista com todos os tipos de pokemons a tabela (coluna `"type1"`)

> 🛠️ **Dica:** Use o método `.get-column("nome-da-coluna")` para extrair uma coluna da tabela como lista.

---

## 🔢 Exercício 2: Contando o Número de Pokémons

Implemente a função recursiva `tamanho` que recebe uma lista de strings e devolve o número de elementos dela, i.e., seu tamanho.

- **Caso base:** uma lista vazia tem tamanho `0`.
- **Caso recursivo:** o tamanho de uma lista não vazia é `1` mais o tamanho do restante (`rest`).

> 📝 Preencha a cláusula `where:` com pelo menos 2 testes.

---

## 🔍 Exercício 3: Contando e Filtrando Tipos

### Parte A — `conta-tipos`

Implemente a função recursiva `conta-tipos` que recebe uma lista de tipos (`List<String>`) e um tipo (`String`), e devolve quantas vezes esse tipo aparece na lista.

```
conta-tipos([list: "FIRE", "WATER", "FIRE"], "FIRE") is 2
conta-tipos(empty, "FIRE") is 0
```

### Parte B — `remove-tipos-repetidos`

Implemente a função recursiva `remove-tipos-repetidos` que recebe uma lista de tipos e devolve uma nova lista **sem elementos repetidos**, mantendo a última ocorrência de cada tipo.

```
remove-tipos-repetidos([list: "FIRE", "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]) is [list: "WATER", "ELECTRIC", "GRASS", "NORMAL", "FIRE"]
remove-tipos-repetidos(empty) is empty
```

---

## 🖼️ Exercício 4: Lista de Imagens e Mesa de Cartas

Neste exercício vamos definir nossa própria lista de imagens.

### Parte A — Definição do tipo `ListaDeImagens`

Complete a definição do tipo `ListaDeImagens` presente no template.

### Parte B — `cria-lista-de-cartas`

Implemente a função `cria-lista-de-cartas` que, dadas duas listas contendo os nomes dos pokemons e os respectivos tipos dos pokemons, gera uma lista com as imagens das cartas correspondentes. Assuma que as duas listas têm o mesmo tamanho.

- **Dica:** Reutilize a função presente na biblioteca, `cria-carta :: String, String -> Image`, para criar as cartas.

### Parte C — `desenha-lista-de-cartas`

Implemente a função `desenha-lista-de-cartas` que recebe uma `ListaDeImagens` e devolve uma única `Image` com todas as cartas posicionadas **lado a lado**.

- **Caso base:** Se a lista estiver vazia, devolver a imagem vazia (`empty-image`).
- **Passo:**  Se a lista não estiver vazia, colocar a primeira imagem da lista ao lado da imagem gerada com as cartas (imagens) do resto da lista, lado a lado.

Por fim, crie a constante `CARTAS` usando a aplicação de função `cria-lista-de-cartas(NOMES-POKEMONS, TIPOS-POKEMONS)` e exiba o resultado com a chamada `desenha-lista-de-cartas(CARTAS)`.

> 🛠️ **Dicas:**
> - `beside(img1 :: Image, img2 :: Image) -> Image`: coloca `img1` imediatamente à esquerda de `img2`.
> - `empty-image`: uma imagem de largura e altura zero, útil como caso base para `beside`.


## pokemon-lib2.arr

Biblioteca de Pokémon para o Laboratório 2.

```pyret
file: src/data/labs/pokemon-lib2.arr
```
