import numpy as np
import time

def matrix_multiply():
    N = 2000
    A = np.random.rand(N, N)
    B = np.random.rand(N, N)

    start_time = time.time()
    C = np.dot(A, B)
    end_time = time.time()

    print(f"Tiempo de ejecución en Python: {end_time - start_time} segundos")

matrix_multiply()
