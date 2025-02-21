version: '3.8'

services:
  benchmark:
    build: .
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - .:/benchmark
    privileged: true

  c:
    build: ./c
    image: matrix-c

  go:
    build: ./go
    image: matrix-go

  java:
    build: ./java
    image: matrix-java

  javascript:
    build: ./javascript
    image: matrix-javascript

  python:
    build: ./python
    image: matrix-python
