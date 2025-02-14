FROM alpine:latest
RUN apk add --no-cache go
WORKDIR /app
RUN go build -o benchmark
CMD ["./benchmark"]
