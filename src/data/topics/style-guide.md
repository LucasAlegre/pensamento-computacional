# Guia de Estilo Pyret (Testes, Design e Clareza)

Adaptado de [Pyret Style Guide - Brown University](https://cs111-docs.cs.brown.edu/s/pyret-guide).

---

## Exemplos (Testes Automatizados)

1. **Todas as funções, incluindo funções auxiliares, requerem exemplos** (exceto funções que retornam imagens). Eles servem como uma forma de documentação. Exemplos são escritos em blocos **where**.

2. Exemplos devem ser escritos **antes** de você começar a escrever sua função. Escrever bons exemplos ajuda você a entender como sua função deve se comportar com diferentes entradas.

3. Exemplos devem ilustrar variações interessantes nas entradas ou no comportamento da função. Você não precisa testar todas as combinações (o que seria impossível!), mas deve cobrir diferentes cenários.

---

## Diretrizes para desenvolver exemplos

### Cubra Casos Extremos (Edge Cases)

Casos extremos são entradas nos limites do espaço de entradas. Por exemplo, para uma função que testa "números entre 4 e 8", os limites são importantes. Outros limites comuns são strings vazias, zero, ou listas vazias.

### Exemplo Prático

Como exemplo, considere uma função **compare** que recebe dois números **x** e **y** e retorna uma string. Ela deve retornar **"muito menor"** se **x** for menor que **y - 2**, **"quase igual"** se **x** estiver entre **y - 2** e **y + 2** (inclusive) e **"muito maior"** se **x** for maior que **y + 2**. Aqui está um conjunto de bons exemplos para esta função:

```pyret
use context starter2024

fun compare(x :: Number, y :: Number) -> String:
  doc: "descreve a relação entre os números x e y"
  if x < (y - 2):
    "muito menor"
  else if (x >= (y - 2)) and (x <= (y + 2)):
    "quase igual"
  else:
    "muito maior"
  end
where:
  compare(1, 40) is "muito menor"
  compare(0, 3) is "muito menor"
  compare(8, 10) is "quase igual"
  compare(1, 1) is "quase igual"
  compare(0, 1) is "quase igual"
  compare(20, 17) is "muito maior"
end
```

Note que esses exemplos cobrem cada "caso" relevante do programa. Eles também incluem casos extremos testando os limites - por exemplo, **compare(8, 10)** é um caso extremo, pois está no limite entre os casos "muito menor" e "quase igual".

---

## Design

1. **Use constantes** para capturar relacionamentos entre valores. Evite "números mágicos" espalhados pelo código.

```pyret
use context starter2024

# Ruim
rectangle(500, 300, "solid", "green") # O que é 500?

# Bom
width = 500
height = 300
rectangle(width, height, "solid", "green")
```

2. **Use funções auxiliares** para evitar repetição de código. Se você tem uma expressão que aparece várias vezes com pequenas alterações, crie uma função. Por exemplo:

```pyret
use context starter2024

stairs = beside-align("bottom", rectangle(50, 50, "solid", "gray"),
 beside-align("bottom", rectangle(50, 100, "solid", "gray"),
   beside-align("bottom", rectangle(50, 150, "solid", "gray"),
     rectangle(50, 200, "solid", "gray"))))
```

Pode ser escrito como:

```pyret
use context starter2024

stair-width = 50
fun stair(height :: Number) -> Image:
  doc: "make an individual stair given its height"
  rectangle(stair-width, height, "solid", "gray")
end

stairs = beside-align("bottom", stair(50),
  beside-align("bottom", stair(100),
    beside-align("bottom", stair(150), stair(200))))
```

---

## Clareza

1. **Escreva docstrings** para todas as funções. Uma boa docstring descreve o que a função faz, suas entradas e saídas. Idealmente, olhando para a docstring você sabe o que a função faz e como usá-la sem precisar olhar para o corpo da função.

```pyret
use context starter2024

fun three-stripes(bot-col :: String, mid-col :: String, top-col :: String) -> Image:
  doc: "Cria uma bandeira retangular com três listras. As entradas descrevem as cores de baixo para cima."
  # ... implementação ...
end
```

2. **Dê nomes úteis** para constantes e funções.

```pyret
# Ruim
n1 = 3.1415
n2 = 500
n3 = 30
fun helper(x):
  x + 3
end

# Bom
pi = 3.1415
flag-width = 500
circle-radius = 30
fun add-3(x):
  doc: "adds three to its input x"
  x + 3
end
```

3. **Todas as funções requerem anotações de tipo** nas entradas e na saída.

4. Nomes de constantes e funções devem ser em minúsculas e separados por hífens (**kebab-case**).

```pyret
# Bom Estilo Pyret:
flag-width = 500
width-to-height-ratio = 3/5
CHARACTER-HEIGHT = 40 # Constantes de configuração podem ser UPPER-CASE

# Mau Estilo Pyret:
flag_width = 500
widthHeightRatio = 3/5
CharacterHeight = 40
```

5. **Mantenha as linhas abaixo de 80 caracteres**. Se a linha for muito longa, quebre-a. Docstrings muito grandes podem ser escritas usando aspas triplas (` ``` `):

```pyret
fun f(x :: Number) -> Number:
  doc: ```return 2; ignore inputs, always outputs 2 no matter what, 
          this function is going to return 2```
  2
end
```

6. **Indente seu código corretamente**. Use **Ctrl-A** (ou **Cmd-A**) e **Tab** para auto-indentar no editor web.

```pyret
# Ruim
fun f(x :: Number) -> Number:
ask:
    | x < 2 then: 2
| otherwise: 4
end
end

# Bom
fun f(x :: Number) -> Number:
  ask:
    | x < 2 then: 2
    | otherwise: 4
  end
end
```
