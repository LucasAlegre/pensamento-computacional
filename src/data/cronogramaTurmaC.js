/**
 * Cronograma 2026/2 da Turma C (Prof. Lucas Nunes Alegre), exibido em /turma-c.
 *
 * Campos de cada aula:
 * - tipo: "aula" | "lab" | "prova" | "revisao" | "exame" | "ead" | "evento"
 * - slides: arquivo em public/slides/ (HTML gerado pelo Quarto a partir de src/data/slides/*.qmd)
 *   ou em public/slides-pdf/ (PDF de aulas ainda não convertidas).
 * - lab: id do laboratório em labsConfig.js (semestre 2026-2), para linkar o enunciado.
 * - referencias: seções do livro DCIC (https://dcic-world.org).
 */
export const cronogramaTurmaC = {
  semestre: "2026/2",
  turma: "C",
  professor: "Prof. Lucas Nunes Alegre",
  semanas: [
    { semana: 1, aulas: [
      { data: "qui. 06/ago.", tipo: "evento", assunto: "Recepção aos Calouros", link: "https://www.inf.ufrgs.br/site/noticia/recepcao-aos-calouros-2026-2/" },
    ] },
    { semana: 2, aulas: [
      { aula: 1, data: "ter. 11/ago.", tipo: "aula", assunto: "Introdução", local: "Sala 109 - 43425", slides: "slides-pdf/aula01-introducao.pdf" },
      { aula: 2, data: "qui. 13/ago.", tipo: "aula", assunto: "Problemas e Algoritmos", local: "Sala 109 - 43425", slides: "slides-pdf/aula02-problemas-algoritmos.pdf" },
    ] },
    { semana: 3, aulas: [
      { aula: 3, data: "ter. 18/ago.", tipo: "aula", assunto: "Expressões e Funções", local: "Sala 109 - 43425", slides: "slides-pdf/aula03-expressoes-funcoes.pdf", referencias: "Seções 3.1 e 3.2" },
      { aula: 4, data: "qui. 20/ago.", tipo: "aula", assunto: "Projeto de Algoritmos", local: "Sala 109 - 43425", slides: "slides-pdf/aula04-projeto-algoritmos.pdf", referencias: "Seções 3.3 e 8.3" },
    ] },
    { semana: 4, aulas: [
      { aula: 5, data: "ter. 25/ago.", tipo: "aula", assunto: "Expressões Condicionais", local: "Sala 109 - 43425", slides: "slides-pdf/aula05-expressoes-condicionais.pdf", referencias: "Seção 3.4" },
      { aula: 6, data: "qui. 27/ago.", tipo: "lab", assunto: "Laboratório 1", local: "Lab 105 - 43425", lab: 1 },
    ] },
    { semana: 5, aulas: [
      { aula: 7, data: "ter. 01/set.", tipo: "aula", assunto: "Recursão e Listas", local: "Sala 109 - 43425", slides: "slides-pdf/aula07-recursao-listas.pdf", atividade: "Entrega Lab 1", referencias: "Seções 5.1, 5.2 e 5.3" },
      { aula: 8, data: "qui. 03/set.", tipo: "ead", assunto: "Composição e Decomposição, Insertion Sort", local: "EAD" },
    ] },
    { semana: 6, aulas: [
      { aula: 9, data: "ter. 08/set.", tipo: "aula", assunto: "Recursão e Listas II", local: "Sala 109 - 43425", slides: "slides-pdf/aula09-recursao-listas-2.pdf", referencias: "Seções 5.1, 5.2 e 5.3" },
      { aula: 10, data: "qui. 10/set.", tipo: "lab", assunto: "Laboratório 2", local: "Lab 104 - 43413", lab: 2 },
    ] },
    { semana: 7, aulas: [
      { aula: 11, data: "ter. 15/set.", tipo: "revisao", assunto: "Revisão", local: "Sala 109 - 43425", atividade: "Entrega Lab 2" },
      { aula: 12, data: "qui. 17/set.", tipo: "prova", assunto: "Prova 1", local: "Aud. Inferior - 43413", atividade: "Data Limite Q1 e Q2" },
    ] },
    { semana: 8, aulas: [
      { aula: 13, data: "ter. 22/set.", tipo: "aula", assunto: "Dados Estruturados", local: "Sala 109 - 43425", slides: "slides-pdf/aula13-dados-estruturados.pdf", referencias: "Seção 6.1.1" },
      { aula: 14, data: "qui. 24/set.", tipo: "aula", assunto: "Dados Estruturados II - Dados Condicionais", local: "Sala 109 - 43425", slides: "slides-pdf/aula14-dados-condicionais.pdf", referencias: "Seções 6.1.2, 6.1.3 e 6.2.1" },
    ] },
    { semana: 9, aulas: [
      { aula: 15, data: "ter. 29/set.", tipo: "lab", assunto: "Laboratório 3", local: "Lab 104 - 43413", lab: 3 },
      { aula: 16, data: "qui. 01/out.", tipo: "aula", assunto: "Funções de Alta-Ordem", local: "Sala 109 - 43425", slides: "slides-pdf/aula16-alta-ordem.pdf", atividade: "Entrega Lab 3", referencias: "Seções 8.1, 4.1.6, 5.1.4, 5.1.5 e 5.1.6" },
    ] },
    { semana: 10, aulas: [
      { aula: 17, data: "ter. 06/out.", tipo: "aula", assunto: "Funções de Alta-Ordem II", local: "Sala 109 - 43425", slides: "slides/aula17-alta-ordem2.html", referencias: "Seções 8.1, 4.1.6, 5.1.4, 5.1.5 e 5.1.6" },
      { aula: 18, data: "qui. 08/out.", tipo: "lab", assunto: "Laboratório 4", local: "Lab 104 - 43413", lab: 4 },
    ] },
    { semana: 11, aulas: [
      { aula: 19, data: "ter. 13/out.", tipo: "revisao", assunto: "Revisão", atividade: "Entrega Lab 4" },
      { aula: 20, data: "qui. 15/out.", tipo: "prova", assunto: "Prova 2", local: "Aud. Inferior - 43413", atividade: "Data Limite Q3 e Q4" },
    ] },
    { semana: 12, aulas: [
      { data: "seg. 19/out. a sáb. 24/out.", tipo: "evento", assunto: "Semana Acadêmica" },
    ] },
    { semana: 13, aulas: [
      { aula: 21, data: "ter. 27/out.", tipo: "aula", assunto: "Árvores Binárias e de Pesquisa", local: "Sala 109 - 43425", slides: "slides/aula21-arvores-binarias.html", referencias: "Seção 7" },
      { aula: 22, data: "qui. 29/out.", tipo: "aula", assunto: "Recursão Mútua e Árvores N-árias", local: "Sala 109 - 43425", slides: "slides/aula22-recursao-mutua.html", referencias: "Seção 16" },
    ] },
    { semana: 14, aulas: [
      { aula: 23, data: "ter. 03/nov.", tipo: "lab", assunto: "Laboratório 5", local: "Lab 104 - 43413", lab: 5 },
      { aula: 24, data: "qui. 05/nov.", tipo: "aula", assunto: "Grafos", local: "Sala 109 - 43425", slides: "slides/aula24-grafos.html", referencias: "Seção 17" },
    ] },
    { semana: 15, aulas: [
      { aula: 25, data: "ter. 10/nov.", tipo: "aula", assunto: "Recursão Generativa, Terminação e Animações", local: "Sala 109 - 43425", slides: "slides/aula25-recursao-generativa.html", referencias: "Animações - Seção 27" },
      { aula: 26, data: "qui. 12/nov.", tipo: "ead", assunto: "Transformação e Reuso", local: "EAD" },
    ] },
    { semana: 16, aulas: [
      { aula: 27, data: "ter. 17/nov.", tipo: "aula", assunto: "Computabilidade e Complexidade Computacional", local: "Sala 109 - 43425", slides: "slides/aula27-computabilidade-complexidade.html", referencias: "Seções 14 e 15" },
      { aula: 28, data: "qui. 19/nov.", tipo: "lab", assunto: "Laboratório 6", local: "Lab 104 - 43413", lab: 6 },
    ] },
    { semana: 17, aulas: [
      { aula: 29, data: "ter. 24/nov.", tipo: "revisao", assunto: "Revisão", local: "Sala 109 - 43425" },
      { aula: 30, data: "qui. 26/nov.", tipo: "prova", assunto: "Prova 3", local: "Aud. Superior - 43413" },
    ] },
    { semana: null, aulas: [
      { data: "ter. 08/dez.", tipo: "exame", assunto: "Exame", local: "Sala 109 - 43425" },
    ] },
  ],
};
