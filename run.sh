
#!/bin/bash

# Limpiar contenedores e imágenes previas
docker-compose down --rmi all 2>/dev/null

# Construir todas las imágenes
docker-compose build

# Ejecutar benchmark
docker-compose run --rm benchmark
