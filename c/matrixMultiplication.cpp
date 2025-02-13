#include <iostream>
#include <vector>
#include <chrono>
#include <random>

int main() {
    const int N = 2000;
    std::vector<std::vector<double>> A(N, std::vector<double>(N));
    std::vector<std::vector<double>> B(N, std::vector<double>(N));
    std::vector<std::vector<double>> C(N, std::vector<double>(N, 0.0));

    // Generador de números aleatorios
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(0, 1);

    // Inicializar matrices
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = dis(gen);
            B[i][j] = dis(gen);
        }
    }

    // Medir tiempo
    auto start = std::chrono::high_resolution_clock::now();

    // Multiplicación de matrices
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> diff = end - start;

    std::cout << "Tiempo de ejecución en C++: " << diff.count() << " segundos\n";
    return 0;
}
