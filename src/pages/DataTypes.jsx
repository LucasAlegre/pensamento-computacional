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
const topicFile = import.meta.glob('../data/topics/tipos-de-dados.md', { query: '?raw', import: 'default', eager: true });

const DataTypes = () => {
    const [content, setContent] = useState('');

    useEffect(() => {
        // Fetch the raw markdown content
        if (topicFile['../data/topics/tipos-de-dados.md']) {
            setContent(topicFile['../data/topics/tipos-de-dados.md']);
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
                            code({ node, className, children, ...props }) {
                                const match = /language-(\w+)/.exec(className || '')
                                const codeStr = String(children).replace(/\n$/, '');

                                if (match && match[1] === 'pyret') {
                                    const meta = node?.data?.meta || '';
                                    let height;
                                    const heightMatch = /height=(\d+)/.exec(meta);
                                    if (heightMatch) height = parseInt(heightMatch[1], 10);

                                    return (
                                        <PyretEmbed code={codeStr} height={height} />
                                    )
                                }

                                if (codeStr.includes('::') || codeStr.includes('->')) {
                                    const parts = codeStr.split(/(\bNumber\b|\bBoolean\b|\bString\b|\bImage\b|\bAny\b|\bCena\b|::|->|\(|\))/);
                                    return (
                                        <code className={`inline-code-container ${className || ''}`} {...props}>
                                            {parts.map((p, i) => {
                                                if (!p) return null;
                                                const pt = p.trim();
                                                if (['Number', 'Boolean', 'String', 'Image', 'Any', 'Cena'].includes(pt)) {
                                                    return <span key={i} className="inline-keyword">{p}</span>;
                                                }
                                                if (pt === '::' || pt === '->') {
                                                    return <span key={i} className="inline-symbol">{p}</span>;
                                                }
                                                if (i === 0 && pt.length > 0 && !pt.includes(' ')) {
                                                    return <span key={i} className="inline-function">{p}</span>;
                                                }
                                                // Verifica aspas mesmo dentro da assinatura
                                                if (p.includes('"') || p.includes("'")) {
                                                    const subParts = p.split(/((?:".*?")|(?:'.*?'))/g);
                                                    return <span key={i}>{subParts.map((sp, j) => {
                                                        if (!sp) return null;
                                                        if ((sp.startsWith('"') && sp.endsWith('"')) || (sp.startsWith("'") && sp.endsWith("'"))) {
                                                            return <span key={j} className="inline-string">{sp}</span>;
                                                        }
                                                        return <span key={j}>{sp}</span>;
                                                    })}</span>;
                                                }

                                                return <span key={i}>{p}</span>;
                                            })}
                                        </code>
                                    );
                                }

                                if (['true', 'false', 'empty', 'link', 'is-boolean'].includes(codeStr.trim())) {
                                    return <code className={`inline-code-container inline-keyword ${className || ''}`} {...props}>{children}</code>;
                                }

                                if (codeStr.includes('"') || codeStr.includes("'")) {
                                    const parts = codeStr.split(/((?:".*?")|(?:'.*?'))/g);
                                    return (
                                        <code className={`inline-code-container ${className || ''}`} {...props}>
                                            {parts.map((p, i) => {
                                                if (!p) return null;
                                                if ((p.startsWith('"') && p.endsWith('"')) || (p.startsWith("'") && p.endsWith("'"))) {
                                                    return <span key={i} className="inline-string">{p}</span>;
                                                }
                                                return <span key={i}>{p}</span>;
                                            })}
                                        </code>
                                    );
                                }

                                // Apenas retorna o code para que o ReactMarkdown ou a tag <p> lidem com a estrutura de bloco validamente.
                                return (
                                    <code className={`inline-code-container ${className || ''}`} {...props}>
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

export default DataTypes;
