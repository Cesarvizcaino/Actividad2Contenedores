#!/bin/bash

echo "=== Benchmark de Multiplicación de Matrices ==="

# Lista de lenguajes
languages=("c" "go" "java" "javascript" "python")

# Construir y ejecutar cada contenedor
for lang in "${languages[@]}"; do
    echo -e "\n=== Ejecutando $lang ==="
    docker build -t matrix-$lang ./$lang
    docker run --rm matrix-$lang
done

echo -e "\n=== Benchmark Completado ==="
