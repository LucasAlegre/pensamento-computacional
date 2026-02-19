import React from 'react';
import 'katex/dist/katex.min.css';
import ReactMarkdown from 'react-markdown';
import rehypeKatex from 'rehype-katex';
import remarkMath from 'remark-math';
import remarkGfm from 'remark-gfm';
import PyretEmbed from './PyretEmbed';

const ExerciseItem = ({ exercise }) => {
    return (
        <div className="exercise-item section" style={{ marginBottom: '2rem' }}>
            <div className="exercise-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                <span className="exercise-id" style={{ fontWeight: 'bold', color: '#666' }}>{exercise.id}</span>
                <span className={`difficulty-tag ${exercise.difficulty.toLowerCase()}`}
                    style={{
                        padding: '0.25rem 0.5rem',
                        borderRadius: '4px',
                        fontSize: '0.8rem',
                        backgroundColor: exercise.difficulty === 'Fácil' ? '#d4edda' :
                            exercise.difficulty === 'Médio' ? '#fff3cd' : '#f8d7da',
                        color: exercise.difficulty === 'Fácil' ? '#155724' :
                            exercise.difficulty === 'Médio' ? '#856404' : '#721c24'
                    }}>
                    {exercise.difficulty}
                </span>
            </div>

            <div className="exercise-statement" style={{ marginBottom: '1rem', lineHeight: '1.6' }}>
                <ReactMarkdown
                    remarkPlugins={[remarkMath, remarkGfm]}
                    rehypePlugins={[rehypeKatex]}
                >
                    {exercise.statement}
                </ReactMarkdown>
            </div>

            <div className="exercise-code">
                <PyretEmbed code={exercise.testCode} />
            </div>
        </div>
    );
};

export default ExerciseItem;
