
FROM alpine:latest

RUN apk add --no-cache g++ make

WORKDIR /app
COPY matrixMultiplication.cpp .

RUN g++ -O3 -o matrixMultiplication matrixMultiplication.cpp

CMD ["./matrixMultiplication"]
