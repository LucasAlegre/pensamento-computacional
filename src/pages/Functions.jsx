import React from 'react';
import PyretEmbed from '../components/PyretEmbed';

const Functions = () => {
    return (
        <div className="page-content">
            <h1>Funções</h1>
            <p>Funções realizam uma tarefa específica e podem ser reutilizadas.</p>

            <div className="section">
                <h2>Definindo Funções</h2>
                <p>Em Pyret, usamos a palavra-chave <code>fun</code> para definir uma função.</p>
                <PyretEmbed code={`fun square(n):
  n * n
end

square(10)`} />
            </div>

            <div className="section">
                <h2>Como Planejar e Escrever uma Função</h2>
                <p>Em Pyret, nós seguimos **quatro passos fundamentais** na hora de criar uma nova função para garantir que o código seja legível, livre de bugs e reusável por qualquer outra pessoa.</p>
                <ol>
                    <li>
                        <strong>Contrato (Assinatura):</strong> A primeira parte de toda função! Serve para definirmos o nome exato da função, quais são os tipos de dados que vão <em>entrar nela</em> (os parâmetros) e qual vai ser o tipo de dado que ela obrigatoriamente vai <em>devolver</em> no final (o retorno). Usamos o símbolo <code>::</code> para dizer o tipo do argumento, e a seta <code>-&gt;</code> antes dos dois pontos para anunciar qual é a saída esperada!
                    </li>
                    <li style={{ marginTop: "10px" }}>
                        <strong>Objetivo (Documentação):</strong> O que a função faz na prática? Toda função em Pyret possui internamente um espaço especial logo abaixo de sua assinatura chamado <code>doc:</code>. Aqui, em uma frase, usamos aspas duplas de texto <code>"Assim"</code> para detalhar os requisitos lógicos dela.
                    </li>
                    <li style={{ marginTop: "10px" }}>
                        <strong>Código (Corpo da Implementação):</strong> Aqui é onde a verdadeira lógica de programação acontece! Tudo que a gente escrever dentro da função (depois da documentação) será validado na hora que a função rodar. A última expressão escrita dentro do bloco será retornada para quem a chamou (não precisa escrever "return" no código!).
                    </li>
                    <li style={{ marginTop: "10px" }}>
                        <strong>Testes:</strong> O Pyret já embute mecanismos de teste integrados na própria declaração! Logo antes da palavra <code>end</code> de encerramento da função, abrimos o bloco <code>where:</code>! Tudo que fica ali dentro serve de "prova real" validando se o comportamento daquela função bate com o esperado (avaliado usando a palavra <code>is</code>).
                    </li>
                </ol>

                <p style={{ marginTop: "20px" }}>Junte todas as etapas no exemplo vivo abaixo! Estar na prática significa que sempre que o editor for executado <em>(clique em "Run")</em>, ele vai validar secretamente o bloco <code>where:</code> para nos dizer que de fato, 50 - 20 resulta em 30. E caso tivéssemos implementado a soma errada, o painel do Pyret informaria o erro.</p>

                <PyretEmbed code={`# 1. Contrato definido na linha de assinatura da função
fun calcula-lucro(receita :: Number, gastos :: Number) -> Number:
  
  # 2. Objetivo da função preenchido 
  doc: "Dado o valor da receita e dos gastos, devolve o lucro."
  
  # 3. Código que implementa a lógica da função
  receita - gastos
  
where: 
  # 4. Bloco de testes (garante que a função se comporta como esperado)
  calcula-lucro(50, 20) is 30
  calcula-lucro(100, 100) is 0
end`} />
            </div>
        </div>
    );
};

export default Functions;
