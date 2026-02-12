import React, { useState, useEffect } from 'react';
import PyretEmbed from './PyretEmbed';

// Dynamically import all .arr files as raw strings
const codeFiles = import.meta.glob('../codigos_pyret/*.arr', {
    query: '?raw',
    import: 'default',
    eager: true
});

const CodeViewer = () => {
    const [selectedFile, setSelectedFile] = useState('');

    // Extract filenames from paths
    const files = Object.keys(codeFiles).map(path => ({
        path,
        name: path.split('/').pop()
    }));

    // Select first file by default
    useEffect(() => {
        if (files.length > 0 && !selectedFile) {
            setSelectedFile(files[0].path);
        }
    }, [files]);

    const currentCode = selectedFile ? codeFiles[selectedFile] : '';

    return (
        <div className="code-viewer">
            <div className="file-selector" style={{ marginBottom: '1rem' }}>
                <label htmlFor="file-select" style={{ marginRight: '0.5rem', fontWeight: 'bold' }}>Escolha um exemplo:</label>
                <select
                    id="file-select"
                    value={selectedFile}
                    onChange={(e) => setSelectedFile(e.target.value)}
                    style={{ padding: '0.5rem', borderRadius: '4px', border: '1px solid #ccc' }}
                >
                    {files.map(file => (
                        <option key={file.path} value={file.path}>
                            {file.name}
                        </option>
                    ))}
                </select>
            </div>

            {selectedFile && (
                <div className="code-display">
                    <h3>{files.find(f => f.path === selectedFile)?.name}</h3>
                    <PyretEmbed code={currentCode} />
                </div>
            )}
        </div>
    );
};

export default CodeViewer;
