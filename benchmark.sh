#!/bin/bash

echo "=== Benchmark de Multiplicación de Matrices ==="

# Función para dibujar línea de la tabla
draw_line() {
    printf "+---------------+------------------+\n"
}

# Función para extraer tiempo
extract_time() {
    local output=$1
    local time
    
    if echo "$output" | grep -q "C++:"; then
        time=$(echo "$output" | grep "C++:" | awk '{print $5}' | sed 's/ms//')
    elif echo "$output" | grep -q "milisegundos:"; then
        time=$(echo "$output" | grep "milisegundos:" | awk '{print $3}' | sed 's/ms//')
    elif echo "$output" | grep -q "Java:"; then
        time=$(echo "$output" | grep "Java:" | awk '{print $6}' | sed 's/ms//')
    elif echo "$output" | grep -q "JavaScript:"; then
        time=$(echo "$output" | grep "JavaScript:" | awk '{print $6}' | sed 's/ms//')
    elif echo "$output" | grep -q "Python:"; then
        time=$(echo "$output" | grep "Python:" | sed 's/.*completada en \([0-9.]*\) ms.*/\1/')
    fi
    
    echo "$time"
}

# Asegurarse de que las imágenes estén construidas
echo "Construyendo imágenes..."
docker-compose build

# Mostrar encabezado de la tabla
echo -e "\nResultados:\n"
draw_line
printf "| %-13s | %16s |\n" "Lenguaje" "Tiempo (ms)"
draw_line

# Ejecutar cada benchmark
for lang in c go java javascript python; do
    echo "Ejecutando benchmark para $lang..."
    output=$(docker run --rm "matrix-$lang" 2>&1)
    if [ $? -eq 0 ]; then
        time=$(extract_time "$output")
        if [ ! -z "$time" ]; then
            printf "| %-13s | %16s |\n" "$lang" "$time"
        else
            printf "| %-13s | %16s |\n" "$lang" "ERROR"
        fi
    else
        printf "| %-13s | %16s |\n" "$lang" "ERROR"
    fi
done

draw_line
