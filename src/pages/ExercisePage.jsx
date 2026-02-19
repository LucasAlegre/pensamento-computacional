import React from 'react';
import { useParams, Link } from 'react-router-dom';
import ExerciseItem from '../components/ExerciseItem';
import exercisesData from '../data/exercises.json';

const ExercisePage = () => {
    const { id } = useParams();

    // Find the exercise across all topics
    let exercise = null;
    let topicName = "";

    for (const topic of exercisesData) {
        const found = topic.exercises.find(ex => ex.id === id);
        if (found) {
            exercise = found;
            topicName = topic.topic;
            break;
        }
    }

    if (!exercise) {
        return (
            <div className="page-content">
                <Link to="/lists" className="back-link">← Voltar para a lista</Link>
                <h1>Exercício não encontrado</h1>
                <p>O exercício solicitado não foi encontrado.</p>
            </div>
        );
    }

    return (
        <div className="page-content">
            <Link to="/lists" className="back-link" style={{ display: 'inline-block', marginBottom: '1rem', textDecoration: 'none', color: '#666' }}>
                ← Voltar para a lista
            </Link>

            <div className="exercise-page-header" style={{ marginBottom: '2rem' }}>
                <span className="topic-tag" style={{ fontSize: '0.9rem', color: '#888', textTransform: 'uppercase', letterSpacing: '1px' }}>
                    {topicName}
                </span>
                <h1 style={{ marginTop: '0.5rem' }}>{exercise.title}</h1>
            </div>

            <ExerciseItem exercise={exercise} />
        </div>
    );
};

export default ExercisePage;
