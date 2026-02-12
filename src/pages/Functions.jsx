import React from 'react';
import PyretEmbed from '../components/PyretEmbed';

const Functions = () => {
    return (
        <div className="page-content">
            <h1>Funções</h1>
            <p>Funções são blocos de código que realizam uma tarefa específica e podem ser reutilizados.</p>

            <div className="section">
                <h2>Definindo Funções</h2>
                <p>Em Pyret, usamos a palavra-chave <code>fun</code> para definir uma função.</p>
                <PyretEmbed code={`fun square(n):
  n * n
end

square(10)`} />
            </div>

            <div className="section">
                <h2>Contratos</h2>
                <p>É uma boa prática definir o contrato (tipos de entrada e saída) da função.</p>
                <PyretEmbed code={`fun add(x :: Number, y :: Number) -> Number:
  x + y
end

add(5, 3)`} />
            </div>
        </div>
    );
};

export default Functions;
