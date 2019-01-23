FROM golang:1.9-alpine

RUN apk update \
 && apk add git make g++

RUN go get -v github.com/getamis/istanbul-tools/cmd/istanbul
