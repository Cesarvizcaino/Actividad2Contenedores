# Benchmark de soluciones en contenedores
## Integrantes:
+ Carlos Herrera
+ Cristian Vizcaino
## Descripcion: 
nos valemos de dockerfiles, para preparar contenedores
con el fin de hacer un benchmark de cuanto tardan distintos 
lenguajes en ejecutar la multiplicacion de 2 matrices 100x100
## Mejora:
se usa docker compose para que la construccion del entorno de ejecucion sea mucho mas automatizada y elimine la necesidad de usar comandos para docker run individuales, de tal manera estan mejor configurados los contenedores y nos aseguramos de que se construyan de manera consistente. el impacto de usar docker compose se evidencia en los tiempos de preparacion del entorno y en la confirmacion de que estos mismos estan teniendo exito.
## Lenguajes
+ Java
+ Python
+ Javascript
+ Go
+ c++
## Instalacion:
> todos los comandos para una terminal Alpine linux
1. abrir terminal linux
> ahora comandos de instalacion y ejecucion
1. apk add git
2. git clone https://github.com/Cesarvizcaino/Actividad2Contenedores.git
3. cd Actividad2Contenedores
4. chmod +x benchmark.sh run.sh
5. ./run.sh
