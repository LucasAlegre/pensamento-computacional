# Laboratório 1

## 🎯 Contexto e Objetivos

Neste laboratório, você irá exercitar a definição e o uso de **constantes**, bem como a criação de funções simples com **condicionais** (`ask`) e a composição gráfica usando a **biblioteca de imagens** do Pyret. 

<br>

O tema deste laboratório é o universo de Pokémon! Cada Pokémon possui um **tipo** (como Fogo 🔥, Água 💧, Grama 🌿, etc.), e as batalhas são muito influenciadas pela interação entre esses tipos — alguns tem vantagens sobre outros!

Sua missão é **construir visualmente as cartas** de diferentes Pokémon e **simular o resultado de um ataque** explorando pura lógica de programação.

> 💡 **INSTRUÇÕES PARA O LABORATÓRIO:**
> - Siga as dicas de estilo de código do Pyret: https://lucasalegre.github.io/pensamento-computacional/topics/style-guide 
> - Use os nomes de funções definidos nas questões.
> - DEVE ser colocada a documentação completa, ou seja, contrato, objetivo, e pelo menos 2 exemplos/testes (só não precisa incluir testes nas funções que geram imagens).
> - Nas funções que geram imagens, deixe apenas as chamadas para que quando seu arquivo for executado, as imagens sejam geradas.
> - Em todos os condicionais, explique cada caso com um comentário.

## Template

Copie o template para o seu ambiente de desenvolvimento (code.pyret.org ou VS Code). Não esqueça de salvar o seu arquivo!

```pyret
file: src/data/labs/lab1-template.arr
```

## 🛠️ Exercício 1: Constantes de Texto

**Constantes** são nomes que damos para valores. Podemos definir constantes de qualquer tipo e devemos escolher
nomes significativos para as constantes. Duas das grandes vantagens de usarmos constantes são: (i) tornar o
código mais *legível*, pois usamos uma palavra para representar um valor; (ii) tornar o código mais *fácil de alterar*,
pois se quisermos mudar o valor associado à esta constante é necessário apenas alterar o valor no lugar onde a
constante foi definida (ao invés de procurar em todo o código os locais onde um determinado valor foi usado).

O bom uso de constantes faz com que menos erros sejam cometidos.

Defina as seguintes constantes (que serão usadas mais para frente):

| Nome da Constante | Valor Exato (String) |
| :--- | :--- |
| `ATAQUE` | `"Attack"` |
| `DEFESA` | `"Defense"` |
| `efeito-naoefetivo` | `"Not very effective"` |
| `efeito-efetivo` | `"Effective"` |
| `efeito-superefetivo` | `"Super-effective!"` |

Além destas, defina as **constantes dos tipos de Pokémon**: `type-normal`, `type-fire`, `type-water`, `type-electric` e `type-grass`. O valor atribuído a cada uma deve ser uma _string_ com o seu próprio nome em maiúsculas (ex: `"FIRE"` ou `"GRASS"`).

---

## 🎨 Exercício 2: Constantes de Elementos da Mesa

Usando as conhecidas funções gráficas do Pyret (`rectangle`, `circle`, etc.), defina as **constantes visuais** que formarão nossas cartas e o campo de batalha. Preste atenção nas dimensões indicadas.

- **Dimensões das Cartas:** `carta-alt = 175` e `carta-lar = 125` *(elas já devem estar no topo do seu template!)*.
- **Fundos de cada tipo:** Defina retângulos **sólidos** (`"solid"`) das dimensões base acima. Use cores que representem cada tipo de Pokémon (e.g., verde para grama, azul para água).

As cores em Pyret podem ser encontradas aqui: https://pyret.org/docs/latest/color.html#%28part._s~3acolor-constants%29

- **Componentes visuais da batalha:**
  - `mesa`: O local do duelo. Será um círculo `"solid"` e cinza claro (`"lightgray"`). O *raio* deve ser `20 + carta-alt`.
  - `borda`: A fita de baralho da carta. Será um retângulo sem preenchimento (`"outline"`) na cor preta (`"black"`). Ele deve ser **um pouco maior** que o tamanho base da carta. Faça com que a largura seja `carta-lar + 10` e a altura seja `carta-alt + 10`.

> ⚠️ **ATENÇÃO:** Algumas variáveis contendo imagens de Pokémon autênticas extraídas da internet já foram providenciadas no topo do seu template (`bulbasaur-img`, `squirtle-img`, etc.). Use esses *sprites* estilizados para seus Pokémons!

---

## 🔍 Exercício 3: Selecionando as Peças
Vamos agora dar movimento condicional ao jogo! Crie duas funções utilizando a super-estrutura lógica `ask` para filtrar retornos:

1. **A função `seleciona-fundo`**: tem 1 argumento, uma `String` (o **tipo**). Ela deve devolver a **constante de imagem de fundo** correta. 
   - *Exemplo:* se o `tipo` passado for igual a `type-fire`, retorne a imagem em `fundo-fire`.

2. **A função `seleciona-imagem-pokemon`**: tem 1 argumento, uma `String` (o **nome do Pokémon**). Ela deve devolver a respectiva imagem (`bulbasaur-img`, etc.). Cubra as strings `"Bulbasaur"`, `"Charmander"`, `"Squirtle"` e `"Pikachu"`.

> 📝 **LEMBRETE SOBRE OS TESTES!**
> Nunca deixe as cláusulas `where:` vazias! Preencha-as testando o que a função deve retornar. 
> Ex: `seleciona-fundo(type-fire) is fundo-fire`

---

## 🖼️ Exercício 4: Montagem Prática
Vamos utilizar a poderosa capacidade de sobreposição do Pyret (`overlay` e `overlay-align`) para montar nossa arte final!

Implemente a função `cria-carta` recebendo dois parâmetros (ambos `String`): o **nome** e o **tipo** respectivo. Ela deve devolver a `Image` pronta da carta.

> 🛠️ **Dica de Funções:**
> Você precisará usar pesadamente as funções de composição de imagem do Pyret para colocar os elementos uns sobre os outros!
> - `overlay(img1, img2)`: Para colocar uma imagem centralizada **em cima** de outra.
> - `overlay-align(x, y, img1, img2)`: Para alinhar objetos! Ex: `overlay-align("middle", "bottom", texto, fundo)`.
> - Utilize a sua função `seleciona-fundo` para buscar a base e `seleciona-imagem-pokemon` para buscar o lutador.
> - Lembre-se que a nossa `borda` (definida no Exercício 2) tem que ficar por cima de tudo pra dar o acabamento em volta da carta toda!

*Devolva a imagem composta! Descomente e admire o seu resultado rodando `cria-carta("Bulbasaur", "GRASS")`!*

A sua carta formatada deverá se parecer com o exemplo abaixo:

![Exemplo de Carta Pronta](images/lab1/bulbasaur_card.png)

---

## ⚔️ Exercício 5: Vantagens e Efeitos
Em um embate, certos elementos dominam outros! Desenvolva a função lógica chamada de `verifica-efeito` com os parâmetros `tipo-ataque` e `tipo-defesa` (ambas Strings). Ela avalia e **retorna a constante correta do efeito da briga** (`efeito-naoefetivo`, `efeito-efetivo` ou `efeito-superefetivo`).

Siga precisamente as diretrizes das Vantagens (*Ataque atinge -> Defesa*):

| Atacante | Fraqueza (Super Efetivo) | Resistência (Não Efetivo) |
| :---: | :--- | :--- |
| 🔥 **FIRE** | Ganha fácil de `GRASS` | Passa mal contra `WATER` ou `FIRE` |
| 💧 **WATER** | Ganha em cheio do `FIRE` | Pouco efeito contra `GRASS` ou `WATER` |
| ⚡ **ELECTRIC**| Frita a água do `WATER` | Inútil contra `GRASS` e curto-circuito no `ELECTRIC` |
| 🌿 **GRASS** | Se esbalda no `WATER` | Queima pro `FIRE` ou empata com o `GRASS` |

*Para TODAS as outras permutações, considere apenas o genérico **Efeito Efetivo**.*

> 🧠 **DICA PARA OS CASOS ASK:** 
> Teste primeiro "se o atacante for de fogo". Daí, **dentro desse bloco**, abra *outro ask* pra testar quem é o defensor! Fazer "ask aninhados" limpa muito código confuso!

> Tabela de vantagens: https://pokemondb.net/type
---

## 💥 Exercício 6: Efeito e Fogo - Batalha Final
A obra prima da computação exige colisão de matrizes (no estilo visual pelo menos 😂). Crie a função `desenha-cenario`!

**Entrada:** 
1. Imagem da `carta-ataque`
2. Imagem da `carta-defesa`
3. A imagem da `mesa` do cenário
4. A `String` contendo o julgamento do `resultado-efeito`.

> 🛠️ **Dica de Funções:**
> Novamente, use as funções gráficas a seu favor para alinhar os objetos como na imagem de exemplo abaixo!
> - `above(img1, img2)`: Coloca a primeira imagem exatamente acima da segunda (Ideal para colocar os letreiros com os textos da constante `ATAQUE` em cima da carta atacante, além do texto final embaixo da mesa toda).
> - `beside(img1, img2)`: Coloca a primeira imagem lado a lado à esquerda da segunda. Aproveite para montar as duas cartas em modo duelo!
> - `overlay-align(x, y, img1, img2)`: Será essencial para você assentar a dupla lado a lado exatamente no centro da imagem da nossa `mesa`.

**Pronto, você construiu seu programa funcional para criar batalhas dinâmicas! Descomente as linhas finais do template com as chamadas de teste e veja a mágica acontecer. Parabéns por concluir o primeiro Laboratório! 🚀**

Seu cenário final deverá se parecer com isso:

![Exemplo de Cenario Batalha](images/lab1/cenario1.png)
![Exemplo de Cenario Batalha](images/lab1/cenario2.png)
