#!/bin/bash

# Crear directorio temporal para el benchmark
TEMP_DIR=$(mktemp -d)
echo "Creando ambiente en: $TEMP_DIR"

# Copiar todos los archivos necesarios al directorio temporal
cp -r * "$TEMP_DIR/"

# Ir al directorio temporal
cd "$TEMP_DIR"

# Asegurarse de que los archivos de código fuente tienen los nombres correctos
for dir in c go java javascript python; do
    if [ -d "$dir" ]; then
        cd "$dir"
        # Renombrar el archivo si existe y no tiene el nombre correcto
        for file in *; do
            case "$dir" in
                "c")
                    if [ "$file" != "matrixMultiplication.cpp" ]; then
                        mv "$file" "matrixMultiplication.cpp"
                    fi
                    ;;
                "go")
                    if [ "$file" != "matrixMultiplication.go" ]; then
                        mv "$file" "matrixMultiplication.go"
                    fi
                    ;;
                "java")
                    if [ "$file" != "matrixMultiplication.java" ]; then
                        mv "$file" "matrixMultiplication.java"
                    fi
                    ;;
                "javascript")
                    if [ "$file" != "matrixMultiplication.js" ]; then
                        mv "$file" "matrixMultiplication.js"
                    fi
                    ;;
                "python")
                    if [ "$file" != "matrixMultiplication.py" ]; then
                        mv "$file" "matrixMultiplication.py"
                    fi
                    ;;
            esac
        done
        cd ..
    fi
done

# Limpiar contenedores e imágenes previas
docker-compose down --rmi all 2>/dev/null

# Construir todas las imágenes
echo "Construyendo imágenes Docker..."
docker-compose build

# Ejecutar benchmark
echo "Ejecutando benchmark..."
docker-compose run --rm benchmark

# Limpiar después de la ejecución
cd ..
rm -rf "$TEMP_DIR"
