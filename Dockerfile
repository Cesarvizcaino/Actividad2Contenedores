FROM docker:latest
WORKDIR .
COPY . .
RUN chmod +x benchmark.sh
CMD ["./benchmark.sh"]
 
