#!/bin/bash

echo "=== Benchmark de Multiplicación de Matrices ==="

# Función para dibujar línea de la tabla
draw_line() {
    echo "+---------------+------------------+"
}

# Función para ejecutar benchmark y extraer tiempo
run_benchmark() {
    local lang=$1
    local output=$(docker run --rm "matrix-$lang" 2>&1)
    local time
    
    case $lang in
        "c")
            time=$(echo "$output" | grep "Tiempo ejecución en C++" | awk '{print $5}')
            ;;
        "go")
            time=$(echo "$output" | grep "En milisegundos:" | awk '{print $3}')
            ;;
        "java")
            time=$(echo "$output" | grep "Tiempo de ejecución en Java:" | awk '{print $6}')
            ;;
        "javascript")
            time=$(echo "$output" | grep "Tiempo de ejecución en JavaScript:" | awk '{print $6}')
            ;;
        "python")
            time=$(echo "$output" | grep "Python:" | sed 's/.*completada en \([0-9.]*\) ms.*/\1/')
            ;;
    esac
    
    # Eliminar "ms" si está presente
    time=$(echo "$time" | sed 's/ms//')
    echo "$time"
}

# Ejecutar benchmarks y almacenar resultados
declare -A times

# Mostrar resultados en tabla
echo -e "\n=== Resultados del Benchmark ===\n"
draw_line
echo "| Lenguaje       |     Tiempo (ms)   |"
draw_line

# Ejecutar cada benchmark y mostrar resultado inmediatamente
for lang in c go java javascript python; do
    time=$(run_benchmark $lang)
    if [ ! -z "$time" ]; then
        printf "| %-13s | %16.2f |\n" "$lang" "$time"
    else
        printf "| %-13s | %16s |\n" "$lang" "ERROR"
    fi
done

draw_line
