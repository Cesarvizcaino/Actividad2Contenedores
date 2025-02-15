FROM docker:latest
WORKDIR /app
COPY . .
RUN apk add --no-cache bash
RUN chmod +x benchmark.sh
CMD ["./benchmark.sh"]
 
