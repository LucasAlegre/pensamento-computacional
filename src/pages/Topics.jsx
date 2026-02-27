import React from 'react';
import { Link } from 'react-router-dom';

const Topics = () => {
    return (
        <div className="page-content">
            <h1>Tópicos</h1>
            <p>Selecione um tópico para estudar:</p>

            <div className="topics-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '2rem', marginTop: '2rem' }}>


                <Link to="/topics/functions" className="topic-card" style={{
                    display: 'block',
                    padding: '2rem',
                    backgroundColor: 'white',
                    borderRadius: '8px',
                    boxShadow: '0 4px 6px rgba(0,0,0,0.1)',
                    textDecoration: 'none',
                    color: 'inherit',
                    transition: 'transform 0.2s, box-shadow 0.2s'
                }}>
                    <h2 style={{ color: '#00509e', marginBottom: '1rem' }}>Funções</h2>
                    <p style={{ color: '#666' }}>Entenda como definir e utilizar funções para reutilizar código.</p>
                </Link>

                <Link to="/topics/style-guide" className="topic-card" style={{
                    display: 'block',
                    padding: '2rem',
                    backgroundColor: 'white',
                    borderRadius: '8px',
                    boxShadow: '0 4px 6px rgba(0,0,0,0.1)',
                    textDecoration: 'none',
                    color: 'inherit',
                    transition: 'transform 0.2s, box-shadow 0.2s'
                }}>
                    <h2 style={{ color: '#00509e', marginBottom: '1rem' }}>Guia de Estilo</h2>
                    <p style={{ color: '#666' }}>Boas práticas de testes, design e clareza em Pyret.</p>
                </Link>
            </div>
        </div>
    );
};

export default Topics;
