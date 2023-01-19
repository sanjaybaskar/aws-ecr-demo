FROM golang:1.19-buster AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN go build  -o /aws-ecr-demo

FROM gcr.io/distroless/base-debian

WORKDIR /

COPY --from=build /aws-ecr-demo /aws-ecr-demo

USER nonroot:nonroot

ENTRYPOINT [ "/aws-ecr-demo" ]