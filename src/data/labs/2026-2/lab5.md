# Laboratório 5: Agenda de Contatos e Tópicos de Discussão

## 🎯 Contexto e Objetivos

Neste laboratório, vamos voltar ao **aplicativo de mensagens** dos Laboratórios 3 e 4 e adicionar duas novas funcionalidades. Cada uma é modelada com um tipo de **árvore** visto em aula:

- **Parte 1 — Agenda de contatos:** os contatos ficam guardados em uma **árvore binária de pesquisa** (ABP), ordenada pelo nome, para que a busca seja rápida (Aula 21);
- **Parte 2 — Tópicos de discussão:** um comentário pode receber respostas, que também podem receber respostas, formando uma **árvore n-ária** que processamos com **recursão mútua** (Aula 22).

<br>

Este laboratório usa a mesma **biblioteca** do Laboratório 4 (`chat-lib4.arr`), importada no template com:

```
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/chat-lib4.arr")
```

Da biblioteca, vamos reutilizar principalmente a estrutura **`Usuario`** (com os campos `nome`, `avatar` e `online`). Na biblioteca, também estão definidas: 
- As **definições de dados** `Agenda` e `Comentario`;
- Os **contatos de teste** e outras constantes que você pode usar nas suas cláusulas `where:`;
- **Funções de desenho** para visualizar as agendas (`desenha-agenda`) e para usar no Exercício 6 (`desenha-comentario` e `recua`).

> 💡 **INSTRUÇÕES PARA O LABORATÓRIO:**
> - Siga as dicas de estilo de código do Pyret: https://lucasalegre.github.io/pensamento-computacional/topics/style-guide
> - Use exatamente os nomes de constantes e funções definidos nos enunciados.
> - Todas as funções devem conter documentação completa: **contrato de tipos**, string de objetivo (`doc:`) e pelo menos **2 exemplos/testes** na cláusula `where:` (só não é obrigatório incluir testes nas funções que geram imagens).
> - Em todas as cláusulas condicionais (`ask`, `cases`, `if`), inclua um comentário explicando cada caso.

---

## Template

Copie o template para o seu ambiente de desenvolvimento (code.pyret.org ou VS Code). Não esqueça de salvar o seu arquivo!

```pyret
file: src/data/labs/2026-2/lab5-template.arr
```

---

## 📇 Parte 1: Agenda de Contatos

Quando queremos mandar uma mensagem, procuramos o contato pelo **nome**. Se a agenda fosse uma lista, no pior caso teríamos que olhar todos os contatos até encontrar o que procuramos. Por isso, vamos guardar os contatos em uma **árvore binária de pesquisa**, ordenada pelo nome.

### 📖 Conhecendo a Agenda

A definição de dados já está no template:

```
data Agenda:
  | vazia
  | no(
      contato :: Usuario,  # Contato guardado neste nó
      esq :: Agenda,       # Contatos cujos nomes vêm ANTES de contato.nome (em ordem alfabética)
      dir :: Agenda)       # Contatos cujos nomes vêm DEPOIS de contato.nome (em ordem alfabética)
end
```

Ela segue a mesma ideia da ABP da aula, com o **nome** do contato fazendo o papel do identificador. A **invariante** da agenda é: os nomes da subárvore esquerda vêm antes do nome da raiz, e os nomes da subárvore direita vêm depois.

Em Pyret, os operadores `<` e `>` também comparam strings em ordem alfabética. Por exemplo, `"Ana" < "Bia"` é `true` e `"Duda" > "Caio"` também é `true`. Todos os nomes deste laboratório começam com letra maiúscula e sem acento, então a ordem de `<` é a ordem alfabética.

O template traz as seguintes constantes e funções:

- Os contatos de teste `CONTATO-ANA` (online, vem da biblioteca), `CONTATO-BIA` (offline), `CONTATO-CAIO` (online) e `CONTATO-DUDA` (offline);
- `CONTATOS-TURMA`, uma lista com 15 contatos, usada para construir uma agenda maior no Exercício 3;
- A função `cria-contato(nome :: String, online :: Boolean) -> Usuario`, que cria um contato com o avatar gerado a partir do nome. Por exemplo, `cria-contato("Eva", true)`;
- A função `desenha-agenda(a :: Agenda) -> Image`, que desenha uma agenda em forma de árvore. O pequeno círculo no avatar indica se o contato está online (verde) ou offline (cinza), e a palavra `vazia` marca as subárvores vazias.

---

### ✍️ Exercício 1: Agenda de teste

Defina a constante `AGENDA-TESTE`, do tipo `Agenda`, com os quatro contatos de teste organizados assim:

```
          Caio
         /    \
      Ana      Duda
         \
         Bia
```

Por exemplo, uma agenda com apenas a Ana seria `no(CONTATO-ANA, vazia, vazia)`.

Depois, execute `desenha-agenda(AGENDA-TESTE)` (a chamada já está no template) e confira se o desenho corresponde ao diagrama. Verifique também se a sua agenda respeita a invariante: o que mudaria se a Bia estivesse à esquerda da Ana?

> ℹ️ Os exemplos (`where:`) que o template traz para os próximos exercícios usam a `AGENDA-TESTE`. Por isso, ela deve ser exatamente a agenda do diagrama.

---

### 🔍 Exercício 2: Buscando um contato

Implemente a função `busca-status(nome :: String, a :: Agenda) -> String` que, dado o nome de um contato e uma agenda, devolve:
- `"online"` ou `"offline"`, conforme o status do contato com este nome;
- `"Contato não encontrado"`, se não houver contato com este nome na agenda.

> 🛠️ **Dica:** Use a invariante da ABP! Compare o nome procurado com o nome do contato da raiz e continue a busca em **apenas uma** das subárvores: não faz sentido procurar na subárvore esquerda um nome que vem depois do nome da raiz.

---

### ➕ Exercício 3: Adicionando contatos

Implemente a função `insere-contato(u :: Usuario, a :: Agenda) -> Agenda` que, dado um contato e uma agenda, devolve uma nova agenda com o contato inserido na posição correta, mantendo a invariante. Se a agenda já tiver um contato com o **mesmo nome**, ele deve ser **substituído** pelo novo contato (por exemplo, para atualizar o status de online).

> 🛠️ **Dica:** `insere-contato` é parecida com a função `insere-no` da aula, mas tem um terceiro caso: quando o nome do novo contato é igual ao nome da raiz.

O template já traz pronta a função `cria-agenda(contatos :: List<Usuario>) -> Agenda`, que usa a sua `insere-contato` para construir uma agenda a partir de uma lista de contatos, do mesmo jeito que a função `constroi-abp` da aula: ela insere o primeiro contato na agenda construída com o resto da lista. Por isso, o último contato da lista é o primeiro a ser inserido e vira a raiz.

> 🚀 **Experimente na agenda da turma:** O template define `AGENDA-TURMA = cria-agenda(CONTATOS-TURMA)`. Descomente as chamadas `desenha-agenda(AGENDA-TURMA)` e `busca-status("Iris", AGENDA-TURMA)`. A agenda deve ficar assim:
>
> ```
>                         Leo
>              /                    \
>          Duda                      Pedro
>        /      \                  /       \
>     Bia        Heitor        Nico         Sofia
>    /   \      /     \       /    \       /     \
>  Ana  Caio  Gabi   Iris  Marina  Otto  Rafa   Tiago
> ```
>
> Quantos contatos a busca visita até encontrar a Iris, em uma agenda com 15 contatos?

---

## 💬 Parte 2: Tópicos de Discussão

O aplicativo ganhou uma nova funcionalidade: **tópicos de discussão**, como nos fóruns do Moodle. Alguém publica um comentário, outras pessoas respondem, e as respostas também podem receber respostas.

### 📖 Conhecendo os Tópicos

A definição de dados também já está no template:

```
type ListaDeRespostas = List<Comentario>

data Comentario:
  | comentario(
      autor :: String,                # Nome de quem escreveu o comentário
      texto :: String,                # Texto do comentário
      curtidas :: Number,             # Quantidade de curtidas que o comentário recebeu
      respostas :: ListaDeRespostas)  # Respostas a este comentário (cada resposta também é um Comentario)
end
```

Repare na **referência mútua**: um `Comentario` tem uma `ListaDeRespostas`, e uma `ListaDeRespostas` é uma lista de `Comentario`. É a mesma estrutura de `Pessoa` e `ListaDeFilhos` da Aula 22. Por isso, as funções desta parte vêm em **pares**: uma que processa um `Comentario` e outra que processa uma `ListaDeRespostas`, e uma chama a outra.

O template também traz pronto um tópico maior, `TOPICO-DUVIDA`, com 9 comentários em 4 níveis, que você pode usar nos seus testes.

---

### ✍️ Exercício 4: Tópico de teste

Defina as constantes `RESP-ANA`, `RESP-CAIO` e `TOPICO-TESTE`, do tipo `Comentario`, para representar o tópico abaixo. A constante `RESP-DUDA` já está pronta no template, como exemplo:

```
Bia: "Alguém já começou o Lab 5?" (2 curtidas)
├── Ana: "Já! A parte da ABP foi tranquila." (3 curtidas)
│   └── Duda: "Eu também!" (1 curtida)
└── Caio: "Ainda não, começo hoje." (0 curtidas)
```

```
RESP-DUDA = comentario("Duda", "Eu também!", 1, empty)
```

> 🛠️ **Dica:** Comece pelos comentários que não têm respostas e vá subindo até o comentário inicial. Use as constantes já definidas: as respostas da Ana são `[list: RESP-DUDA]`.

> ℹ️ Assim como a `AGENDA-TESTE`, estas constantes são usadas nos exemplos (`where:`) que o template traz para os próximos exercícios.

---

### 🔢 Exercício 5: Contando comentários

1. Implemente a função `conta-comentarios(c :: Comentario) -> Number` que, dado um comentário, devolve o número total de comentários na conversa: o próprio comentário e todas as respostas, em qualquer nível.

2. Implemente a função `conta-comentarios-lista(lr :: ListaDeRespostas) -> Number` que, dada uma lista de respostas, devolve o número total de comentários nessas respostas e nas respostas delas, em qualquer nível.

Por exemplo, `conta-comentarios(TOPICO-TESTE)` é `4` e `conta-comentarios-lista(TOPICO-TESTE.respostas)` é `3`.

> 🛠️ **Dica:** `Comentario` tem uma única variante, então `conta-comentarios` não precisa de `cases`: quem percorre a lista de respostas é `conta-comentarios-lista`. Compare com `descendente-tipo-o` e `descendente-tipo-o-lista` da Aula 22.

---

### 🖼️ Exercício 6: Desenhando um tópico

Implemente as funções `desenha-topico(c :: Comentario) -> Image` e `desenha-respostas(lr :: ListaDeRespostas) -> Image`, que desenham a conversa: cada comentário aparece em um balão e, abaixo dele, recuadas para a direita, aparecem as suas respostas (cada uma com as suas próprias respostas, recuadas mais um nível). Para `TOPICO-TESTE`, o desenho deve ter este formato:

```
[Bia: Alguém já começou o Lab 5?]
  | [Ana: Já! A parte da ABP foi tranquila.]
  |   | [Duda: Eu também!]
  | [Caio: Ainda não, começo hoje.]
```

Use as duas funções prontas que estão no template, logo no início do Exercício 6:
- `desenha-comentario(c :: Comentario) -> Image` desenha o balão de **um único** comentário, sem as respostas;
- `recua(img :: Image) -> Image` desloca uma imagem para a direita, com uma linha cinza à esquerda.

> 🛠️ **Dica:** Use `above-align("left", ...)` para empilhar as imagens alinhadas à esquerda. Em `desenha-respostas`, a lista vazia é desenhada como `empty-image`.

> 🚀 **Experimente:** Descomente `desenha-topico(TOPICO-TESTE)` e `desenha-topico(TOPICO-DUVIDA)`.

---

## chat-lib4.arr

Biblioteca de suporte (a mesma do Laboratório 4).

```pyret
file: src/data/labs/chat-lib4.arr
```
