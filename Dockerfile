FROM golang:1.21.5-alpine3.19 AS builder
WORKDIR /src
COPY . .
RUN apk add --no-cache make && \
    make

FROM scratch as runtime
ENV PORT=8080
WORKDIR /app
COPY --from=builder /src/dist/app .
RUN apk add --no-cache curl
HEALTHCHECK --interval=10s --timeout=5s CMD curl --fail http://localhost:${PORT}/healthcheck
EXPOSE ${PORT}

ENTRYPOINT ["./app"]
