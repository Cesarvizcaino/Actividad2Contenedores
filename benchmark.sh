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
    
    # Verificar si la imagen existe
    if ! docker image inspect "matrix-$lang" >/dev/null 2>&1; then
        echo "Error: Imagen matrix-$lang no encontrada"
        return 1
    fi
    
    local output=$(docker run --rm "matrix-$lang" 2>&1)
    local time
    
    case $lang in
        "c")
            # "Tiempo ejecución en C++: X ms"
            time=$(echo "$output" | grep "Tiempo ejecución en C++" | awk '{print $5}')
            ;;
        "go")
            # "En milisegundos: X.XX ms"
            time=$(echo "$output" | grep "En milisegundos:" | awk '{print $3}')
            ;;
        "java")
            # "Tiempo de ejecución en Java: X ms"
            time=$(echo "$output" | grep "Tiempo de ejecución en Java:" | awk '{print $6}')
            ;;
        "javascript")
            # "Tiempo de ejecución en JavaScript: X ms"
            time=$(echo "$output" | grep "Tiempo de ejecución en JavaScript:" | awk '{print $5}')
            ;;
        "python")
            # "Python: Multiplicación de matrices completada en X.XX ms"
            time=$(echo "$output" | grep "Python:" | awk '{print $(NF-1)}')
            ;;
    esac
    
    # Si no se encontró el tiempo, mostrar el output para debug
    if [ -z "$time" ]; then
        echo "Debug - Output completo para $lang:"
        echo "$output"
        return 1
    fi
    
    echo "$time"
}

# Verificar que estamos en el directorio correcto
if [ ! -f "docker-compose.yml" ]; then
    echo "Error: No se encuentra docker-compose.yml"
    exit 1
fi

# Construir imágenes
echo "Construyendo imágenes..."
docker-compose build

# Array asociativo para almacenar resultados
declare -A results

# Ejecutar benchmarks
for lang in c go java javascript python; do
    echo "Ejecutando $lang..."
    results[$lang]=$(run_benchmark $lang)
done

# Mostrar resultados en tabla
echo -e "\n=== Resultados del Benchmark ===\n"
draw_line
printf "| %-13s | %-16s |\n" "Lenguaje" "Tiempo (ms)"
draw_line

# Ordenar y mostrar resultados
for lang in "${!results[@]}"; do
    if [[ ! -z "${results[$lang]}" && "${results[$lang]}" != *"Debug"* ]]; then
        # Eliminar "ms" del final si existe
        time_value=${results[$lang]%% ms}
        printf "| %-13s | %16.2f |\n" "$lang" "$time_value"
    fi
done

draw_line
