#!/bin/bash

# Construir todas las imágenes
docker-compose build

# Ejecutar benchmark
docker-compose run --rm benchmark
