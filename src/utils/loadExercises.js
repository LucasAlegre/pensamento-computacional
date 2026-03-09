import exercisesMd from '../data/exercises.md?raw';

export const loadExercises = () => {
    const lines = exercisesMd.split('\n');
    const topics = [];
    let currentTopic = null;
    let currentExercise = null;
    let currentBlock = null; // 'statement' or 'testCode'

    lines.forEach(line => {
        // Tópico
        if (line.startsWith('# Tópico: ')) {
            if (currentTopic) {
                if (currentExercise) currentTopic.exercises.push(currentExercise);
                topics.push(currentTopic);
            }
            currentTopic = {
                topic: line.replace('# Tópico: ', '').trim(),
                exercises: []
            };
            currentExercise = null;
            currentBlock = null;
        }
        // Exercício
        else if (line.startsWith('## Exercício: ')) {
            if (currentExercise) {
                currentTopic.exercises.push(currentExercise);
            }
            currentExercise = {
                title: line.replace('## Exercício: ', '').trim(),
                id: '',
                difficulty: '',
                statement: '',
                testCode: '',
                testHeight: undefined
            };
            currentBlock = 'statement';
        }
        // Metadados
        else if (line.startsWith('**ID:** ')) {
            if (currentExercise) currentExercise.id = line.replace('**ID:** ', '').trim();
        }
        else if (line.startsWith('**Dificuldade:** ')) {
            if (currentExercise) currentExercise.difficulty = line.replace('**Dificuldade:** ', '').trim();
        }
        // Testes
        else if (line.startsWith('### Testes')) {
            currentBlock = 'testCode';
        }
        // Conteúdo
        else {
            if (currentExercise && currentBlock === 'statement') {
                if (!line.startsWith('### Testes')) {
                    currentExercise.statement += line + '\n';
                }
            } else if (currentExercise && currentBlock === 'testCode') {
                if (line.trim().startsWith('```')) {
                    const match = /^\s*```pyret\s+height=(\d+)/.exec(line);
                    if (match) {
                        currentExercise.testHeight = parseInt(match[1], 10);
                    }
                    return; // skip fences
                }
                currentExercise.testCode += line + '\n';
            }
        }
    });

    if (currentExercise) currentTopic.exercises.push(currentExercise);
    if (currentTopic) topics.push(currentTopic);

    // Clean up whitespace
    topics.forEach(t => {
        t.exercises.forEach(e => {
            e.statement = e.statement.trim();
            e.testCode = e.testCode.trim();
        });
    });

    return topics;
};
