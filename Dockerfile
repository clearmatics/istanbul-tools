FROM golang:1.9-alpine

RUN apk update \
 && apk add bash python git make g++ --no-cache

RUN go get -v github.com/getamis/istanbul-tools/cmd/istanbul

ADD entrypoint.sh .
ADD write_genesis.py .

ENTRYPOINT ["./entrypoint.sh"]
CMD []