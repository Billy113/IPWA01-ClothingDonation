# syntax=docker/dockerfile:1

FROM golang:1.23 as build

WORKDIR /app

ADD ./ .
RUN apt-get install make -y
RUN go install github.com/a-h/templ/cmd/templ@latest
RUN go install github.com/air-verse/air@latest
RUN go mod download
RUN apt-get install make -y
RUN go install github.com/a-h/templ/cmd/templ@latest
RUN go install github.com/air-verse/air@latest
RUN make build

FROM gcr.io/distroless/base AS build-release-stage
WORKDIR /
COPY --from=build /app/bin/main /main
EXPOSE 8080

ENTRYPOINT ["/main"]
