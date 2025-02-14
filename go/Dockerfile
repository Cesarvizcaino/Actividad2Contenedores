FROM alpine:latest
RUN apk add --no-cache go
WORKDIR .
RUN go build -o benchmark
CMD ["./benchmark"]
