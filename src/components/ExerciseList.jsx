import React, { useState } from 'react';
import ExerciseItem from './ExerciseItem';

const ExerciseList = ({ topic, exercises }) => {
    const [isExpanded, setIsExpanded] = useState(true);

    return (
        <div className="exercise-topic-section" style={{ marginBottom: '2rem' }}>
            <h2
                onClick={() => setIsExpanded(!isExpanded)}
                style={{
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    borderBottom: '2px solid #eee',
                    paddingBottom: '0.5rem'
                }}
            >
                <span style={{ marginRight: '0.5rem' }}>{isExpanded ? '▼' : '▶'}</span>
                {topic}
            </h2>

            {isExpanded && (
                <div className="exercises-container">
                    {exercises.map(exercise => (
                        <ExerciseItem key={exercise.id} exercise={exercise} />
                    ))}
                </div>
            )}
        </div>
    );
};

export default ExerciseList;
