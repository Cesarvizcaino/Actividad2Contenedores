# Benchmark de soluciones en contenedores
## Integrantes:
+ Carlos Herrera
+ Cristian Vizcaino
## Descripcion: 
nos valemos de dockerfiles, para preparar contenedores
con el fin de hacer un benchmark de cuanto tardan distintos 
lenguajes en ejecutar la multiplicacion de 2 matrices 100x100
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
4. docker build -t benchmark-test .
5. docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock benchmark-test
