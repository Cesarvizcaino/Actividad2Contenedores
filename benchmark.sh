#!/bin/bash

echo "=== Benchmark de Multiplicación de Matrices ==="

# Colores para la tabla
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Función para dibujar línea de la tabla
draw_line() {
    printf "+---------------+------------------+\n"
}

# Función para ejecutar benchmark
run_benchmark() {
    local lang=$1
    echo "Ejecutando benchmark para $lang..."
    
    # Ejecutar contenedor y capturar salida
    local output=$(docker run --rm "matrix-$lang" 2>&1)
    
    # Extraer tiempo según el lenguaje
    case $lang in
        "c++")
            echo "$output" | grep "Tiempo ejecución en C++" | awk '{print $5}'
            ;;
        "go")
            echo "$output" | grep "En milisegundos:" | awk '{print $3}'
            ;;
        "java")
            echo "$output" | grep "Tiempo de ejecución en Java:" | awk '{print $6}'
            ;;
        "javascript")
            echo "$output" | grep "Tiempo de ejecución en JavaScript:" | awk '{print $5}'
            ;;
        "python")
            echo "$output" | grep "Python:" | awk '{print $6}'
            ;;
    esac
}

# Construir imágenes
echo "Construyendo imágenes..."
for lang in c++ go java javascript python; do
    docker build -t "matrix-$lang" "./$lang"
done

# Array asociativo para almacenar resultados
declare -A results

# Ejecutar benchmarks
for lang in c++ go java javascript python; do
    results[$lang]=$(run_benchmark $lang)
done

# Mostrar resultados en tabla
echo -e "\n=== Resultados del Benchmark ===\n"
draw_line
printf "| %-13s | %-16s |\n" "Lenguaje" "Tiempo (ms)"
draw_line

# Ordenar resultados por tiempo
for lang in $(for k in "${!results[@]}"; do echo "$k ${results[$k]}"; done | sort -k2n); do
    name=${lang% *}
    time=${results[$name]}
    printf "| %-13s | %16.2f |\n" "$name" "$time"
done

draw_line
