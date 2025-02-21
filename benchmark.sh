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
            time=$(echo "$output" | grep "Tiempo" | awk '{print $5}' | tr -d 'ms')
            ;;
        "go")
            time=$(echo "$output" | grep "milisegundos:" | awk '{print $2}' | tr -d 'ms')
            ;;
        "java")
            time=$(echo "$output" | grep "Java:" | awk '{print $6}' | tr -d 'ms')
            ;;
        "javascript")
            time=$(echo "$output" | grep "JavaScript:" | awk '{print $5}' | tr -d 'ms')
            ;;
        "python")
            time=$(echo "$output" | grep "Python:" | sed 's/.*completada en \([0-9.]*\) ms.*/\1/')
            ;;
    esac
    
    echo "$time"
}

# Mostrar resultados en tabla
echo -e "\n=== Resultados del Benchmark ===\n"
draw_line
echo "| Lenguaje       |     Tiempo (ms)   |"
draw_line

# Ejecutar cada benchmark y mostrar resultado inmediatamente
for lang in c go java javascript python; do
    time=$(run_benchmark $lang)
    if [[ $time =~ ^[0-9.]+$ ]]; then
        printf "| %-13s | %16.2f |\n" "$lang" "$time"
    else
        printf "| %-13s | %16s |\n" "$lang" "ERROR"
    fi
done

draw_line
