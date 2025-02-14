FROM alpine:latest
RUN apk add --no-cache openjdk11
WORKDIR .
RUN javac matrixMultiplication.java
CMD["java", "matrixMultiplication"]
