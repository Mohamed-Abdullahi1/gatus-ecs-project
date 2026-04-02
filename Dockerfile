FROM golang:1.25.5-alpine AS builder

WORKDIR /app

COPY app/go.mod app/go.sum ./
RUN go mod download

COPY app/ .
RUN go build -o gatus .

FROM alpine:latest
WORKDIR /app

RUN addgroup -S nonroot && adduser -S nonroot -G nonroot

COPY --from=builder /app/gatus .
COPY --from=builder /app/config ./config

RUN chown -R nonroot:nonroot /app

USER nonroot

EXPOSE 8080

CMD [ "./gatus" ]

