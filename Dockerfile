FROM alpine:latest

# Instalar dependencias necesarias
RUN apk add --no-cache \
    bash \
    docker \
    docker-compose \
    jq \
    ncurses

# Copiar script de benchmark
COPY benchmark.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/benchmark.sh

WORKDIR /benchmark
CMD ["benchmark.sh"]
 
