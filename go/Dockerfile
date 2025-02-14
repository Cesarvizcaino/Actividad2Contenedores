
FROM golang:1.21-alpine
WORKDIR /app


COPY matrixMultiplication.go .


RUN go build -o matrixMultiplication matrixMultiplication.go


CMD ["./matrixMultiplication"]
