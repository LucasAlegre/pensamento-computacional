# Laboratório 5

## 🎯 Contexto e Objetivos

Neste laboratório, vamos trabalhar com **estruturas com recursão mútua**. A ideia é modelar um sistema de arquivos, onde uma **entrada** pode ser um arquivo (com um Pokémon dentro) ou um **diretório** (que contém outras entradas — podendo inclusive ter subdiretórios).

<br>

Esse modelo é chamado de **árvore** em computação, e é amplamente usado no dia a dia: o seu computador organiza todos os seus arquivos exatamente assim! 
Vamos usar o universo de [Pokémon](https://pt.wikipedia.org/wiki/Pok%C3%A9mon) para tornar isso mais concreto — cada arquivo da nossa Pokédex contém um Pokémon.

<br>

Este laboratório usa a mesma **biblioteca** do Lab 4 (`pokemon-lib4.arr`), importada com:

```
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib4.arr")
```

Leia o arquivo `pokemon-lib4.arr` (ao final desta página) para entender as funções, tipos de dados e constantes já disponíveis.

> 💡 **INSTRUÇÕES PARA O LABORATÓRIO:**
> - Siga as dicas de estilo de código do Pyret: https://lucasalegre.github.io/pensamento-computacional/topics/style-guide
> - Use os nomes de funções e dados (`data`) definidos nas questões.
> - DEVE ser colocada a documentação completa, ou seja, contrato, objetivo, e pelo menos 2 exemplos/testes (cláusula `where:`). Só não precisa incluir testes nas funções que geram imagens.
> - Em todos os condicionais (`ask`, `cases`, `if`) coloque um comentário explicando cada caso.

## Template

Copie o template para o seu ambiente de desenvolvimento (code.pyret.org ou VS Code). Não esqueça de salvar o seu arquivo!

```pyret
file: src/data/labs/lab5-template.arr
```

---

## 📁 Exercício 0: Definição de Dados

Neste laboratório vamos modelar um sistema de arquivos. Uma **entrada** num diretório pode ser:

- Um **arquivo** contendo um Pokémon (com nome e o próprio Pokémon).
- Um **diretório** contendo um nome e uma lista de outras entradas (o seu **conteúdo**).

O conteúdo de um diretório é uma lista de entradas — e como uma entrada pode ser um diretório, a estrutura é **recursiva**.

As definições de dados e constantes já estão prontas no template. Leia e entenda cada parte:

- O tipo de dado `Entrada` tem duas variantes:
  - `arquivo`, com campos `nome :: String` e `pokemon :: Pokemon`.
  - `diretorio`, com campos `nome :: String` e `conteudo :: Conteudo`.

- `Conteudo` é um apelido (type alias) para `List<Entrada>`.

- As constantes `P-BULBASAUR`, `P-CHARMANDER`, etc. representam os Pokémon iniciais das três primeiras gerações, obtidos com `extrai-pokemon-tabela`.

- `MINHA-POKEDEX` é um diretório com três subdiretórios (`"Kanto"`, `"Johto"`, `"Hoenn"`), cada um contendo os respectivos arquivos `.pkm`.

> 💡 **Não é necessário escrever código neste exercício.** Certifique-se de entender a estrutura antes de prosseguir para os próximos exercícios.

---

## 🔍 Exercício 1: Busca de Arquivos e Diretórios

Vamos implementar funções para verificar se um arquivo ou diretório existe na Pokédex.

1. Implemente a função `encontra-no-nivel(conteudo :: Conteudo, nome :: String) -> Boolean` que, dados o conteúdo de um diretório e um nome, verifica se existe uma entrada com esse nome **no nível imediato** — **sem entrar em subdiretórios**.

2. Implemente a função `encontra-na-entrada(entrada :: Entrada, nome :: String) -> Boolean` que, dada uma entrada e um nome:
   - Se a entrada for um **arquivo**, verifica se é o arquivo procurado.
   - Se for um **diretório**, verifica se é o diretório procurado **ou** se o nome existe em algum lugar dentro dele (em qualquer profundidade).

3. Implemente a função `encontra-no-conteudo(conteudo :: Conteudo, nome :: String) -> Boolean` que, dado um conteúdo e um nome, verifica se existe uma entrada com esse nome em qualquer nível — percorrendo subdiretórios recursivamente.

> 🛠️ **Dica:** As duas funções são mutuamente recursivas: `encontra-na-entrada` chama `encontra-no-conteudo`, que chama `encontra-na-entrada`. Implemente-as nessa ordem e reutilize-as entre si.

---

## 🔢 Exercício 2: Contagem de Arquivos

Vamos contar quantos **arquivos** existem numa entrada, considerando todos os subdiretórios.

1. Implemente a função `conta-arquivos-na-entrada(entrada :: Entrada) -> Number` que:
   - Se a entrada for um **arquivo**, conta `1`.
   - Se for um **diretório**, conta o total de arquivos dentro dele (recursivamente).

2. Implemente a função `conta-arquivos-no-conteudo(conteudo :: Conteudo) -> Number` que soma o número de arquivos em cada entrada do conteúdo.

---

## 🌳 Exercício 3: Visualização da Pokédex

Vamos gerar uma **imagem** da Pokédex no estilo do comando `tree` do terminal, onde cada nível de diretório é indentado.

```
├── Pokedex/
    ├── Kanto/
        ├── Bulbasaur.pkm
            [carta]
        ├── Charmander.pkm
            [carta]
    ├── Johto/
        ...
```

1. Implemente a função `mostra-entrada(entrada :: Entrada) -> Image` que:
   - Para um **arquivo**: gera uma imagem com `"├── nome"` em verde acima da carta do Pokémon (indentada).
   - Para um **diretório**: gera uma imagem com `"├── nome/"` em azul acima do conteúdo (indentado).

2. Implemente a função `mostra-conteudo(c :: Conteudo) -> Image` que empilha verticalmente (`above-align`) as imagens de cada entrada do conteúdo.

Ao final, chame `mostra-entrada(MINHA-POKEDEX)` para visualizar a Pokédex de exemplo:

![Pokédex visualizada em árvore](images/lab5/pokedex.png)

> 🛠️ **Dica:** Para indentar o conteúdo de um diretório, use `beside` com um espaçador branco à esquerda:
> ```pyret
> beside(rectangle(20, 1, "solid", "white"), mostra-conteudo(c))
> ```

---

## ➕ Exercício 4: Inclusão de Arquivos e Diretórios

Vamos implementar funções para **inserir** novas entradas na Pokédex, sem duplicar entradas com o mesmo nome.

1. Implemente a função `insere-na-entrada(nova-entrada :: Entrada, entrada :: Entrada) -> Entrada` que:
   - Se a entrada for um **arquivo**, retorna a entrada sem alterações (não é possível inserir dentro de um arquivo).
   - Se for um **diretório**, insere `nova-entrada` no seu conteúdo — **apenas se não existir** outra entrada com o mesmo nome naquele nível.

2. Implemente a função `insere-no-conteudo(nova-entrada :: Entrada, conteudo :: Conteudo) -> Conteudo` que:
   - Se o conteúdo for vazio, retorna uma lista com apenas `nova-entrada`.
   - Caso contrário, insere `nova-entrada` no início do conteúdo — **apenas se não houver** outra entrada com o mesmo nome naquele nível.

> 🛠️ **Dica:** Use `encontra-no-nivel` (do Exercício 1) para verificar se já existe uma entrada com o mesmo nome antes de inserir.

---

## 🏆 Exercício 5: Criação de Pokédex a partir de um Time

Vamos gerar automaticamente uma Pokédex a partir de um time de Pokémons.

1. Implemente a função `cria-pokedex(time :: Time) -> Entrada` que, dado um time:
   - Se o time for **vazio**, retorna um diretório `"Pokedex"` vazio.
   - Para cada Pokémon do time, cria um arquivo `"<nome>.pkm"` e o insere recursivamente na Pokédex construída com o restante do time.

2. Use `cria-time(POKE-DATA, range(1, 151))` para criar um time com todos os Pokémons da primeira geração e chame `mostra-entrada` para visualizar a Pokédex gerada.


---

## pokemon-lib4.arr

Biblioteca de Pokémon importada para o Laboratório 5.

```pyret
file: src/data/labs/pokemon-lib4.arr
```
