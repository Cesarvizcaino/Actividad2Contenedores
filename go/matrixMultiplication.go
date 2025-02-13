package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    // Establecer la semilla para números aleatorios
    rand.Seed(time.Now().UnixNano())
    
    N := 2000
    A := make([][]float64, N)
    B := make([][]float64, N)
    C := make([][]float64, N)
    
    // Inicializar matrices
    for i := range A {
        A[i] = make([]float64, N)
        B[i] = make([]float64, N)
        C[i] = make([]float64, N)
        for j := range A[i] {
            A[i][j] = rand.Float64()
            B[i][j] = rand.Float64()
        }
    }

    // Medir tiempo de inicio
    start := time.Now()
    
    // Multiplicación de matrices
    for i := 0; i < N; i++ {
        for j := 0; j < N; j++ {
            sum := 0.0
            for k := 0; k < N; k++ {
                sum += A[i][k] * B[k][j]
            }
            C[i][j] = sum
        }
    }
    
    // Calcular duración
    duration := time.Since(start)
    
    // Mostrar tiempo en diferentes formatos para mayor claridad
    fmt.Printf("Tiempo de ejecución:\n")
    fmt.Printf("En segundos: %.6f segundos\n", duration.Seconds())
    fmt.Printf("En milisegundos: %.2f ms\n", float64(duration.Milliseconds()))
    fmt.Printf("En microsegundos: %d µs\n", duration.Microseconds())
}
