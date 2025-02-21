#!/bin/bash

# Verificar que estamos en el directorio correcto
if [ ! -f "docker-compose.yml" ]; then
    echo "Error: Ejecuta este script desde el directorio raíz del proyecto"
    exit 1
fi

# Limpiar contenedores e imágenes previas
echo "Limpiando ambiente anterior..."
docker-compose down --rmi all 2>/dev/null

# Construir y ejecutar
echo "Iniciando benchmark..."
docker-compose run --rm benchmark
