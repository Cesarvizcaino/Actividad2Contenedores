#!/bin/bash

echo "=== Benchmark de Multiplicación de Matrices ==="

# Función para dibujar línea de la tabla
draw_line() {
    printf "+---------------+------------------+\n"
}

# Función para ejecutar benchmark y extraer tiempo
run_benchmark() {
    local lang=$1
    echo "Ejecutando benchmark para $lang..."
    
    local output=$(docker run --rm "matrix-$lang" 2>&1)
    local time
    
    case $lang in
        "c++")
            time=$(echo "$output" | grep "Tiempo ejecución en C++" | awk '{print $5}')
            ;;
        "go")
            time=$(echo "$output" | grep "En milisegundos:" | awk '{print $3}')
            ;;
        "java")
            time=$(echo "$output" | grep "Tiempo de ejecución en Java:" | awk '{print $6}')
            ;;
        "javascript")
            time=$(echo "$output" | grep "Tiempo de ejecución en JavaScript:" | awk '{print $5}')
            ;;
        "python")
            time=$(echo "$output" | grep "Python:" | awk '{print $6}')
            ;;
    esac
    
    echo "$time"
}

# Construir imágenes
echo "Construyendo imágenes..."
for lang in c go java javascript python; do
    docker build -t "matrix-$lang" "./$lang"
done

# Array asociativo para almacenar resultados
declare -A results

# Ejecutar benchmarks
for lang in c go java javascript python; do
    results[$lang]=$(run_benchmark $lang)
done

# Mostrar resultados en tabla
echo -e "\n=== Resultados del Benchmark ===\n"
draw_line
printf "| %-13s | %-16s |\n" "Lenguaje" "Tiempo (ms)"
draw_line

# Ordenar y mostrar resultados
for lang in $(for k in "${!results[@]}"; do echo "$k ${results[$k]}"; done | sort -k2n); do
    name=${lang% *}
    time=${results[$name]}
    if [[ ! -z "$time" ]]; then
        printf "| %-13s | %16.2f |\n" "$name" "$time"
    fi
done

draw_line
