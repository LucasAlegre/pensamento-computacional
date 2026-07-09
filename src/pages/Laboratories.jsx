import React from 'react';
import { Link } from 'react-router-dom';
import { semesters } from '../data/labsConfig';

const Laboratories = () => {
    return (
        <div className="page-content">
            <h1>Laboratórios</h1>
            <p className="intro">
                Aulas práticas da disciplina de Pensamento Computacional.
            </p>

            {semesters.map((semester) => (
                <section key={semester.id} className="semester-section">
                    <h2 className="semester-title">
                        <span className="semester-badge">Semestre {semester.label}</span>
                    </h2>

                    <div className="topics-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))', gap: '2rem' }}>
                        {semester.labs.map(lab => (
                            <Link to={`/labs/${semester.id}/${lab.id}`} key={lab.id} className="topic-card" style={{
                                display: 'block',
                                padding: '2rem',
                                backgroundColor: 'white',
                                borderRadius: '8px',
                                boxShadow: '0 4px 6px rgba(0,0,0,0.1)',
                                textDecoration: 'none',
                                color: 'inherit',
                                transition: 'transform 0.2s, box-shadow 0.2s'
                            }}>
                                <h3 style={{ color: '#00509e', marginBottom: '1rem' }}>{lab.title}</h3>
                                <p style={{ color: '#666' }}>Acesse o roteiro da aula prática {lab.id}.</p>
                            </Link>
                        ))}
                    </div>
                </section>
            ))}
        </div>
    );
};

export default Laboratories;
