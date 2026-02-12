import React from 'react';
import PyretEmbed from '../components/PyretEmbed';

const Data = () => {
    return (
        <div className="page-content">
            <h1>Dados</h1>
            <p>Em computação, dados são a representação de informações. Vamos começar com os tipos básicos: Números, Strings e Booleanos.</p>

            <div className="section">
                <h2>Números e Operações</h2>
                <p>Pyret pode ser usado como uma calculadora. Tente executar o código abaixo:</p>
                <PyretEmbed code="1 + 2 * 3" />
            </div>

            <div className="section">
                <h2>Strings</h2>
                <p>Textos em Pyret são chamados de Strings e são delimitados por aspas.</p>
                <PyretEmbed code='"Olá, " + "Mundo!"' />
            </div>
        </div>
    );
};

export default Data;
