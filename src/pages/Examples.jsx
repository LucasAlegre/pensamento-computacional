import React from 'react';
import CodeViewer from '../components/CodeViewer';

const Examples = () => {
    return (
        <div className="page-content">
            <h1>Exemplos de Aula</h1>
            <p>Abaixo você pode visualizar e executar os códigos trabalhados em sala de aula.</p>

            <div className="section">
                <CodeViewer />
            </div>
        </div>
    );
};

export default Examples;
