import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeKatex from 'rehype-katex';
import rehypeRaw from 'rehype-raw';
import remarkMath from 'remark-math';
import 'katex/dist/katex.min.css';
import PyretEmbed from '../components/PyretEmbed';
import TableOfContents from '../components/TableOfContents';

// Import the markdown content directly
const guideFile = import.meta.glob('../data/topics/learning.md', { query: '?raw', import: 'default', eager: true });

const Learning = () => {
    const [content, setContent] = useState('');

    useEffect(() => {
        // Fetch the raw markdown content
        if (guideFile['../data/topics/learning.md']) {
            setContent(guideFile['../data/topics/learning.md']);
        }
    }, []);

    if (!content) return <div className="page-content">Carregando conteúdo...</div>;

    return (
        <div className="page-container">
            <div className="page-content">
                <Link to="/topics" className="back-link" style={{ display: 'inline-block', marginBottom: '1rem', textDecoration: 'none', color: '#666' }}>
                    ← Voltar para Tópicos
                </Link>

                <div className="section">
                    <ReactMarkdown
                        remarkPlugins={[remarkMath, remarkGfm]}
                        rehypePlugins={[rehypeKatex, rehypeRaw]}
                        components={{
                            code({ node, inline, className, children, ...props }) {
                                const match = /language-(\w+)/.exec(className || '')
                                const codeString = String(children).replace(/\n$/, '');

                                if (!inline && match && match[1] === 'pyret') {
                                    return (
                                        <PyretEmbed code={codeString} />
                                    )
                                }
                                return !inline ? (
                                    <pre>
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
                        {content}
                    </ReactMarkdown>
                </div>
            </div>
            <TableOfContents contentDependency={content} />
        </div>
    );
};

export default Learning;
