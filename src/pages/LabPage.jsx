import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeKatex from 'rehype-katex';
import rehypeRaw from 'rehype-raw';
import remarkMath from 'remark-math';
import 'katex/dist/katex.min.css';
import PyretEmbed from '../components/PyretEmbed';

// Dynamically import all lab markdown files from semester subfolders
const labMarkdowns = import.meta.glob('../data/labs/**/*.md', { query: '?raw', import: 'default', eager: true });

// Import all .arr files in codigos_pyret and data/labs (including semester subfolders)
// eager: true makes them available immediately as strings
const pyretFiles = import.meta.glob(['../codigos_pyret/*.arr', '../data/labs/**/*.arr'], { query: '?raw', import: 'default', eager: true });

// Import local images from data/labs so Vite bundles them correctly with hash paths
const localImages = import.meta.glob('../data/labs/**/*.{png,jpg,jpeg,svg}', { eager: true, import: 'default' });


const LabPage = () => {
    const { semesterId, labId } = useParams();

    // Look up the markdown content using the glob key pattern: ../data/labs/<semesterId>/lab<labId>.md
    const globKey = `../data/labs/${semesterId}/lab${labId}.md`;
    const content = labMarkdowns[globKey];

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
                    rehypePlugins={[rehypeKatex, rehypeRaw]}
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
                                    // Keys are like "../codigos_pyret/foo.arr" or "../data/labs/2026-1/bar.arr"
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
                        },
                        img({ node, className, src, ...props }) {
                            // Check if the image source starts with 'images/' or './images/' (local markdown relative paths)
                            let finalSrc = src;

                            let cleanSrc = src;
                            if (cleanSrc && cleanSrc.startsWith('./')) cleanSrc = cleanSrc.substring(2);

                            // If the markdown points to a local images folder, look up the bundled URL from the import.meta.glob
                            if (cleanSrc && cleanSrc.startsWith('images/')) {
                                // Try semester-specific path first, then fallback to root labs path
                                const semesterMapKey = `../data/labs/${semesterId}/${cleanSrc}`;
                                if (localImages[semesterMapKey]) {
                                    finalSrc = localImages[semesterMapKey];
                                }
                            } else if (cleanSrc && !cleanSrc.startsWith('http') && !cleanSrc.startsWith('/')) {
                                // Try to resolve relative paths within the semester folder
                                const semesterMapKey = `../data/labs/${semesterId}/${cleanSrc}`;
                                if (localImages[semesterMapKey]) {
                                    finalSrc = localImages[semesterMapKey];
                                }
                            } else if (cleanSrc && cleanSrc.startsWith('public/')) {
                                // Fallback for public absolute paths
                                cleanSrc = cleanSrc.substring(7);
                                const baseUrl = import.meta.env.BASE_URL || '/';
                                const cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.slice(0, -1) : baseUrl;
                                finalSrc = `${cleanBaseUrl}/${cleanSrc}`;
                            }

                            return (
                                <img
                                    className={className}
                                    src={finalSrc}
                                    style={{ maxWidth: '100%', borderRadius: '8px', marginTop: '1rem', display: 'block' }}
                                    {...props}
                                />
                            );
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
