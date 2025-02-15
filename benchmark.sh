#!/bin/bash

echo "=== Benchmark de Multiplicación de Matrices ==="

# Lista de lenguajes
languages=("c" "go" "java" "javascript" "python")

# Array asociativo para almacenar los tiempos
declare -A times

# Función para extraer el tiempo de la salida según el lenguaje
extract_time() {
    local output=$1
    local lang=$2
    case $lang in
        "c")
            echo "$output" | grep "Tiempo ejecución en C++" | awk '{print $5}'
            ;;
        "go")
            echo "$output" | grep "En milisegundos:" | awk '{print $3}'
            ;;
        "java")
            echo "$output" | grep -o '[0-9]\+\.[0-9]* ms' | grep -o '[0-9]\+\.[0-9]*'
            ;;
        "javascript")
            echo "$output" | grep -o '[0-9]\+\.[0-9]* ms' | grep -o '[0-9]\+\.[0-9]*'
            ;;
        "python")
            echo "$output" | grep -o '[0-9]\+\.[0-9]* ms' | grep -o '[0-9]\+\.[0-9]*'
            ;;
    esac
}

# Construir y ejecutar cada contenedor
for lang in "${languages[@]}"; do
    echo -e "\n=== Ejecutando $lang ==="
    docker build -t matrix-$lang ./$lang
    result=$(docker run --rm matrix-$lang)
    echo "$result"
    time=$(extract_time "$result" "$lang")
    times[$lang]=$time
done

# Imprimir tabla de resultados
echo -e "\n=== Tabla Comparativa ==="
echo "+--------------+-----------------+"
echo "| Lenguaje     | Tiempo (ms)    |"
echo "+--------------+-----------------+"
for lang in "${languages[@]}"; do
    printf "| %-12s | %13.2f |\n" "$lang" "${times[$lang]}"
done
echo "+--------------+-----------------+"

echo -e "\n=== Benchmark Completado ==="
