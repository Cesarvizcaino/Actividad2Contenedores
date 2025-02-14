public class matrixMultiplication {
    public static void main(String[] args) {
        int N = 100;
        double[][] A = new double[N][N];
        double[][] B = new double[N][N];
        double[][] C = new double[N][N];

        // Inicializar matrices con valores aleatorios
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                A[i][j] = Math.random();
                B[i][j] = Math.random();
            }
        }

        long startTime = System.nanoTime();
        
        // Multiplicación de matrices
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                for (int k = 0; k < N; k++) {
                    C[i][j] += A[i][k] * B[k][j];
                }
            }
        }
        
        long endTime = System.nanoTime();
        double duration = (endTime - startTime) / 1e6; // Convertir a milisegundos

        System.out.println("Tiempo de ejecución en Java: " + duration + " ms");
    }
}
