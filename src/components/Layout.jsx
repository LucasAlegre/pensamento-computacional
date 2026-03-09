import React from 'react';
import { Link, NavLink } from 'react-router-dom';

const Layout = ({ children }) => {
    return (
        <div className="app-wrapper">
            <header>
                <div className="container">
                    <nav>
                        <Link to="/" className="logo">Pensamento Computacional - INF UFRGS</Link>
                        <ul className="nav-links">
                            <li><NavLink to="/" className={({ isActive }) => isActive ? "active" : ""}>Início</NavLink></li>
                            <li className="dropdown">
                                <NavLink to="/topics" className={({ isActive }) => isActive ? "active" : ""}>
                                    Tópicos <span style={{ fontSize: '0.7em' }}>▼</span>
                                </NavLink>
                                <ul className="dropdown-content">
                                    <li><Link to="/topics/learning">Aprendendo a Programar</Link></li>
                                    <li><Link to="/topics/style-guide">Guia de Estilo</Link></li>
                                    <li><Link to="/topics/tipos-de-dados">Tipos de Dados</Link></li>
                                    <li><Link to="/topics/functions">Funções</Link></li>
                                </ul>
                            </li>
                            <li><NavLink to="/labs" className={({ isActive }) => isActive ? "active" : ""}>Laboratórios</NavLink></li>
                            <li><NavLink to="/exercises" className={({ isActive }) => isActive ? "active" : ""}>Exercícios</NavLink></li>
                            <li><NavLink to="/examples" className={({ isActive }) => isActive ? "active" : ""}>Exemplos</NavLink></li>
                        </ul>
                    </nav>
                </div>
            </header>

            <main className="container main-content">
                {children}
            </main>

            <footer>
                <div className="container" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                    <div style={{ backgroundColor: '#fff', padding: '0.5rem 1rem', borderRadius: '8px', marginBottom: '1rem', display: 'inline-block' }}>
                        <img
                            src={`${import.meta.env.BASE_URL || '/'}inf-logo-2.0.svg`.replace('//', '/')}
                            alt="Logo Instituto de Informática UFRGS"
                            style={{ height: '50px', display: 'block' }}
                        />
                    </div>
                    <p>&copy; {new Date().getFullYear()} INF05008 - Pensamento Computacional
                        <br />
                        Instituto de Informática - UFRGS
                        <br />
                        Departamento de Informática Teórica
                        <br />
                        Prof. Lucas Nunes Alegre - <a href="https://lucasalegre.github.io">lucasalegre.github.io</a>
                    </p>
                </div>
            </footer>
        </div>
    );
};

export default Layout;
