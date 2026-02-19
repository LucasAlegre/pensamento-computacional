import React from 'react';
import { Link } from 'react-router-dom';

const Home = () => {
    return (
        <div className="home-page">
            <div className="section hero">
                <h1>INF05008 Pensamento Computacional</h1>
                <p>Aprenda a pensar como um cientista da computação usando a linguagem Pyret.</p>
                <div style={{ marginTop: '1.5rem' }}>
                    <Link to="/topics" className="btn">Começar Agora</Link>
                </div>
            </div>

            <div className="section">
                <h2>Sobre o Curso</h2>
                <p>
                    Este curso segue a metodologia do <a href="https://dcic-world.org/" target="_blank" rel="noopener noreferrer">DCIC World</a> (A Data-Centric Introduction to Computing).
                </p>
            </div>

            <div className="section">
                <h2>Por que Pyret?</h2>
                <p>
                    Pyret é uma linguagem de programação projetada para educação. Ela possui uma sintaxe clara, mensagens de erro úteis e suporte nativo para testes, o que a torna ideal para iniciantes.
                </p>
            </div>
        </div>
    );
};

export default Home;
