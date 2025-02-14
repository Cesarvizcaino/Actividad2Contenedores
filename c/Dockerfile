FROM alpine:latest
RUN apk add --no-cache g++ make
WORKDIR /app
RUN g++ -o benchmark matrixMultiplication.cpp
CMD ["./benchmark"]
