import React from 'react';
import { Link, NavLink } from 'react-router-dom';

const Layout = ({ children }) => {
    return (
        <div className="app-wrapper">
            <header>
                <div className="container">
                    <nav>
                        <Link to="/" className="logo">Pensamento Computacional @UFRGS</Link>
                        <ul className="nav-links">
                            <li><NavLink to="/" className={({ isActive }) => isActive ? "active" : ""}>Início</NavLink></li>
                            <li><NavLink to="/data" className={({ isActive }) => isActive ? "active" : ""}>Dados</NavLink></li>
                            <li><NavLink to="/functions" className={({ isActive }) => isActive ? "active" : ""}>Funções</NavLink></li>
                            <li><NavLink to="/lists" className={({ isActive }) => isActive ? "active" : ""}>Listas</NavLink></li>
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
                    <p>&copy; {new Date().getFullYear()} Pensamento Computacional - UFRGS. Based on DCIC World.</p>
                </div>
            </footer>
        </div>
    );
};

export default Layout;
