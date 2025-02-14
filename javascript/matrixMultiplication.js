function matrixMultiply() {
    const N = 100;
    let A = Array.from({length: N}, () => Array.from({length: N}, () => Math.random()));
    let B = Array.from({length: N}, () => Array.from({length: N}, () => Math.random()));
    let C = Array.from({length: N}, () => Array(N).fill(0));

    const startTime = performance.now();
    
    for (let i = 0; i < N; i++) {
        for (let j = 0; j < N; j++) {
            for (let k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    
    const endTime = performance.now();
    console.log(`Tiempo de ejecución en JavaScript: ${endTime - startTime} ms`);
}

matrixMultiply();
