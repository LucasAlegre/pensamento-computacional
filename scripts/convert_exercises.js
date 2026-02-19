import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const jsonPath = path.join(__dirname, '../src/data/exercises.json');
const mdPath = path.join(__dirname, '../src/data/exercises.md');

const data = JSON.parse(fs.readFileSync(jsonPath, 'utf-8'));

let mdContent = '';

data.forEach(topic => {
    mdContent += `# Tópico: ${topic.topic}\n\n`;

    topic.exercises.forEach(ex => {
        mdContent += `## Exercício: ${ex.title}\n`;
        mdContent += `**ID:** ${ex.id}\n`;
        mdContent += `**Dificuldade:** ${ex.difficulty}\n\n`;
        mdContent += `${ex.statement}\n\n`;
        mdContent += `### Testes\n`;
        mdContent += "```pyret\n";
        mdContent += `${ex.testCode}\n`;
        mdContent += "```\n\n";
    });
});

fs.writeFileSync(mdPath, mdContent);
console.log('Conversion complete: src/data/exercises.md created.');
