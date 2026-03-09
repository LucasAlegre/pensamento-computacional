import React, { useEffect, useRef } from 'react';
import { makeEmbedConfig } from '@ironm00n/pyret-embed';

const PyretEmbed = ({ code = "", height }) => {
    const containerRef = useRef(null);

    useEffect(() => {
        let active = true;

        const initEmbed = async () => {
            if (containerRef.current) {
                // Clear container to prevent duplicate embeds
                containerRef.current.innerHTML = '';

                try {
                    await makeEmbedConfig({
                        container: containerRef.current,
                        state: {
                            editorContents: code,
                            replContents: "",
                            definitionsAtLastRun: "",
                            interactionsSinceLastRun: []
                        },
                        options: {
                            footerStyle: "hide",
                            warnOnExit: false
                        }
                    });
                } catch (error) {
                    if (active) {
                        console.error("Failed to initialize Pyret embed:", error);
                        if (containerRef.current) {
                            containerRef.current.innerHTML = `<div style="color: red; padding: 1rem;">Failed to load Pyret editor: ${error.message}</div>`;
                        }
                    }
                }
            }
        };

        initEmbed();

        return () => {
            active = false;
            if (containerRef.current) {
                containerRef.current.innerHTML = '';
            }
        };
    }, [code]);

    // Calcular altura baseada na quantidade de linhas de código
    const lines = code.split('\n').length;
    const computedHeight = Math.max(130, Math.min(600, lines * 24 + 65));
    const finalHeight = height || computedHeight;

    return (
        <div
            ref={containerRef}
            className="pyret-embed-container"
            style={{
                height: `${finalHeight}px`,
                border: '1px solid #ddd',
                borderRadius: '8px',
                overflow: 'auto',
                resize: 'vertical',
                backgroundColor: '#f5f5f5',
                marginBottom: '1rem'
            }}
        />
    );
};

export default PyretEmbed;
