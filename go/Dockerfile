
FROM golang:alpine

WORKDIR /app
COPY matrixMultiplication.go .

RUN go build -o matrixMultiplication matrixMultiplication.go

CMD ["./matrixMultiplication"]
