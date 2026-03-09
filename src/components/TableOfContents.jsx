import React, { useEffect, useState } from 'react';

const TableOfContents = ({ contentDependency }) => {
    const [headings, setHeadings] = useState([]);

    useEffect(() => {
        // Dar um tempinho pro ReactMarkdown renderizar caso venha de prop
        const timer = setTimeout(() => {
            const elements = Array.from(document.querySelectorAll('.page-content h2, .page-content h3'));

            const newHeadings = elements.map((el, index) => {
                if (!el.id) {
                    const text = el.innerText;
                    const id = text.toLowerCase().replace(/[^a-z0-9à-ú]+/g, '-').replace(/(^-|-$)+/g, '');
                    el.id = id || `heading-${index}`;
                }
                return {
                    id: el.id,
                    text: el.innerText,
                    level: Number(el.tagName.charAt(1))
                };
            });

            setHeadings(newHeadings);
        }, 100);

        return () => clearTimeout(timer);
    }, [contentDependency]);

    if (headings.length === 0) return null;

    return (
        <aside className="toc-sidebar">
            <h4 className="toc-title">Nesta Página</h4>
            <nav className="toc-nav">
                <ul>
                    {headings.map(h => (
                        <li key={h.id} className={`toc-level-${h.level}`}>
                            <a href={`#${h.id}`}>
                                {h.text}
                            </a>
                        </li>
                    ))}
                </ul>
            </nav>
        </aside>
    );
};

export default TableOfContents;
