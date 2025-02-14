import time

def multiply_matrices(n):
    A = [[1] * n for _ in range(n)]
    B = [[1] * n for _ in range(n)]
    C = [[0] * n for _ in range(n)]

    for i in range(n):
        for j in range(n):
            for k in range(n):
                C[i][j] += A[i][k] * B[k][j]

n = 100
start_time = time.time()
multiply_matrices(n)
end_time = time.time()
print(f"Python: Multiplicación de matrices completada en {(end_time - start_time) * 1000:.2f} ms")
