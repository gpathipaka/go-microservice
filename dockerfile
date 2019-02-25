
############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git
WORKDIR /go/src/go-microservice
COPY . .
#RUN glide install
RUN CGO_ENABLED=0 GOOS=linux go build -a -tags go-microservice -o build/go-microservice .
#fetch dependencies
#using go get
#RUN go get -d -v
#RUN CGO_ENABLED=0 GOOS=linux go build  -o go-microservice/src
# Build the binary.
#RUN go build -o /go/bin/hello

FROM scratch
COPY --from=builder /go/src/go-microservice/build/go-microservice app
ENV PORT 3000
EXPOSE 3000
ENTRYPOINT ["/app"]


# FROM golang
# ADD . ./
# RUN go build -o main
# ENV PORT 3000
# EXPOSE 3000
# CMD [“/main”]