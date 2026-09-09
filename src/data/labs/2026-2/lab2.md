# Laboratório 2: Heróis e Vilões

## 🎯 Contexto e Objetivos

Neste laboratório, vamos praticar os conceitos de **recursão e listas** vistos em aula, aplicando-os a um universo de super-heróis e vilões dos quadrinhos! 🦸‍♀️🦹

<br>

Vamos trabalhar com uma **tabela real, baixada da internet**, contendo centenas de heróis e vilões da Marvel, DC e outros universos (dados adaptados do projeto open-source [superhero-api](https://akabab.github.io/superhero-api/)), com colunas como nome, editora (`publisher`) e alinhamento (`alignment`: `"good"`, `"bad"` ou `"neutral"`).

Para não precisar reescrever tudo do zero, este laboratório usa uma **biblioteca** (`herois-lib2.arr`) que já carrega essa tabela, filtra os heróis da Marvel e fornece funções prontas (como `coluna-heroi` e `cria-carta`). Ela é importada no template com o seguinte comando:

```
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/herois-lib2.arr")
```

Leia o arquivo `herois-lib2.arr` (ao final desta página) para entender as funções e constantes já disponíveis que você poderá reutilizar. Repare que a tabela `HEROI-DATA` é carregada diretamente de um arquivo CSV hospedado na internet, usando uma função chamada `load-table`.

Seu objetivo neste laboratório é **explorar a tabela de heróis e vilões** usando funções recursivas sobre listas, e ao final **desenhar todas as cartas lado a lado** usando uma lista de imagens definida por você.

> 💡 **INSTRUÇÕES PARA O LABORATÓRIO:**
> - Siga as dicas de estilo de código do Pyret: https://lucasalegre.github.io/pensamento-computacional/topics/style-guide
> - Use os nomes de funções definidos nas questões.
> - DEVE ser colocada a documentação completa, ou seja, contrato, objetivo, e pelo menos 2 exemplos/testes (só não precisa incluir testes nas funções que geram imagens).
> - Em todos os condicionais (`ask`, `cases`, `if`) coloque um comentário explicando cada caso.

## Template

Copie o template para o seu ambiente de desenvolvimento (code.pyret.org ou VS Code). Não esqueça de salvar o seu arquivo!

```pyret
file: src/data/labs/2026-2/lab2-template.arr
```

---

## 📋 Exercício 1: Heróis da Marvel

A biblioteca importada já cuida de baixar os dados e filtrá-los para conter apenas os heróis publicados pela **Marvel Comics**, e fornece a função `coluna-heroi :: String -> List<String>`, que recebe o nome de uma coluna (por exemplo, `"name"`, `"alignment"` ou `"race"`) e devolve todos os valores desta coluna como uma lista de strings.

Usando a função `coluna-heroi`, crie as seguintes constantes:
   - `NOMES-HEROIS` — lista com os nomes de todos os heróis da Marvel (coluna `"name"`)
   - `ALINHAMENTOS-HEROIS` — lista com os alinhamentos de todos os heróis da Marvel (coluna `"alignment"`)
   - `RACAS-HEROIS` — lista com as raças de todos os heróis da Marvel (coluna `"race"`)

---

## 🔢 Exercício 2: Contando o Número de Heróis

Implemente a função recursiva `tamanho` que recebe uma lista de strings e devolve o número de elementos dela, i.e., seu tamanho.

- **Caso base:** uma lista vazia tem tamanho `0`.
- **Caso recursivo:** o tamanho de uma lista não vazia é `1` mais o tamanho do restante (`rest`).

> 📝 Preencha a cláusula `where:` com pelo menos 2 testes.

---

## 🔍 Exercício 3: Contando e Filtrando Raças

### Parte A — `conta-racas`

Implemente a função recursiva `conta-racas` que recebe uma lista de raças (`List<String>`) e uma raça (`String`), e devolve quantas vezes essa raça aparece na lista.

```
conta-racas([list: "Human", "Mutant", "Alien", "Mutant", "Human"], "Human") is 2
conta-racas(empty, "Human") is 0
```

### Parte B — `remove-racas-repetidas`

Implemente a função recursiva `remove-racas-repetidas` que recebe uma lista de raças e devolve uma nova lista **sem elementos repetidos**, mantendo a última ocorrência de cada raça.

```
remove-racas-repetidas([list: "Human", "Mutant", "Alien", "Mutant", "Human"]) is [list: "Alien", "Mutant", "Human"]
remove-racas-repetidas(empty) is empty
```

---

## 🖼️ Exercício 4: Lista de Imagens

Neste exercício vamos definir nossa própria lista de imagens.

### Parte A — Definição do tipo `ListaDeImagens`

Complete a definição do tipo `ListaDeImagens` presente no template.

### Parte B — `cria-lista-de-cartas`

Implemente a função `cria-lista-de-cartas` que, dada uma lista contendo os nomes dos heróis, gera uma lista com as imagens das cartas correspondentes.

- **Dica:** Reutilize a função presente na biblioteca, `cria-carta :: String -> Image`, para criar as cartas. Dado o nome de um herói, ela devolve a imagem da carta correspondente.

### Parte C — `desenha-lista-de-cartas`

Implemente a função `desenha-lista-de-cartas` que recebe uma `ListaDeImagens` e devolve uma única `Image` com todas as cartas posicionadas **lado a lado**.

- **Caso base:** Se a lista estiver vazia, devolver a imagem vazia (`empty-image`).
- **Passo:** Se a lista não estiver vazia, colocar a primeira imagem da lista ao lado da imagem gerada com as cartas (imagens) do resto da lista, lado a lado.

Por fim, crie a constante `CARTAS` usando a aplicação de função `cria-lista-de-cartas(NOMES-HEROIS)` e exiba o resultado com a chamada `desenha-lista-de-cartas(CARTAS)`.

> 🛠️ **Dicas:**
> - `beside(img1 :: Image, img2 :: Image) -> Image`: coloca `img1` imediatamente à esquerda de `img2`.
> - `empty-image`: uma imagem de largura e altura zero, útil como caso base para `beside`.


## herois-lib2.arr

Biblioteca de Heróis para o Laboratório 2.

```pyret
file: src/data/labs/herois-lib2.arr
```
