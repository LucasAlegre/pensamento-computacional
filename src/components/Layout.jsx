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
                                    <li><Link to="/topics/data">Dados</Link></li>
                                    <li><Link to="/topics/functions">Funções</Link></li>
                                </ul>
                            </li>
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
                <div className="container">
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
