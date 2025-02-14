FROM alpine:latest
RUN apk add --no-cache g++ make
WORKDIR .
RUN g++ -o benchmark matrixMultiplication.cpp
CMD ["./benchmark"]
