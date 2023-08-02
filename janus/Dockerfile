FROM alpine:latest

RUN apk add openjdk11 bash
RUN apk --no-cache add procps envsubst

RUN mkdir /app
COPY . /app
WORKDIR /app

CMD ["bash", "docker-entrypoint.sh"]
