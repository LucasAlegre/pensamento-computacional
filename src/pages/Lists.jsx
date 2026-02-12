import React from 'react';
import PyretEmbed from '../components/PyretEmbed';

const Lists = () => {
    return (
        <div className="page-content">
            <h1>Listas</h1>
            <p>Listas são coleções ordenadas de elementos.</p>

            <div className="section">
                <h2>Criando Listas</h2>
                <p>Podemos criar listas usando chaves <code>[list: ...]</code>.</p>
                <PyretEmbed code={`my-list = [list: 1, 2, 3, 4, 5]
my-list`} />
            </div>

            <div className="section">
                <h2>Operações em Listas</h2>
                <p>Podemos acessar o primeiro elemento (first) e o resto da lista (rest).</p>
                <PyretEmbed code={`L = [list: 10, 20, 30]
L.first
L.rest`} />
            </div>
        </div>
    );
};

export default Lists;
