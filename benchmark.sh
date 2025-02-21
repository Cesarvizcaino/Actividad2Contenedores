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
            time=$(echo "$output" | grep "Tiempo" | awk '{print $NF}')
            ;;
        "go")
            time=$(echo "$output" | grep "milisegundos" | awk '{print $NF}')
            ;;
        "java")
            time=$(echo "$output" | grep "Tiempo" | awk '{print $NF}')
            ;;
        "javascript")
            time=$(echo "$output" | grep "Tiempo" | awk '{print $NF}')
            ;;
        "python")
            time=$(echo "$output" | grep "Tiempo" | awk '{print $NF}')
            ;;
    esac
    
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
    if [[ ! -z "${results[$lang]}" ]]; then
        printf "| %-13s | %16.2f |\n" "$lang" "${results[$lang]}"
    fi
done

draw_line
