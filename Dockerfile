# syntax=docker/dockerfile:1

FROM godev

WORKDIR /app

RUN apt-get install make -y
RUN go install github.com/a-h/templ/cmd/templ@latest
RUN go install github.com/air-verse/air@latest

COPY go.mod go.sum Makefile tailwindcss ./
COPY cmd ./cmd
ADD static static 
ADD internal internal
RUN go mod download
RUN apt-get install make -y
RUN go install github.com/a-h/templ/cmd/templ@latest
RUN go install github.com/air-verse/air@latest
COPY *.go ./
RUN make build
RUN chmod +x bin/main

EXPOSE 8080

CMD [ "./bin/main"]
