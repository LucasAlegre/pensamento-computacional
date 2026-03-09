# Tipos de Dados

<br>

Uma das tarefas mais importantes quando buscamos uma solução computacional para um problema é a escolha do
**modelo abstrato** que representa os estados possíveis da realidade, desconsiderando aspectos que não são relevantes para o problema em questão. Este modelo descreve os **dados** sobre os quais os algoritmos irão atuar. A representação adequada da realidade normalmente envolve tipos de informação diferentes, como números, imagens, nomes, ou mesmo dados com estruturas internas complexas, portanto é necessário termos definições claras e precisas sobre os tipos de dados que serão utilizados na solução de cada problema.

<br>

Um **tipo de dados** é um conjunto de elementos que podem ser **atômicos** (sem estrutura interna, como Números, valores Booleanos, Símbolos, ...) ou **compostos** (com estrutura interna, como registros, listas, matrizes, árvores, grafos, ...).
A maioria das linguagens de especificação/programação oferece vários tipos de dados básicos, normalmente chamados de **tipos pré-definidos**, bem como operações para trabalhar sobre estes tipos de dados, chamadas de **operações ou funções pré-definidas**. Além disso, as linguagens possuem também mecanismos para cada desenvolvedor poder criar novos tipos de dados (novos conjuntos) a partir de tipos já definidos. Normalmente, estes mecanismos são baseados em operações sobre conjuntos (produto cartesiano, união, ...), mas algumas linguagens também permitem a construção de tipos de dados através de definições recursivas.

<br>

A seguir, apresentaremos algumas formas de definir tipos de dados em **Pyret**. A seção sobre **Tipos Pré-Definidos** apresenta os tipos de dados básicos da linguagem, bem como algumas operações disponíveis. Pode-se também construir novos tipos de dados por enumeração ou usando a união de tipos já definidos (descrito em **Enumerações e Tipos Mistos**). O uso do produto cartesiano para agrupar campos constitui a construção fundamental apresentada em **Tipos Compostos: Estruturas**. Por fim, a seção sobre **Listas** apresenta uma maneira de construir tipos de dados de tamanho arbitrário utilizando recursão.


## 1. Tipos Pré-Definidos

A seguir, listamos alguns dos tipos básicos em Pyret, bem como as operações mais importantes associadas a eles.

### Booleano (Boolean)

Booleano é o conjunto dos valores lógicos verdadeiro (**true**) e falso (**false**):

`Booleano = {true, false}`

Algumas operações sobre Booleanos são:
<br>

- `not(b :: Boolean) -> Boolean`
  - **Obj:** Devolve a negação do valor Booleano.  
  - **Exemplo:**
    - `not(true)` is `false`.
    - `not(false)` is `true`.

- `and` (Operador)
  - **Obj:** Conjunção dos valores Booleanos. Em Pyret, é usado na forma infixa com um espaço ao redor de ambos os operandos. 
  - **Exemplo:** `true and false` is `false`.

- `or` (Operador)
  - **Obj:** Disjunção dos valores Booleanos.  
  - **Exemplo:** `true or false` is `true`.

- `is-boolean(v :: Any) -> Boolean`
  - **Obj:** Devolve `true` se o argumento for um Booleano.
  - **Exemplo:** `is-boolean(true)` is `true`.

### Número (Number)

O conjunto dos Números. Em Pyret, frações como `1/3` são representadas com precisão exata. A notação `~` no início de um número indica que o valor é aproximado/inexato (ex: `~1.5` ou o resultado de funções trigonométricas).

Operadores matemáticos básicos devem sempre possuir um espaço em branco antes e depois:
- `+`: `2 + 5` is `7`
- `-`: `2 - 5` is `-3`
- `*`: `2 * 5` is `10`
- `/`: `6 / 3` is `2`

Algumas funções pré-definidas da linguagem:

- `num-sqr(n :: Number) -> Number`
  - **Obj:** Calcula o quadrado do número passado como argumento.  
  - **Exemplo:** `num-sqr(5)` is `25`.

- `num-sqrt(n :: Number) -> Number`
  - **Obj:** Calcula a raiz quadrada (o número passado deve ser positivo).  
  - **Exemplo:** `num-sqrt(25)` is `5`.
  - **Exemplo:** `num-sqrt(1.5)` is `~1.224744871391589`.

- `num-expt(b :: Number, e :: Number) -> Number`
  - **Obj:** Calcula `b` elevado ao operador `e`.  
  - **Exemplo:** `num-expt(6, 2)` is `36`.

- `num-round(n :: Number) -> Number`
  - **Obj:** Arredonda o número para o inteiro mais próximo.  
  - **Exemplo:** `num-round(1.5)` is `2`.

- `num-to-string(n :: Number) -> String`
  - **Obj:** Transforma um número na textualização de seu valor (string).  
  - **Exemplo:** `num-to-string(5)` is `"5"`.

- `num-modulo(n :: Number, divisor :: Number) -> Number`
  - **Obj:** Devolve o resto da divisão inteira.  
  - **Exemplo:** `num-modulo(7, 2)` is `1`.

*Dica:* Outras numéricas úteis incluem `num-truncate`, `num-ceiling`, funções trigonométricas (`num-sin`, `num-cos`) e geradores aleatórios (`num-random`).

### String

Strings são sequências de caracteres do teclado. Em Pyret, são representados englobados por aspas simples ou duplas: `"casa"` ou `'casa'`.

- `is-string(v :: Any) -> Boolean`
  - **Obj:** Devolve `true` se o argumento for do tipo String.

- `string-equal(s1 :: String, s2 :: String) -> Boolean`
  - **Obj:** Verifica se duas strings são idênticas. Em Pyret, também se pode usar o operador de igualdade duplo `==`.  
  - **Exemplo:** `string-equal("casa", "casa")` is `true`.

- `string-length(s :: String) -> Number`
  - **Obj:** Retorna o número de caracteres da string. 
  - **Exemplo:** `string-length("casa")` is `4`.

- `string-append(s1 :: String, s2 :: String) -> String`
  - **Obj:** Constrói uma string unindo os dois argumentos. Em Pyret, o operador de soma `+` também interliga strings.  
  - **Exemplo:** `string-append("20", " casas")` is `"20 casas"`.

### Imagens (Image)

Pyret possui suporte robusto para tratar imagens ao importar sua biblioteca integrada correspondente (inclua a anotação `include image` no topo do arquivo do seu código). As imagens são tratadas como itens atômicos.

- `text(s :: String, size :: Number, color :: String) -> Image`
  - **Obj:** Desenha um texto convertido como uma imagem, definido pelo tamanho da fonte e cor.  
  - **Exemplo:** `text("Hello", 20, "green")`

- `circle(radius :: Number, mode :: String, color :: String) -> Image`
  - **Obj:** Desenha um círculo preenchido (`"solid"`) ou apenas com contorno (`"outline"`).  
  - **Exemplo:** `circle(20, "solid", "red")`

- Funções de desenho de polígonos acompanhadas por parâmetros muito similares: `rectangle`, `ellipse`, `star`.

- `overlay(img-cima :: Image, img-baixo :: Image) -> Image`
  - **Obj:** Produz uma imagem onde a primeira fica sobreposta centralizada em cima da segunda.

- `above(img-cima :: Image, img-baixo :: Image) -> Image`
  - **Obj:** Empilha a primeira imagem exatamente acima da segunda, anexadas lado-a-lado.
  
- `beside(img-esquerda :: Image, img-direita :: Image) -> Image`
  - **Obj:** Coloca as duas imagens vizinhas uma à outra horizontalmente.

- *Variações complexas:* Para alinhamentos ou rotações variadas existem também outras combinações (`above-align`, `beside-align`, `flip-horizontal`, `rotate`).

**Combinando tudo:**
```pyret
include image

olho = ellipse(10, 20, "solid", "black")
rosto = circle(50, "solid", "yellow")
boca = rectangle(30, 5, "solid", "black")

olhos = beside(olho, olho)
rosto-com-olhos = overlay(olhos, rosto)
rosto-completo = above(rosto-com-olhos, boca)

texto = text("Sorria!", 20, "blue")
estrela = star(20, "solid", "orange")

# Empilhando o texto, a estrela e o rosto final
above(
  above(texto, estrela),
  rosto-completo)
```

---

## 2. Enumerações

Em várias situações precisamos definir conjuntos finitos para serem usados como entrada ou saída de funções. Por exemplo:
- O conjunto das letras do alfabeto;
- O conjunto dos dígitos de 0 a 9;
- O conjunto de bases nitrogenadas do DNA;
- O conjunto de meses do ano;
- O conjunto com mensagem(ou mensagens) de erro.

Nestes casos, usar o bloco `data` de Pyret ajuda a modelar estes tipos explicitamente. Assim, documentamos um tipo ou conjunto explicitando todas as suas opções possíveis. Por exemplo, definindo os meses de um ano e as bases de DNA:

```pyret
data Meses:
  | jan
  | fev
  | mar
  # ...
  | dez
end

data BasesDNA:
  | A 
  | T 
  | C 
  | G 
end
```


## 3. Tipos Compostos: Estruturas

Em muitas situações, é interessante guardarmos informações relacionadas em um único bloco de dados empacotado. Por exemplo, gostaríamos de definir os seguintes tipos de dados (conjuntos):
- **Posn**: Conjunto de coordenadas de pontos no plano. Um ponto é composto por 2 informações: o valor no eixo `x` e o valor no eixo `y`.
- **Notas**: Conjunto das notas das provas 1 e 2 de um aluno. A unidade contém 2 informações.
- **Cadastro**: Conjunto de itens de um cadastro que contém `nome`, `endereco` e `telefone`. A unidade é composta por estas 3 informações.

Em cada um destes tipos listados acima, os elementos não são dados atômicos, mas tuplas (pares, triplas, quádruplas). Em Pyret, a maneira de definir e abstrair estes tipos de dados é utilizando a construção do bloco `data` criando estruturas (produto cartesiano de conjuntos).

Por exemplo, um conjunto de notas pode ser modelado usando Pyret como o tipo formal de dados `Notas`:

```pyret
data Notas:
  # Um elemento do tipo Notas tem o formato:
  | notas(prova1 :: Number, prova2 :: Number)
  # onde prova1 é a nota da prova1 e prova2 é a nota da prova2.
end

notas-aluno = notas(9.5, 10.0)
```

Para declarar as coordenadas em um plano 2D:

```pyret
data Posn:
   # Um elemento do tipo Posn tem o formato:
  | posn(x :: Number, y :: Number)
  # onde x é a coordenada no eixo x e y a coordenada no eixo y do ponto
end
```

Em notação matemática, este tipo de dado de conjunto de tuplas equivale a descrever este agrupamento usando um *Produto Cartesiano*:
`Posn = Número × Número` ou `Posn = {(make-posn x y) | x ∈ Número e y ∈ Número}`

### Funções Automáticas de Estrutura

Ao declararmos esse bloco `data`, o **Pyret** constrói funções utilitárias embutidas de forma invisível. Suponha a definição da estrutura acima `Notas`.


**1. Acesso a Campos (Atributos)**
Para visualizarmos dados isolados pertencentes à uma instância previamente estruturada (como `prova-alunoA`), nós chamamos o nome do campo com um ponto `.` de forma afixada à estrutura, recuperando assim o seu valor singular. Isso substitui os seletores manuais do Racket (ex: `notas-prova1(prova-alunoA)`).
```pyret
data Notas:
  # Um elemento do tipo Notas tem o formato:
  | notas(prova1 :: Number, prova2 :: Number)
  # onde prova1 é a nota da prova1 e prova2 é a nota da prova2.
end

notas-aluno = notas(9.5, 10.0)

# Extraindo a prova1 e prova2 do de notas-aluno
check:
  notas-aluno.prova1 is 9.5
  notas-aluno.prova2 is 10.0
end
```

**3. Testador (Predicado)**

Você também pode verificar via funções auxiliares do `data` ou no corpo sintático pelo formato do tipo se o dado pertence aquela estrutura. Com o `Cases`, a decomposição destas instâncias se dá nativamente pelo seu identificador (predicado formal). Use a função `is-nomeEstrutura` se precisar de testes avulsos, ou compare seu tipo formalmente (`is Notas`, porém Pyret já tem _type checking_ intrínseco aos argumentos da função).

- **Exemplo:
  - `is-notas(notas-aluno) is true`
  - `is-notas(7.0) is false`

---

## 4. Tipos Compostos: Listas

**Listas** formam um tipo de dados muito utilizado em Computação. Esse tipo de bloco é frequentemente utilizado sempre que tivermos um número arbitrário (mas finito) de elementos que queremos armazenar de forma conjunta – por exemplo, notas dos alunos de uma turma, itens de um cadastro, bases nitrogenadas do DNA, descendentes de uma pessoa, etc.

A definição de listas é **recursiva**, ou seja, utiliza-se a própria noção de `lista` na sua definição. Para uma definição recursiva ser bem formada, é necessário que se utilize (no mínimo) uma base, que no caso das listas é a lista *vazia* (`empty`), e um operador para construir a lista estendendo-a. 

No caso do Pyret, usamos o construtor `link` (semelhante ao `cons` do Racket) ou instanciamos listas pela abstração sintática `[list: ...]`.

A declaração e estrutura formal em Pyret de uma **Lista de Números** seria:

```pyret
data ListaDeNumeros:
  # Uma elemento de ListaDeNumeros é
  | l-empty  # vazio; ou
  | l-link(first :: Number, rest :: ListaDeNumeros)
  # onde first é o primeiro elemento da lista, e rest o resto da lista.
end

l-link(1, l-link(2, l-empty))
```

Esta definição cria o conjunto genérico, que contém todas as listas finitas cujos elementos são números. Exemplo:

- `empty`
- `link(0, empty)`
- `link(2, link(0, empty))`
- `link(-1, link(0, link(3, empty)))`

Os construtores explícitos `link` e `empty` podem ser completamente trocados para maior legibilidade pelo atalho sintático `[list: ]`:
`[list: n1, n2, n3, n4, n5]` equivale perfeitamente à escrita afunilada de links.

### Funções Pré-Definidas para Listas

Como as listas também são geridas ativamente por blocos `data` pre-construídos na linguagem (`List`), nós ganhamos acesso às funções instanciadas na estrutura de listas por padrão:

**1. `first`**
- **Obj:** Dada uma lista de elementos do tipo `TipoElem`, devolve seu primeiro elemento. Equivalente a extrair o `first` do `link`.
- **Exemplo:**
```pyret
link(2, link(0, empty)).first # is 2
```
- `empty.first` gera um erro de execução.

**2. `rest`**
- **Obj:** Dada uma lista, esta função devolve a lista completa sem o seu primeiro elemento (o resto ou cauda).
- **Exemplo:**
```pyret
link(2, link(0, empty)).rest # is [list: 0]
```

**3. Testadores**
- **`is-empty`:** Retorna verdadeiro se for uma lista vazia. (`is-empty(empty)` -> `true`)
- **`is-link`:** Retorna verdadeiro se a lista for encadeada/possuir pelo menos 1 elemento.

Outros métodos acoplados incluem `.length()` (tamanho da lista), `.push(...)` (anexar) ou `.append(...)` (fundir duas listas).

**Importante:** Podemos usar o tipo List pré-definido em Pyret para definir listas de quaisquer tipos. Em Pyret, isso se descreve genericamente através do formato de parâmetro de tipo como: `List<Number>`, `List<String>`, `List<Any>`.

---

## 5. Tipos Compostos: Cenas

A linguagem Pyret (através do pacote de `image`) também provê recursos de processamento para interagir com uma **Cena** (o tipo Canvas de fundo limitante gerado). Uma cena é composta por várias imagens organizadas através de coordenadas, usualmente colocadas sobre uma tela inicialmente vazia (`empty-scene`). 

Podemos usar essa definição abstratamente recursiva para construir sobreposições em cenas. Por exemplo, uma `Cena` pode ser:

- `empty-scene(larg :: Number, alt :: Number)`
  - Onde `larg` e `alt` são as arestas em pixels.

- `place-image(img :: Image, x :: Number, y :: Number, c :: Cena)`
  - Retorna uma nova `Cena` (uma imagem contida) que repete o Canvas original desenhando a Imagem de `img` no deslocamento (`x`, `y`). O processo de compor o cenário acontece iterativamente/recursivamente se utilizarmos múltiplas chamadas sobre a cena pai.

**Exemplo:**

```pyret
include image

circulo-vermelho = circle(25, "solid", "red")
quadrado-azul = rectangle(30, 30, "solid", "blue")
estrela-verde = star(25, "solid", "darkgreen")

cena-final = 
  place-image(quadrado-azul, 350, 20,
    place-image(circulo-vermelho, 270, 100,
      place-image(estrela-verde, 90, 50,
        place-image(estrela-verde, 250, 180,
          place-image(quadrado-azul, 150, 140,
            place-image(circulo-vermelho, 50, 30,
              empty-scene(400, 200)))))))

cena-final
```
