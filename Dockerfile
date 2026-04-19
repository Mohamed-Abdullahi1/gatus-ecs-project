FROM golang:1.25.5-alpine AS builder

WORKDIR /app

COPY app/go.mod app/go.sum ./
RUN go mod download

COPY app/ ./
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o gatus .

FROM alpine:latest
WORKDIR /app

RUN addgroup -S nonroot && adduser -S nonroot -G nonroot

COPY --from=builder --chown=nonroot:nonroot /app/gatus .
COPY --from=builder --chown=nonroot:nonroot /app/config ./config

USER nonroot

EXPOSE 8080

CMD ["./gatus"]

