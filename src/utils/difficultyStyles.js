export const getDifficultyStyle = (difficulty) => {
    const d = (difficulty || '').toLowerCase().trim();
    
    switch (d) {
        case 'fácil':
            return {
                backgroundColor: '#d4edda',
                color: '#155724'
            };
        case 'médio':
            return {
                backgroundColor: '#fff3cd',
                color: '#856404'
            };
        case 'resolvido':
            return {
                backgroundColor: '#e7f3ff',
                color: '#0056b3'
            };
        case 'difícil':
        default:
            return {
                backgroundColor: '#f8d7da',
                color: '#721c24'
            };
    }
};
