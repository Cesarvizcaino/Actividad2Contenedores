#!/bin/bash

echo "=== Benchmark de Multiplicación de Matrices ==="

# Función para dibujar línea de la tabla
draw_line() {
    echo "+---------------+------------------+"
}

# Mostrar encabezado de la tabla
draw_line
echo "| Lenguaje       |     Tiempo (ms)   |"
draw_line

# C++
time_c=$(docker run --rm matrix-c | grep "Tiempo" | awk '{print $5}' | sed 's/ms//')
printf "| %-13s | %16s |\n" "C++" "$time_c"

# Go
time_go=$(docker run --rm matrix-go | grep "milisegundos:" | awk '{print $3}' | sed 's/ms//')
printf "| %-13s | %16s |\n" "Go" "$time_go"

# Java
time_java=$(docker run --rm matrix-java | grep "Java:" | awk '{print $6}' | sed 's/ms//')
printf "| %-13s | %16s |\n" "Java" "$time_java"

# JavaScript
time_js=$(docker run --rm matrix-javascript | grep "JavaScript:" | awk '{print $6}' | sed 's/ms//')
printf "| %-13s | %16s |\n" "JavaScript" "$time_js"

# Python
time_python=$(docker run --rm matrix-python | grep "Python:" | sed 's/.*completada en \([0-9.]*\) ms.*/\1/')
printf "| %-13s | %16s |\n" "Python" "$time_python"

draw_line
