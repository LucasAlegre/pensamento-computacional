import React, { useEffect, useRef } from 'react';
import { makeEmbedConfig } from '@ironm00n/pyret-embed';

const PyretEmbed = ({ code = "" }) => {
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

    return (
        <div
            ref={containerRef}
            className="pyret-embed-container"
            style={{
                height: '400px',
                border: '1px solid #ddd',
                borderRadius: '8px',
                overflow: 'hidden',
                backgroundColor: '#f5f5f5'
            }}
        />
    );
};

export default PyretEmbed;
