import React from 'react';
import { Link } from 'react-router-dom';
import { cronogramaTurmaC } from '../data/cronogramaTurmaC';

const BASE = import.meta.env.BASE_URL;

const SlidesLink = ({ arquivo }) => {
    if (!arquivo) return null;
    const pdf = arquivo.endsWith('.pdf');
    return (
        <a className={`cron-slides ${pdf ? 'pdf' : ''}`} href={`${BASE}${arquivo}`} target="_blank" rel="noopener noreferrer">
            {pdf ? 'PDF' : 'Slides'}
        </a>
    );
};

const Assunto = ({ item }) => {
    if (item.lab) {
        return <Link to={`/labs/2026-2/${item.lab}`}>{item.assunto}</Link>;
    }
    if (item.link) {
        return <a href={item.link} target="_blank" rel="noopener noreferrer">{item.assunto}</a>;
    }
    return item.assunto;
};

const TurmaC = () => {
    const { semestre, turma, professor, semanas } = cronogramaTurmaC;

    return (
        <div className="page-content cronograma">
            <h1>Cronograma e Slides — Turma {turma}</h1>
            <p className="cron-aviso">
                Esta página é específica para a <strong>Turma {turma}</strong> ({professor}), semestre {semestre}.
                Os slides e locais podem ser diferentes nas demais turmas.
            </p>
            <p className="intro">
                Este cronograma pode sofrer modificações ao longo do semestre, sendo importante verificá-lo periodicamente.
                As referências são seções do livro <a href="https://dcic-world.org" target="_blank" rel="noopener noreferrer">DCIC</a>.
            </p>

            <div className="cron-scroll">
                <table className="cron-tabela">
                    <thead>
                        <tr>
                            <th>Semana</th>
                            <th>Aula</th>
                            <th>Data</th>
                            <th>Assunto</th>
                            <th>Local</th>
                            <th>Slides</th>
                            <th>Atividade</th>
                            <th>Referências</th>
                        </tr>
                    </thead>
                    <tbody>
                        {semanas.map(({ semana, aulas }) =>
                            aulas.map((item, i) => (
                                <tr key={`${semana}-${i}`} className={`cron-${item.tipo}`}>
                                    {i === 0 && <td className="cron-semana" rowSpan={aulas.length}>{semana ?? ''}</td>}
                                    <td className="cron-num">{item.aula ?? ''}</td>
                                    <td className="cron-data">{item.data}</td>
                                    <td className="cron-assunto"><Assunto item={item} /></td>
                                    <td className="cron-data">{item.local ?? ''}</td>
                                    <td className="cron-num"><SlidesLink arquivo={item.slides} /></td>
                                    <td>{item.atividade ?? ''}</td>
                                    <td>{item.referencias ?? ''}</td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default TurmaC;
