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
                    components={{
                        code({ node, inline, className, children, ...props }) {
                            const match = /language-(\w+)/.exec(className || '')
                            const isPyret = !inline && match && match[1] === 'pyret';

                            if (isPyret) {
                                let codeContent = String(children).replace(/\n$/, '');

                                const meta = node?.data?.meta || '';
                                let height;
                                const heightMatch = /height=(\d+)/.exec(meta);
                                if (heightMatch) height = parseInt(heightMatch[1], 10);

                                return <PyretEmbed code={codeContent} height={height} />
                            }

                            return !inline && match ? (
                                <pre className={className}>
                                    <code className={className} {...props}>
                                        {children}
                                    </code>
                                </pre>
                            ) : (
                                <code className={className} {...props}>
                                    {children}
                                </code>
                            )
                        }
                    }}
                >
                    {exercise.statement}
                </ReactMarkdown>
            </div>

            <div className="exercise-code">
                <PyretEmbed code={exercise.testCode} height={exercise.testHeight} />
            </div>
        </div>
    );
};

export default ExerciseItem;
