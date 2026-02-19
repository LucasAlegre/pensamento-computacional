import React from 'react';
import { Link } from 'react-router-dom';
import exercisesData from '../data/exercises.json';

const Lists = () => {
    return (
        <div className="page-content">
            <h1>Exercícios</h1>
            <p>Selecione um exercício para resolver.</p>

            <div className="lists-container">
                {exercisesData.map((topicData, index) => (
                    <div key={index} className="topic-section" style={{ marginBottom: '2rem' }}>
                        <h2>{topicData.topic}</h2>
                        <ul className="exercise-links" style={{ listStyle: 'none', padding: 0 }}>
                            {topicData.exercises.map((exercise, idx) => (
                                <li key={exercise.id} style={{ marginBottom: '0.5rem' }}>
                                    <Link to={`/exercises/${encodeURIComponent(exercise.id)}`} style={{ textDecoration: 'none', color: '#0066cc', fontSize: '1.1rem' }}>
                                        {idx + 1} - {exercise.title}
                                    </Link>
                                    <span style={{
                                        marginLeft: '10px',
                                        fontSize: '0.8rem',
                                        padding: '2px 6px',
                                        borderRadius: '4px',
                                        backgroundColor: exercise.difficulty === 'Fácil' ? '#d4edda' : exercise.difficulty === 'Médio' ? '#fff3cd' : '#f8d7da',
                                        color: exercise.difficulty === 'Fácil' ? '#155724' : exercise.difficulty === 'Médio' ? '#856404' : '#721c24'
                                    }}>
                                        {exercise.difficulty}
                                    </span>
                                </li>
                            ))}
                        </ul>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default Lists;
