FROM alpine:3.18


RUN apk add --no-cache g++ make


WORKDIR /app


COPY matrixMultiplication.cpp .


RUN g++ -o matrixMultiplication matrixMultiplication.cpp
RUN chmod +x matrixMultiplication
# Comando para ejecutar el programa
CMD ["./matrixMultiplication"]
