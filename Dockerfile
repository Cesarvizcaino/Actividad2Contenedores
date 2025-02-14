FROM alpine:latest 
RUN apk add --no-cache docker
WORKDIR .
COPY . .
RUN echo '#!/bin/sh' > run_benchmarks.sh && \
echo 'echo "=== Iniciando ejecucion de benchmarks ==="' >> run_benchmarks.sh && \
echo 'echo "\n-> Ejecutando benchmark python..."' >> run_benchmarks.sh && \
echo 'cd ../python && docker build -t python-benchmark . && docker run --rm python-benchmark' >> run_benchmarks.sh && \
echo 'echo "\n-> Ejecutando benchmark Java..."' >> run_benchmarks.sh && \
echo 'cd ../Java && docker build -t java-benchmark . && docker run --rm java-benchmark' >> run_benchmarks.sh && \
echo 'echo "\n-> Ejecutando benchmark Javascript..."' >> run_benchmarks.sh && \
echo 'cd ../Javascript && docker build -t js-benchmark . && docker run --rm js-benchmark' >> run_benchmarks.sh && \
echo 'echo "\n-> Ejecutando benchmark C..."' >> run_benchmarks.sh && \
echo 'cd ../c && docker build -t c-benchmark . && docker run --rm c-benchmark' >> run_benchmarks.sh && \
echo 'echo "\n-> Ejecutando benchmark go..."' >> run_benchmarks.sh && \
echo 'cd ../go && docker build -t go-benchmark . && docker run --rm go-benchmark' >> run_benchmarks.sh && \
echo 'echo "\n=== Finalizacion de benchmarks ==="' >> run_benchmarks.sh && \
chmod +x run_benchmarks.sh
CMD ["./run_benchmarks.sh"]
 
