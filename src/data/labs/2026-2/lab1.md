# Laboratório 1: Truco Gaúcho

## 🎯 Contexto e Objetivos

Neste laboratório, vamos praticar os conceitos fundamentais de projeto de algoritmos vistos em aula:
- Criação de **constantes** para definições de valores;
- Criação de funções e uso de **composição de funções** com a biblioteca gráfica do Pyret;
- Criação de funções com **expressões condicionais** (`ask`);
- Escrita de **documentação** (`doc:`) e testes (`where:`).

<br>

O tema deste laboratório é o tradicional jogo de cartas do Rio Grande do Sul: o **Truco Gaúcho (ou Truco Gaudério / Cego)**! 🧉🃏

No Truco Gaúcho, joga-se com o baralho espanhol de 40 cartas (sem os 8s, 9s e curingas) distribuídas em quatro naipes: **Espadas**, **Paus**, **Ouros** e **Copas**.

As regras oficiais e terminologias que utilizaremos como referência neste laboratório podem ser consultadas em:
> 🔗 **[Regras do Truco Gaudério - Jogatina.com](https://www.jogatina.com/regras-como-jogar-truco-gauderio.html)**

<br>

Sua missão neste laboratório é **construir visualmente as cartas do baralho espanhol**, **programar a escala de forças entre as cartas** e **simular o confronto de uma rodada na mesa de jogo**!

> 💡 **INSTRUÇÕES GERAIS:**
> - Siga as diretrizes de estilo de código do Pyret: [Guia de Estilo](https://lucasalegre.github.io/pensamento-computacional/topics/style-guide).
> - Utilize exatamente os nomes de constantes e funções definidos nos enunciados.
> - Todas as funções devem conter cabeçalho completo: **contrato de tipos**, string de **objetivo** (`doc:`) e pelo menos **2 exemplos de teste** na cláusula `where:`. Não é necessário incluir testes nas funções que geram imagens.
> - Em todas as cláusulas condicionais (`ask`), comente cada ramo explicando a regra correspondente.
> - Você pode consultar funções úteis sobre imagens em [Tipos de Dados](https://lucasalegre.github.io/pensamento-computacional/topics/tipos-de-dados) ou na [documentação oficial de Imagens do Pyret](https://pyret.org/docs/latest/image.html).

---

## Template

Copie o template para o seu ambiente de desenvolvimento ([code.pyret.org](https://code.pyret.org) ou VS Code com extensão Pyret):

```pyret
file: src/data/labs/2026-2/lab1-template.arr
```

---

## 🎴 Hierarquia de Força das Cartas no Truco Gaúcho

A força de uma carta no Truco Gaudério varia em uma escala de **1 a 14** (da mais fraca para a mais forte):

| Força | Carta(s) | Descrição / Papel no Jogo |
| :---: | :--- | :--- |
| **14** | **1 de Espadas** | *Espadilha* (A maior carta do jogo) |
| **13** | **1 de Paus** | *Bastilho* (Segunda maior manilha) |
| **12** | **7 de Espadas** | *Manilha de Espadas* |
| **11** | **7 de Ouros** | *Sete de Ouro / Sete Bello* |
| **10** | **Todos os 3s** (Espadas, Paus, Ouros, Copas) | Maior carta comum |
| **9** | **Todos os 2s** (Espadas, Paus, Ouros, Copas) | |
| **8** | **1 de Copas e 1 de Ouros** | Ases comuns (não-manilhas) |
| **7** | **Todos os 12s (Reis)** | |
| **6** | **Todos os 11s (Cavalos)** | |
| **5** | **Todos os 10s (Valetes)** | |
| **4** | **7 de Copas e 7 de Paus** | Setes comuns (não-manilhas) |
| **3** | **Todos os 6s** | |
| **2** | **Todos os 5s** | |
| **1** | **Todos os 4s** | Menor carta do baralho |

*Quando duas cartas de mesma força se enfrentam (por exemplo, 3 de Paus vs 3 de Copas), a rodada **empata**.*

---

## 🛠️ Exercício 1: Constantes de Texto

**Constantes** são nomes atribuídos a valores que tornam o código mais legível e fácil de manter.

Defina no seu arquivo as seguintes constantes:

### 1. Naipes
| Nome da Constante | Valor (String) |
| :--- | :--- |
| `NAIPE-ESPADAS` | `"ESPADAS"` |
| `NAIPE-PAUS` | `"PAUS"` |
| `NAIPE-OUROS` | `"OUROS"` |
| `NAIPE-COPAS` | `"COPAS"` |

### 2. Resultados da Rodada
| Nome da Constante | Valor (String) |
| :--- | :--- |
| `VITORIA-J1` | `"Jogador 1 venceu a rodada!"` |
| `VITORIA-J2` | `"Jogador 2 venceu a rodada!"` |
| `EMPATE` | `"Empatou a rodada!"` |

---

## 🎨 Exercício 2: Constantes de Imagem e Mesa

Usando as funções gráficas do Pyret (`rectangle`, `circle`, etc.), defina as **constantes visuais** das cartas e da mesa:

- **Dimensões Base:** `CARTA-ALT = 175` e `CARTA-LAR = 125` *(já inclusas no template)*.
- **Fundos e Borda das Cartas:**
  - `FUNDO-CARTA`: retângulo sólido (`"solid"`) na cor `"white"` com dimensões `CARTA-LAR - 10` e `CARTA-ALT - 10`.
  - `BORDA`: retângulo sólido (`"solid"`) na cor `"white"` com dimensões `CARTA-LAR` e `CARTA-ALT`.
- **Mesa do Jogo:** `MESA` deve ser um círculo `"solid"` na cor verde escura (`"darkgreen"`), com raio igual a `20 + CARTA-ALT`.

> 💡 *As imagens dos quatro naipes (`ICONE-ESPADAS`, `ICONE-PAUS`, etc.) já estão pré-carregadas no topo do seu template.*

---

## 🖼️ Exercício 3: Composição Básica de Imagens

Antes de trabalhar com lógica condicional, vamos criar duas funções auxiliares puramente visuais para compor as partes da carta:

1. **`fundo-com-icone(icone :: Image) -> Image`**:
   - Recebe a imagem do ícone de um naipe e centraliza esse ícone sobre o `FUNDO-CARTA` usando a função `overlay`.

2. **`adiciona-borda(carta :: Image) -> Image`**:
   - Recebe a imagem de uma carta e adiciona a borda externa, alinhando ao centro o `frame(carta)` sobre a `BORDA` usando `overlay-align("middle", "middle", frame(carta), BORDA)`.

---

## 🔍 Exercício 4: Expressões Condicionais (Seleção de Ícone e Manilhas)

Implemente as seguintes funções utilizando a expressão condicional `ask`:

1. **`seleciona-icone-naipe(naipe :: String) -> Image`**:
   - Recebe uma `String` com o nome do naipe e devolve a imagem do ícone correspondente (`ICONE-ESPADAS`, `ICONE-PAUS`, `ICONE-OUROS`, `ICONE-COPAS`).
   - Adicione testes no bloco `where:` para verificar todos os 4 naipes.

2. **`eh-manilha(valor :: Number, naipe :: String) -> Boolean`**:
   - Recebe o valor numérico e o naipe de uma carta e devolve `true` se ela for uma das **4 manilhas fixas** do Truco Gaúcho:
     - 1 de Espadas (*Espadilha*)
     - 1 de Paus (*Bastilho*)
     - 7 de Espadas
     - 7 de Ouros
   - Devolve `false` para qualquer outra carta.
   - Adicione testes no `where:`, cobrindo tanto as 4 manilhas quanto cartas comuns.

---

## 🃏 Exercício 5: Montagem da Carta de Truco

Implemente a função **`cria-carta(valor :: Number, naipe :: String) -> Image`**:
- Recebe o número e o naipe da carta e devolve a imagem da carta completa montada:
  - O valor numérico em texto no topo da carta (`text(num-to-string(valor), 24, "black")`).
  - O ícone do naipe no centro da carta obtido via `fundo-com-icone(seleciona-icone-naipe(naipe))`.
  - O nome do naipe em texto na parte inferior (`text(naipe, 14, "black")`).
  - A moldura externa adicionada via `adiciona-borda`.

*Teste sua função executando:*
```
cria-carta(1, NAIPE-ESPADAS)
cria-carta(7, NAIPE-OUROS)
```

---

## ⚖️ Exercício 6: Força da Carta no Truco Gaúcho

Implemente a função **`forca-carta(valor :: Number, naipe :: String) -> Number`**:
- Recebe o número e o naipe da carta e devolve o seu peso de força na escala de **1 a 14**, seguindo a tabela da seção [Hierarquia de Força](#-hierarquia-de-força-das-cartas-no-truco-gaúcho).
- Utilize a estrutura condicional `ask`.

> 🧠 **Dica de Projeto:**
> Teste primeiro os casos especiais das **4 manilhas fixas** (que dependem tanto do número quanto do naipe). Em seguida, trate as cartas comuns (3s, 2s, 1s restantes, 12s, 11s, 10s, 7s restantes, 6s, 5s e 4s).

Inclua no bloco `where:` testes para manilhas, cartas comuns de valores altos e cartas mais fracas.

---

## ⚔️ Exercício 7: Duelo e Montagem da Rodada na Mesa

Vamos estruturar o duelo da rodada utilizando composição direta de funções:

1. **`compara-cartas(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> String`**:
   - Compara as forças da carta jogada pelo **Jogador 1** e pelo **Jogador 2**.
   - Se a carta 1 for mais forte, devolve `VITORIA-J1`.
   - Se a carta 2 for mais forte, devolve `VITORIA-J2`.
   - Se ambas tiverem a mesma força, devolve `EMPATE`.
   - Preencha o bloco `where:` com testes para vitórias de ambos os jogadores e situações de empate.

2. **`rotula-carta(nome-jogador :: String, valor :: Number, naipe :: String) -> Image`**:
   - Posiciona o nome do jogador em texto branco acima da carta criada com `cria-carta`.

3. **`desenha-duelo(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> Image`**:
   - Coloca as cartas rotuladas dos dois jogadores lado a lado (`beside`) e centraliza sobre a `MESA`.

4. **`desenha-cenario(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> Image`**:
   - Combina o resultado visual de `desenha-duelo` com o texto do resultado obtido por `compara-cartas`, posicionado abaixo da mesa.

> 🛠️ **Dica de Funções:**
> - `above(img1, img2)`: posiciona a primeira imagem acima da segunda.
> - `beside(img1, img2)`: posiciona as imagens lado a lado.
> - `overlay-align("middle", "middle", duelo, MESA)`: centraliza o duelo sobre a mesa.

Descomente as chamadas no final do template e admire o resultado do duelo gaudério na sua tela! 🧉
