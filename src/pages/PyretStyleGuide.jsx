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
const guideFile = import.meta.glob('../data/topics/style-guide.md', { query: '?raw', import: 'default', eager: true });

const PyretStyleGuide = () => {
    const [content, setContent] = useState('');

    useEffect(() => {
        // Fetch the raw markdown content
        if (guideFile['../data/topics/style-guide.md']) {
            setContent(guideFile['../data/topics/style-guide.md']);
        }
    }, []);

    if (!content) return <div className="page-content">Carregando guia de estilo...</div>;

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
                                    const meta = node?.data?.meta || '';
                                    let height;
                                    const heightMatch = /height=(\d+)/.exec(meta);
                                    if (heightMatch) height = parseInt(heightMatch[1], 10);

                                    return (
                                        <PyretEmbed code={codeString} height={height} />
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
        </div >
    );
};

export default PyretStyleGuide;
