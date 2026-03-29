# Tópico: Expressões Aritméticas

## Exercício: Expressões Matemáticas
**ID:** Expressões Aritméticas-1
**Dificuldade:** Fácil

Crie programas em Pyret para resolver as seguintes expressões:

a) $\frac{x+2}{2}-2x$

b) $144-x^{2}+x$

c) $\sqrt{x}-2x+12$

d) $x^{3}-\frac{x}{4}+x^{-1}$

e) $2\cdot\sqrt{x+5}-26$

f) $x\cdot(x+3)-4$

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Cálculo da Hipotenusa
**ID:** Expressões Aritméticas-2
**Dificuldade:** Fácil

Faça um programa que, dados os valores para os catetos de um triângulo retângulo, calcule o valor da hipotenusa. A hipotenusa é calculada pelo Teorema de Pitágoras que é dado pela expressão $a^{2}=b^{2}+c^{2}$, onde $b$ e $c$ são os catetos e $a$ a hipotenusa.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Cálculo de Cateto
**ID:** Expressões Aritméticas-3
**Dificuldade:** Fácil

Modifique o programa anterior para que calcule o valor de um dos catetos. Para isso, a função deverá receber os valores do cateto conhecido e da hipotenusa.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Conversão Fahrenheit para Celsius
**ID:** Expressões Aritméticas-4
**Dificuldade:** Fácil

Escreva um programa em Pyret para a conversão de temperatura ($^\circ$F para $^\circ$C). A expressão que calcula o valor correspondente em $^\circ$C é $C=\frac{F-32}{1,8}$.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Conversão Celsius para Fahrenheit
**ID:** Expressões Aritméticas-5
**Dificuldade:** Fácil

Similar ao exercício anterior, escreva um programa que, dado um valor de temperatura em $^\circ$C, calcule seu valor correspondente em $^\circ$F. Determine o ponto de ebulição da água em $^\circ$F (considere o ponto de ebulição da água como $100^\circ$C).

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Área de Trapézio
**ID:** Expressões Aritméticas-6
**Dificuldade:** Médio

Escreva um programa em Pyret para o cálculo da área de um trapézio. Para isso, o programa deverá utilizar as variáveis base maior (B), base menor (b) e altura (h). A área de um trapézio pode ser calculada pela fórmula $A_{t}=\frac{(B+b)\cdot h}{2}$.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Raio e Circunferência
**ID:** Expressões Aritméticas-7
**Dificuldade:** Médio

Escreva uma função em Pyret que faça uso de uma variável única, composta pelo raio de uma circunferência. A função deverá retornar a soma do comprimento circunferência com sua área $(C=2\cdot r\cdot\pi \text{ e } A=\pi\cdot r^{2})$.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Volume de Cilindro
**ID:** Expressões Aritméticas-8
**Dificuldade:** Médio

Crie um programa para o cálculo do volume de um cilindro. Execute a função criada com distintos valores de raio $r\in\{1.5,2,5\}$ e altura $h\in\{12,20,32\}$.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Salário Líquido
**ID:** Expressões Aritméticas-9
**Dificuldade:** Médio

O salário líquido de uma empresa é calculado descontando do salário bruto uma determinada porcentagem referente ao imposto cobrado dos trabalhadores. O salário bruto, por sua vez, consiste na multiplicação da quantidade de horas trabalhadas pelo valor pago pela hora. Crie um programa em Pyret que compute o valor do salário líquido. Teste o programa criado para uma quantidade total de 110 horas a um valor de \$ 15.50 a hora trabalhada e 11\% de imposto.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Desconto em Loja
**ID:** Expressões Aritméticas-10
**Dificuldade:** Difícil

Uma loja de artigos variados possui uma política de cálculo para o valor a ser cobrado dos seus clientes na compra de suas mercadorias. O valor a ser pago pelo cliente é composto pelo valor unitário da mercadoria multiplicado pela quantidade a ser comprada. Usualmente, a loja oferece um desconto que é subtraído do valor a ser pago no ato da venda. O valor unitário de cada mercadoria é obtido somando o custo do bem com um valor de lucro, determinado por uma porcentagem. O desconto também é determinado por uma porcentagem que é aplicada sobre o valor total no ato da venda. Crie um programa para computar o valor final a ser pago pelo cliente em uma compra. Após criado o programa, determine qual a porcentagem máxima (considerar somente múltiplos de 5) de desconto para que o vendedor não tenha prejuízo em uma venda de 12 unidades de um artigo com custo \$ 8.40 com 33\% de lucro.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Juros Simples
**ID:** Expressões Aritméticas-11
**Dificuldade:** Difícil

Crie funções para conversão de meses em anos e vice-versa (**mes2ano** e **ano2mes**). Crie também funções para conversão de taxas de juros mensais para taxas anuais e vice-versa (**mensal2anual** e **anual2mensal**). Utilize estas funções para resolver os problemas a seguir.
    
1) Um indivíduo investiu \$ 35.000,00 em uma aplicação durante 1 semestre à taxa de juros simples de 18,68\% a.a. Em quanto o capital foi aumentado ao final do período?

2) Em um período total de 2,5 anos, um capital de \$ 12.200,00 foi aplicado à uma taxa de juros de 7,2\% a.m. Determine o montante ao final do período.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Velocidade Média
**ID:** Expressões Aritméticas-12
**Dificuldade:** Difícil

Crie um programa que determine a velocidade média de um veículo. Para isso, o usuário deverá fornecer os valores para as variáveis posição inicial e final (em quilômetros) e tempo inicial e final (em horas). A velocidade média pode ser calculada pela expressão $V=\frac{\Delta s}{\Delta t}$.

Após, modifique o programa feito para determinar a posição final de um veículo com base nas demais variáveis.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Área do Triângulo
**ID:** Expressões Aritméticas-0
**Dificuldade:** Resolvido

Crie um programa em Pyret que calcule a área de um triângulo dados sua base e altura. A fórmula da área é $A = \frac{base \cdot altura}{2}$.

### Testes
```pyret height=500
use context starter2024

fun area-triangulo(base :: Number, altura :: Number) -> Number:
  doc: "Calcula a área de um triângulo dada sua base e altura"
  (base * altura) / 2
where:
  area-triangulo(6, 4) is 12
  area-triangulo(10, 5) is 25
  area-triangulo(3, 8) is 12
end
```

# Tópico: Projeto de Algoritmos e Expressões Condicionais

## Exercício: Divisão ou Multiplicação
**ID:** Projeto de Algoritmos e Expressões Condicionais-1
**Dificuldade:** Fácil

Escreva uma função em Pyret que consome uma variável numérica. Caso o número informado seja maior que 100, ele deve ser dividido por 5, caso contrário deve ser multiplicado por 3.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Par ou Ímpar
**ID:** Projeto de Algoritmos e Expressões Condicionais-2
**Dificuldade:** Fácil

Crie um programa que, dado um número inteiro qualquer, verifique se o mesmo é par ou ímpar. No caso de ser par, o mesmo de ser dividido por 2. Caso o mesmo seja ímpar, deve ser somado a 1 e posteriormente dividido por 2. Considere utilizar a função `num-modulo(n, 2)` para verificar se um número é par ou ímpar.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Álcool ou Gasolina
**ID:** Projeto de Algoritmos e Expressões Condicionais-3
**Dificuldade:** Fácil

Um proprietário de automóvel gostaria de saber se é mais viável abastecer seu veículo com álcool ou gasolina. Ele sabe que para ser vantajoso abastecer no álcool, o preço do litro do álcool tem que custar até 70\% (inclusive) do preço do litro da gasolina. Faça um programa que consuma o preço do litro do álcool e da gasolina e informe qual é combustível mais viável financeiramente.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Calculadora Básica
**ID:** Projeto de Algoritmos e Expressões Condicionais-4
**Dificuldade:** Fácil

Desenvolva uma calculadora em Pyret para realizar as quatro operações básicas da matemática. Este programa consome uma string e dois números. A string representa o tipo da operação, e tem com possíveis valores: "adicao", "subtracao", "multiplicacao" e "divisao". De acordo com a string passada, o programa deve realizar a devida operação matemática entre os dois números. Na operação de divisão, o programa deve validar para que não ocorra divisão por zero.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Faixa Etária
**ID:** Projeto de Algoritmos e Expressões Condicionais-5
**Dificuldade:** Fácil

Escreva uma função que determine a fase da vida de um indivíduo. A função deverá consumir uma variável numérica correspondente à idade e informar a faixa na qual o indivíduo se encontra. Até 12 anos a pessoa se encontra no estágio infantil, após isso a pessoa está na juventude até os 28 anos, vida adulta até os 65 anos e terceira idade com mais de 65 anos de idade.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Situação Aluno (Média Simples e Ponderada)
**ID:** Projeto de Algoritmos e Expressões Condicionais-6
**Dificuldade:** Médio

Escreva um programa para auxílio no fechamento das médias de uma turma de alunos. Para isso, uma função deverá consumir as quatro notas do aluno, calculando sua média aritmética simples. O programa ainda deverá determinar se a situação final do aluno (reprovado se a nota for menor que 5, em exame para nota entre 5 e 7 e aprovado para nota maior ou igual a 7). Para informar a situação do aluno, retorne uma string.

Após, modifique o programa anterior para uma média ponderada. A maior nota entre as quatro notas deverá possuir um peso $4/10$, enquanto as demais possuirão peso $2/10$.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Cálculo de IMC
**ID:** Projeto de Algoritmos e Expressões Condicionais-8
**Dificuldade:** Médio

Crie um programa para cálculo do IMC (Índice de Massa Corporal). Este cálculo é determinado pela expressão $IMC=\frac{peso}{altura^{2}}$. A situação do indivíduo deve ser informada ao usuário de acordo com a tabela abaixo.

| Resultado         | Situação        |
| ----------------- | --------------- |
| Abaixo de 18      | Abaixo do peso  |
| Entre 18 e 24.99  | Peso normal     |
| Entre 25 e 29.99  | Acima do peso   |
| Acima de 30       | Obesidade       |


### Testes
```pyret height=500
use context starter2024
```

## Exercício: Multa de Velocidade
**ID:** Projeto de Algoritmos e Expressões Condicionais-9
**Dificuldade:** Médio

Crie um programa que calcule o valor de multa para um sensor de velocidade. O valor base de uma multa é estipulado em \$ 120,00. Caso o infrator ultrapassou a velocidade máxima em até $15km/h$, a multa é calculada como 88\% do valor base. Se a infração foi de $15km/h$ a $25km/h$ superior à velocidade máxima, a multa é igual a 116\% do valor base. Para um excedente entre $25km/h$ e $40km/h$, a multa é igual a 180\% do valor base. Para excedentes superiores a $40km/h$, o valor final é igual a 250\% do valor base. Dada a velocidade máxima da via e a velocidade inferida pelo sensor, informe o valor da multa (para velocidades dentro do permitido, o valor da multa é \$ 0,00).

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Salto em Altura
**ID:** Projeto de Algoritmos e Expressões Condicionais-10
**Dificuldade:** Médio

Em uma competição de salto em altura, a pontuação do atleta é determinada por meio de uma expressão baseada na altura computada e no peso corporal ($Pont = \text{altura} \cdot \text{peso}$), onde a altura varia entre 1 e 2 metros e o peso entre 50 e 90kg. Escreva um programa que faça a leitura da altura computada e do peso de dois atletas (A e B) e determine qual deles é o vencedor.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Concessão de Crédito
**ID:** Projeto de Algoritmos e Expressões Condicionais-11
**Dificuldade:** Médio

Uma companhia de crediário mantém um nível de confiança sobre cada um dos seus clientes, a fim de auxiliar na concessão ou negação de crédito. Este nível varia de acordo com o tempo em que o indivíduo é cliente e sua renda mensal. O nível é determinado de acordo com a tabela a seguir.

| Tempo | Renda mensal | Nível |
|---|---|---|
| Até 1 ano | Menor que \$ 1200,00 | 1 |
| Até 1 ano | Maior ou igual a \$ 1200,00 e menor que \$ 2300,00 | 2 |
| Até 1 ano | Maior ou igual a \$ 2300,00 | 3 |
| Mais que 1 ano | Menor que \$ 1200,00 | 2 |
| Mais que 1 ano | Maior ou igual a \$ 1200,00 e menor que \$ 2300,00 | 3 |
| Mais que 1 ano | Maior ou igual a \$ 2300,00 | 3 |

Empréstimos para clientes com nível 1 não são concedidos. Clientes com nível dois são analisados por especialistas. Todos os empréstimos com nível 3 são concedidos. Escreva um programa que, dado o tempo em que o indivíduo é cliente e sua renda, determine a situação da concessão de crédito (negado, em análise ou aprovado).

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Seguro de Veículo
**ID:** Projeto de Algoritmos e Expressões Condicionais-12
**Dificuldade:** Médio

Crie um programa que calcule o valor do seguro de um veículo. Caso o ano do mesmo seja anterior a 2000, o valor base do seguro é \$ 2000,00. Para veículos mais novos, o valor base cai para \$ 1200,00. Caso o proprietário tenha menos de 25 anos de idade, é acrescido \$ 800,00 no valor do seguro. Caso o veículo seja utilizado para trabalho, é acrescido um valor de \$ 650,00. O programa deverá fazer uso das variáveis necessárias e determinar o valor final do seguro.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Conceito de Aluno
**ID:** Projeto de Algoritmos e Expressões Condicionais-13
**Dificuldade:** Médio

Na disciplina de fundamentos de algoritmos, os alunos são avaliados por suas notas obtidas nas três atividades da disciplina: prova $1 (p_{1})$, prova $2 (p_{2})$ e listas de exercícios (E). A média final (M) de cada aluno é calculada através da média aritmética ponderada de suas notas obtidas nessas três atividades, sendo que as atividades valem $p_{1}=40\%$, $p_{2}=50\%$ e $E=10\%$ da média final. Para que o conceito de um aluno seja estimado, o professor precisa ainda avaliar se o aluno possui a frequência (F) mínima de participação nas aulas. A conversão da média final e frequência para o conceito é realizada da seguinte forma:
    
-  FF: $F < 75\%$;
-  D: $0 \leq M < 6.0$;
-  C: $6.0 \leq M < 7.5$;
-  B: $7.5 \leq M < 9.0$;
-  A: $9.0 \leq M$;
    
Para auxiliar o professor nesta tarefa, faça um programa em Pyret que consuma as notas de $p_{1}$, $p_{2}$, E e F e calcule o conceito do aluno. Considere o intervalo [0, 10] para cada uma das notas e [0, 100] para a frequência.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Aprovação de Aluno
**ID:** Projeto de Algoritmos e Expressões Condicionais-14
**Dificuldade:** Médio

Agora que o professor possui um programa para calcular o conceito dos alunos, ele precisa verificar se os alunos foram aprovados ou reprovados na disciplina. Para que um aluno seja aprovado ele precisa ter conceito A, B ou C, caso contrário o aluno é reprovado. O programa deve consumir a saída obtida pelo programa do exercício anterior e informar se o aluno está aprovado ou reprovado. No caso de ter sido reprovado, o sistema deve ainda informar o motivo da reprovação (nota ou frequência).

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Anualidade de Seguro
**ID:** Projeto de Algoritmos e Expressões Condicionais-15
**Dificuldade:** Médio

Uma seguradora de veículos precisa de um programa de computador para facilitar o cálculo do valor da anualidade dos seguros. O valor da anualidade de um seguro é calculado com base no valor do veículo, ano de modelo e idade do condutor. O valor da anuidade do seguro de qualquer veículo se inicia com um valor base de \$ 500,00. Este valor é incrementado de acordo com as características do veículo e condutor. Inicialmente, a seguradora incrementa o valor base em função das características do veículo:
    
-  Para veículos com modelo inferior a 1995, adiciona-se 20\% do valor do veículo ao valor base.
-  Para veículos entre 1995 e 2008, o valor adicionado é de 10\% do valor do veículo.
-  Para veículos acima de 2008, o valor a ser incrementado no valor base é de 4\% do valor do veículo.
    
A partir deste novo valor obtido a seguradora insere uma taxa de risco, variável em função do perfil do condutor. A seguradora incrementa este valor em 20\% para os casos onde o condutor possui menos de 25 anos. Para os condutores com idade entre 25 e 50 anos, o valor do seguro não é incrementado. Já os condutores acima de 50 anos recebem um desconto de 10\% sobre o valor total do seguro. Desenvolva um programa que compute o valor da anualidade.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Formação de Triângulo
**ID:** Projeto de Algoritmos e Expressões Condicionais-16
**Dificuldade:** Difícil

Escreva um programa no Pyret que receba os valores de medida de três segmentos de reta. O programa deverá determinar se estas retas podem formar um triângulo. Para formar um triângulo, nenhuma de suas arestas pode ser maior que a soma das outras duas.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Desconto de Transporte
**ID:** Projeto de Algoritmos e Expressões Condicionais-17
**Dificuldade:** Difícil

Uma empresa cobra de seus funcionários uma taxa mensal referente ao traslado de suas residências até o local de trabalho. A taxa é descontada do salário conforme a distância entre a empresa e a residência do funcionário e proporcional ao valor de seu salário conforme a tabela:

| Valor do salário | Distância | Valor do desconto |
|---|---|---|
| Até \$ 2000,00 | Menor que 5km | \$ 80,00 |
| Até \$ 2000,00 | Maior ou igual a 5km e menor que 10km | \$ 120,00 |
| Até \$ 2000,00 | Maior ou igual a 10km | \$ 200,00 |
| Mais que \$ 2000,00 | Menor que 5km | \$ 110,00 |
| Mais que \$ 2000,00 | Maior ou igual a 5km e menor que 10km | \$ 160,00 |
| Mais que \$ 2000,00 | Maior ou igual a 10km | \$ 240,00 |

Crie um programa que compute o salário final do funcionário com base no valor do salário e na distância.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Pessoa Mais Velha
**ID:** Projeto de Algoritmos e Expressões Condicionais-18
**Dificuldade:** Médio

Escreva uma função que receba os nomes de duas pessoas. Além disso, a função deve consumir o ano, mês e dia de nascimento de ambos. A função deverá retornar o nome da pessoa mais velha.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Viagem e Combustível
**ID:** Projeto de Algoritmos e Expressões Condicionais-19
**Dificuldade:** Resolvido

Considere um motorista que precisa entregar mercadorias em três cidades distintas. A ordem das cidades é determinada antecipadamente. Antes de iniciar sua viagem, o motorista precisa se certificar de que possui combustível suficiente para realizar o percurso. Escreva um programa que, dadas as distâncias a serem percorridas para chegar a cada cidade, o consumo do veículo (em quilômetros por litro de combustível) e a quantidade de combustível disponível, informe quais cidades podem ser visitadas. A saída deverá ser informada ao usuário mediante as strings "Cidade 1", "Cidades 1 e 2" e "Todas as Cidades".

### Testes
```pyret height=500
use context starter2024

fun combustivel-necessario(distancia :: Number, consumo :: Number) -> Number:
  doc: "Dado a distância a ser percorrida e o consumo do veículo (em quilômetros por litro de combustível), calcula a quantidade de combustivel necessário para realizar o percurso."

  distancia / consumo
where:
  combustivel-necessario(100, 10) is 10
  combustivel-necessario(100, 20) is 5
  combustivel-necessario(100, 5) is 20
end

fun cidades-possiveis(dist1 :: Number, dist2 :: Number, dist3 :: Number, consumo :: Number, combustivel :: Number) -> String:
  doc: "Dadas as distâncias a serem percorridas para chegar a cada cidade, o consumo do veículo (em quilômetros por litro de combustível) e a quantidade de combustível disponível, informe quais cidades podem ser visitadas. A saída deverá ser informada ao usuário mediante as strings \"Cidade 1\", \"Cidades 1 e 2\" e \"Todas as Cidades\"."
  
  ask:
    | combustivel-necessario(dist1, consumo) > combustivel then: "Nenhuma cidade"
    | combustivel-necessario(dist1 + dist2, consumo) > combustivel then: "Cidade 1"
    | combustivel-necessario(dist1 + dist2 + dist3, consumo) > combustivel then: "Cidades 1 e 2"
    | otherwise: "Todas as Cidades"
  end

where:
  cidades-possiveis(100, 100, 100, 10, 10) is "Cidade 1"
  cidades-possiveis(100, 100, 100, 10, 20) is "Cidades 1 e 2"
  cidades-possiveis(100, 100, 100, 10, 30) is "Todas as Cidades"
end
```

## Exercício: Positivo, Negativo ou Zero
**ID:** Projeto de Algoritmos e Expressões Condicionais-0
**Dificuldade:** Resolvido

Escreva uma função em Pyret que receba um número e retorne a string `"positivo"`, `"negativo"` ou `"zero"` conforme o valor recebido.

### Testes
```pyret height=500
use context starter2024

fun classifica-numero(n :: Number) -> String:
  doc: "Retorna 'positivo', 'negativo' ou 'zero' dependendo do valor de n"
  if n > 0:
    "positivo"
  else if n < 0:
    "negativo"
  else:
    "zero"
  end
where:
  classifica-numero(10)  is "positivo"
  classifica-numero(-5)  is "negativo"
  classifica-numero(0)   is "zero"
end
```

# Tópico: Tabelas

## Exercício: Doces com muito açúcar (Parte 1)
**ID:** Tabelas-1
**Dificuldade:** Fácil

Vamos usar o poder das tabelas para extrair informações do nosso conjunto de dados sobre doces (já carregado no bloco de código abaixo na variável `candy-data`).

Use o código `candy-row = candy-data.row-n(0)` para obter a primeira linha de `candy-data`. Escreva uma função que calcule se a porcentagem de açúcar (`"sugar-percent"`) em uma linha é maior que 0.75.

### Testes
```pyret height=500
use context dcic2024

include gdrive-sheets

# spreadsheet id from Google Sheets
ssid = "1XzeWZToT-lqPFVpp-RZLimdoGdGaTcVQZ_8VbDbAkOc"
data-sheet = load-spreadsheet(ssid)
candy-data = 
  load-table: name, chocolate, fruity, caramel, nutty, nougat, crisped-rice, 
    hard, bar, pluribus, sugar-percent, price-percent, win-percent
    source: data-sheet.sheet-by-name("candy-data", true)
  end

first-row = candy-data.row-n(0)
fourth-row = candy-data.row-n(4)

fun is-sugar-rich(r :: Row) -> Boolean:
  doc: "Dado uma linha da tabela, verifica se a porcentagem de açúcar é maior que 0.75"
  # Complete aqui
where:
    is-sugar-rich(first-row) is false
    is-sugar-rich(fourth-row) is true    
end
```

## Exercício: Doces com muito açúcar (Parte 2)
**ID:** Tabelas-2
**Dificuldade:** Médio

Queremos saber quais doces têm mais açúcar. Escreva uma função que produza uma nova tabela contendo apenas os doces onde `"sugar-percent"` é maior que 0.75. Use a função `filter-with` e se beneficie da função implementada na parte 1.

### Testes
```pyret height=500
use context dcic2024

include gdrive-sheets

# spreadsheet id from Google Sheets
ssid = "1XzeWZToT-lqPFVpp-RZLimdoGdGaTcVQZ_8VbDbAkOc"
data-sheet = load-spreadsheet(ssid)
candy-data = 
  load-table: name, chocolate, fruity, caramel, nutty, nougat, crisped-rice, 
    hard, bar, pluribus, sugar-percent, price-percent, win-percent
    source: data-sheet.sheet-by-name("candy-data", true)
  end

fun is-sugar-rich(r :: Row) -> Boolean:
  doc: "Dado uma linha da tabela, verifica se a porcentagem de açúcar é maior que 0.75"
  # Copie de sua implementação do exercício anterior
end

fun filter-sugar-rich(table :: Table) -> Table:
    doc: "Dado uma tabela de doces, filtra os doces com porcentagem de açúcar maior que 0.75"
    # Complete aqui
end
```

## Exercício: Doces com chocolate
**ID:** Tabelas-3
**Dificuldade:** Médio

Quantos dos doces possuem chocolate? Escreva uma função que filtre os doces com o valor da coluna `"chocolate"` igual a `true` e depois descubra a quantidade total de linhas restantes utilizando a função `.length()`.

### Testes
```pyret height=500
use context dcic2024

include gdrive-sheets

# spreadsheet id from Google Sheets
ssid = "1XzeWZToT-lqPFVpp-RZLimdoGdGaTcVQZ_8VbDbAkOc"
data-sheet = load-spreadsheet(ssid)
candy-data = 
  load-table: name, chocolate, fruity, caramel, nutty, nougat, crisped-rice, 
    hard, bar, pluribus, sugar-percent, price-percent, win-percent
    source: data-sheet.sheet-by-name("candy-data", true)
  end

first-row = candy-data.row-n(0)
fourth-row = candy-data.row-n(4)

fun is-chocolate(r :: Row) -> Boolean:
    doc: "Dado uma linha da tabela, verifica se o doce possui chocolate"
    # Complete aqui
where:
    is-chocolate(first-row) is true
    is-chocolate(fourth-row) is false
end

fun count-chocolate(table :: Table) -> Number:
    # Complete aqui
where:
    count-chocolate(candy-data) is 37
end
```

# Tópico: Listas

## Exercício: Tamanho de uma lista
**ID:** Listas-1
**Dificuldade:** Fácil

Construa uma constante contendo uma lista de strings com os nomes das linguagens de programação C, C++, C#, Java, Javascript, PHP, Ruby, Perl, R, Matlab, DrRacket e Python. Considere a criação da lista usando `link` e `empty`.

Construa uma função que receba uma lista de strings e retorne a quantidade de elementos da lista.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Salários
**ID:** Listas-3
**Dificuldade:** Médio

Desenvolva um programa que consuma uma lista de salários e verifique se todos
os salários são superiores ao salário mínimo (também dado de entrada para o programa).

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Inteiros zero até n
**ID:** Listas-4
**Dificuldade:** Fácil

Desenvolva a função `inteiros-n-ate-zero :: (n :: Number) -> List<Number>` que receba um número n e retorne uma lista com os inteiros de n até zero.

## Exercício: Inteiros até n
**ID:** Listas-5
**Dificuldade:** Médio

Desenvolva a função `inteiros-ate-n :: (n :: Number) -> List<Number>` que receba um número n e retorne uma lista com os inteiros de 0 até n.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Matriculado?
**ID:** Listas-6
**Dificuldade:** Fácil

Uma lista de chamadas é composta pelos nomes dos alunos de determinada turma.
Escreva uma função que, dada uma lista de chamadas e o nome de um indivíduo, verifique se o mesmo está matriculado na turma em questão.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Acessando n-ésimo elemento
**ID:** Listas-7
**Dificuldade:** Difícil

Desenvolva a função `my-get<A> :: (lst :: List<A>, n :: Number) -> A` que receba uma lista e um número n e retorne o n-ésimo elemento da lista.

### Testes
```pyret height=500
use context starter2024

fun my-get<A>(lst :: List<A>, n :: Number) -> A:
  doc: "Retorna o n-ésimo elemento de uma lista, ou lança um erro se n estiver fora do intervalo"
  cases (List) lst:
    | empty => # Complete aqui
    | link(f, r) => # Complete aqui
  end
where:
  my-get([list: 1, 2, 3], 0) is 1
  my-get([list: 1, 2, 3], 2) is 3
  my-get([list: 1, 2], 2) raises "n muito grande"
  my-get(empty, 0) raises "n muito grande"
  my-get([list: 1, 2, 3], -1) raises "argumento invalido"

  # Compare com o Pyret .get()
  my-get([list: 1, 2, 3], 2) is [list:1, 2, 3].get(2)
end
```

## Exercício: Lista de múltiplos tipos
**ID:** Listas-8
**Dificuldade:** Difícil

Considere a lista `lst = link(1, link("dois", link("três", link(4, link(6, empty)))))`, e faça o que é pedido a seguir:

(a) Desenvolva uma função para contar a quantidade de elementos na lista.
(b) Desenvolva uma função para computar a quantidade de elementos do tipo String
na lista.
(c) Desenvolva uma função para computar o somatório dos elementos do tipo Number
da lista.
(d) Desenvolva uma função que retorne uma nova lista sem elementos do tipo Number.

### Testes
```pyret height=500
use context starter2024

lst :: List<Any> = link(1, link("dois", link("três", link(4, link(6, empty)))))
```

## Exercício: Soma de uma lista
**ID:** Listas-9
**Dificuldade:** Resolvido

Desenvolva a função `soma-lista :: (lst :: List<Number>) -> Number` que receba uma lista de números e retorne a soma de todos os elementos em posições pares (contando a partir de 0), i.e., o primeiro elemento da lista, o terceiro, o quinto, etc.

### Testes
```pyret height=500
use context starter2024

fun soma-lista(lst :: List<Number>, ind-par :: Boolean) -> Number:
  doc: "Retorna a soma de todos os elementos de uma lista de números"
  cases (List) lst:
    | empty => 0
    | link(primeiro, resto) => 
        if ind-par:
          primeiro + soma-lista(resto, false)
        else:
          soma-lista(resto, true)
        end
  end
where:
  soma-lista([list: 1, 2, 3, 4, 5], true) is 9
  soma-lista([list: 10, -3, 7], true)     is 17
  soma-lista(empty, true)                 is 0
end
```

# Tópico: Dados Estruturados e Dados Condicionais

## Exercício: Estrutura Aluno Pós
**ID:** Dados Estruturados e Dados Condicionais-1
**Dificuldade:** Médio

Apresente as definições necessárias para representar a estrutura de um aluno de pós graduação. O aluno possui quatro informações principais: número de matrícula, nome do curso que está cursando, instituição de ensino, e curso de graduação cursado. Uma instituição de ensino é composta pelo seu nome e ano de fundação. Já o curso de graduação, por sua vez, possui um nome do curso e instituição de ensino.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Instâncias de Aluno Pós
**ID:** Dados Estruturados e Dados Condicionais-2
**Dificuldade:** Médio

Considere as estruturas do exercício anterior e apresente as expressões necessárias para representar os alunos de pós graduação: Marcelo, Fernando e Gabriel. O Marcelo (matrícula 00237755) cursa Doutorado em Computação na UFRGS (fundada em 1934), e é formado em Ciência da Computação na UFRGS. O Fernando (matrícula 00236578), cursa Mestrado em Computação na UFRGS, e é formado em Sistemas de Informação pela UFSM (fundada em 1960). Já o Gabriel (matrícula 512010987), cursa Mestrado em Informática na UFSM, e possui graduação Engenharia de Software pela UDESC (fundada em 1965). Considere a reutilização das estruturas geradas para as instituições de ensino.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Mesma Instituição
**ID:** Dados Estruturados e Dados Condicionais-3
**Dificuldade:** Médio

Desenvolva uma função que consuma um elemento do tipo AlunoPos, e retorne verdadeiro caso o aluno esteja cursando a pós graduação na mesma instituição de ensino em que cursou a graduação. Teste o programa nas estruturas do exercício anterior.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Locadora de Veículos
**ID:** Dados Estruturados e Dados Condicionais-4
**Dificuldade:** Médio

Uma locadora de veículos precisa de um programa para calcular o valor da diária de locação de seus veículos. A empresa dispõe de dois tipos de veículos: carros e motos. Ambos os tipos de veículos possuem os atributos em comum: ano, modelo (descrição) e valor de mercado. Os carros ainda podem possuir alguns atributos adicionais, como: ar condicionado, direção hidráulica e vidros elétricos. O valor base cobrado pela diária
é de 0.25\% do valor de mercado do veículo. Os carros ainda possuem um acréscimo de R\$ 30.00 por opcional. Já as motos, possuem apenas uma taxa fixa de seguro, no valor de R\$ 70.00, que deve ser acrecida no valor base da diária. Com base nessa descrição, faça o que é pedido:

-  Define a estrutura Veículo, com suas variantes carro e moto.
-  Crie pelo menos 3 exemplos para cada uma das estruturas definidas.
-  Crie a função calcula-diária para efetuar o cálculo da diária de locação.
-  Teste a função calcula-diária nos exemplos anteriormente desenvolvidos.

### Testes
```pyret height=500
use context starter2024
```

## Exercício: Estrutura Ponto 2D (Resolvido)
**ID:** Dados Estruturados e Dados Condicionais-0
**Dificuldade:** Resolvido

Defina uma estrutura `Ponto` que representa um ponto no plano cartesiano bidimensional com coordenadas `x` e `y`. Em seguida, escreva a função `distancia` que, dados dois pontos, calcula a distância euclidiana entre eles. A fórmula é $d = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}$.

### Testes
```pyret height=500
use context starter2024

data Ponto:
  # Estrutura para representar um ponto 2D
  | ponto(x :: Number, y :: Number)
  # x é a coordenada no eixo-x e y é a coordenada no eixo-y
end

fun distancia(p1 :: Ponto, p2 :: Ponto) -> Number:
  doc: "Calcula a distância euclidiana entre dois pontos no plano"
  num-sqrt(num-expt(p2.x - p1.x, 2) + num-expt(p2.y - p1.y, 2))
where:
  distancia(ponto(0, 0), ponto(3, 4)) is 5
  distancia(ponto(1, 1), ponto(4, 5)) is 5
  distancia(ponto(0, 0), ponto(0, 0)) is 0
end
```
