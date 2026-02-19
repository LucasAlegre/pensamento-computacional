import React from 'react';
import { Link } from 'react-router-dom';

const Laboratories = () => {
    const labs = [1, 2, 3, 4, 5, 6];

    return (
        <div className="page-content">
            <h1>Laboratórios</h1>
            <p className="intro">
                Aulas práticas da disciplina de Pensamento Computacional.
            </p>

            <div className="topics-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))', gap: '2rem', marginTop: '2rem' }}>
                {labs.map(labId => (
                    <Link to={`/labs/${labId}`} key={labId} className="topic-card" style={{
                        display: 'block',
                        padding: '2rem',
                        backgroundColor: 'white',
                        borderRadius: '8px',
                        boxShadow: '0 4px 6px rgba(0,0,0,0.1)',
                        textDecoration: 'none',
                        color: 'inherit',
                        transition: 'transform 0.2s, box-shadow 0.2s'
                    }}>
                        <h2 style={{ color: '#00509e', marginBottom: '1rem' }}>Laboratório {labId}</h2>
                        <p style={{ color: '#666' }}>Acesse o roteiro da aula prática {labId}.</p>
                    </Link>
                ))}
            </div>
        </div>
    );
};

export default Laboratories;
