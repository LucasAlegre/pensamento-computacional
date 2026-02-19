import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeKatex from 'rehype-katex';
import remarkMath from 'remark-math';
import 'katex/dist/katex.min.css';
import PyretEmbed from '../components/PyretEmbed';

// Import markdown files (Vite allows importing as raw text with ?raw)
// We need to use a dynamic import approach or valid static imports.
// For simplicity in Vite, we can use import.meta.glob or just static imports if we know the count.
import lab1 from '../data/labs/lab1.md?raw';
import lab2 from '../data/labs/lab2.md?raw';
import lab3 from '../data/labs/lab3.md?raw';
import lab4 from '../data/labs/lab4.md?raw';
import lab5 from '../data/labs/lab5.md?raw';
import lab6 from '../data/labs/lab6.md?raw';

const labsData = {
    1: lab1,
    2: lab2,
    3: lab3,
    4: lab4,
    5: lab5,
    6: lab6
};

// Import all .arr files in codigos_pyret and data/labs
// eager: true makes them available immediately as strings
const pyretFiles = import.meta.glob(['../codigos_pyret/*.arr', '../data/labs/*.arr'], { query: '?raw', import: 'default', eager: true });

const LabPage = () => {
    const { id } = useParams();
    const content = labsData[id];

    if (!content) {
        return (
            <div className="page-content">
                <h1>Laboratório não encontrado</h1>
                <Link to="/labs">Voltar para Laboratórios</Link>
            </div>
        );
    }

    return (
        <div className="page-content">
            <Link to="/labs" className="back-link" style={{ display: 'inline-block', marginBottom: '1rem', textDecoration: 'none', color: '#666' }}>
                ← Voltar para Laboratórios
            </Link>

            <div className="section">
                <ReactMarkdown
                    remarkPlugins={[remarkMath, remarkGfm]}
                    rehypePlugins={[rehypeKatex]}
                    components={{
                        code({ node, inline, className, children, ...props }) {
                            const match = /language-(\w+)/.exec(className || '')
                            const isPyret = !inline && match && match[1] === 'pyret';

                            if (isPyret) {
                                let codeContent = String(children).replace(/\n$/, '');

                                // Check if content is a file path reference: "file: <path>"
                                const fileMatch = codeContent.match(/^file:\s*(.+)$/);
                                if (fileMatch) {
                                    const filePath = fileMatch[1].trim();

                                    // Normalize keys to start with src/ for easier comparison
                                    // Keys are like "../codigos_pyret/foo.arr" or "../data/labs/bar.arr"
                                    const foundKey = Object.keys(pyretFiles).find(key => {
                                        const normalizedKey = key.replace(/^\.\.\//, 'src/');
                                        return normalizedKey === filePath || normalizedKey.endsWith(filePath);
                                    });

                                    if (foundKey) {
                                        codeContent = pyretFiles[foundKey];
                                    } else {
                                        const availableFiles = Object.keys(pyretFiles).map(k => k.replace(/^\.\.\//, 'src/')).join(', ');
                                        codeContent = `# Erro: Arquivo não encontrado: ${filePath}\n# Tente usar o caminho completo (ex: src/...) ou apenas o nome do arquivo.\n# Arquivos disponíveis: ${availableFiles}`;
                                    }
                                }

                                return <PyretEmbed code={codeContent} />
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
                    {content}
                </ReactMarkdown>
            </div>
        </div>
    );
};

export default LabPage;
