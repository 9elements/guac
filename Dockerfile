FROM golang:alpine AS builder

WORKDIR /app

RUN apk update && apk add --no-cache git

COPY . .

RUN cd cmd/guac && \
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -buildvcs=false -o /go/bin/guac

FROM golang AS runner

COPY --from=builder /go/bin/guac /bin/guac

EXPOSE 4567/tcp

CMD ["/bin/guac"]
