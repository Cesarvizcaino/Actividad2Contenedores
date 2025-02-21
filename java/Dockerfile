
FROM alpine:latest

RUN apk add --no-cache openjdk11

WORKDIR /app
COPY matrixMultiplication.java .

RUN javac matrixMultiplication.java

CMD ["java", "matrixMultiplication"]
