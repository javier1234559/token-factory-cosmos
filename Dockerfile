# Build stage
FROM golang:1.23-alpine AS builder
RUN apk add --no-cache git make jq
WORKDIR /app
COPY . .
RUN make install

# Final stage
FROM alpine:latest
RUN apk add --no-cache jq

# Copy binary từ builder
COPY --from=builder /go/bin/tokenfactoryd /usr/local/bin/

# Thiết lập working directory
WORKDIR /root

# Thiết lập entrypoint (nếu cần)
CMD ["sh"]