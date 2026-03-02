import React from 'react';
import { Link } from 'react-router-dom';

const Home = () => {
    return (
        <div className="home-page">
            <div className="section hero">
                <h1>Pensamento Computacional</h1>
                <p>Página da disciplina INF05008 Pensamento Computacional do Instituto de Informática da UFRGS.</p>
                <div style={{ marginTop: '1.5rem' }}>
                    <Link to="/topics" className="btn">Começar Agora</Link>
                </div>
                <div style={{ marginTop: '2.5rem', textAlign: 'center' }}>
                    <img src="https://dcic-world.org/DCIC_splash.png" alt="DCIC Splash" style={{ maxWidth: '100%', height: 'auto', borderRadius: '8px', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }} />
                </div>
            </div>

            <div className="section">
                <h2>Sobre o Curso</h2>
                <p>
                    Este curso segue a metodologia do livro <a href="https://dcic-world.org/" target="_blank" rel="noopener noreferrer">DCIC</a> (A Data-Centric Introduction to Computing).
                </p>
                <p>A disciplina visa desenvolver as seguintes habilidades:</p>
                <ul>
                    <li>Analisar problemas e elaborar algoritmos que os solucionem, utilizando uma linguagem de programação funcional para descrever esses algoritmos;</li>
                    <li>Conhecer as principais estruturas de dados e escolher as estruturas adequadas para modelar diferentes situações, justificando suas escolhas;</li>
                    <li>Construir soluções computacionais utilizando conceitos de recursão e metaprogramação;</li>
                    <li>Resolver problemas usando o pensamento computacional, aplicando as principais técnicas de construção de soluções computacionais e analisando criticamente as soluções.</li>
                </ul>
            </div>

            <div className="section">
                <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginBottom: '1rem' }}>
                    <img src="https://pyret.org/img/pyret-logo.png" alt="Pyret Logo" style={{ height: '40px' }} />
                    <h2 style={{ margin: 0 }}>Por que Pyret?</h2>
                </div>
                <p>
                    Pyret é uma linguagem de programação projetada para educação. Ela possui uma sintaxe clara, mensagens de erro úteis e suporte nativo para testes, o que a torna ideal para iniciantes.
                </p>
                <div style={{ marginTop: '1.5rem', display: 'flex', gap: '1rem', flexWrap: 'wrap' }}>
                    <a href="https://pyret.org/" target="_blank" rel="noopener noreferrer" className="btn">Site do Pyret</a>
                    <a href="https://pyret.org/docs/latest/" target="_blank" rel="noopener noreferrer" className="btn">Documentação</a>
                    <a href="https://code.pyret.org/" target="_blank" rel="noopener noreferrer" className="btn">code.pyret.org (CPO)</a>
                    <a href="https://marketplace.visualstudio.com/items?itemName=PyretProgrammingLanguage.pyret-parley" target="_blank" rel="noopener noreferrer" className="btn">Extensão VSCode</a>
                </div>
            </div>
        </div>
    );
};

export default Home;
