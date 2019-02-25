
############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder
# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

#$GOPATH set to ../../go. work dir must be set from /go/src/....
WORKDIR /go/src/go-microservice

COPY . .

#RUN glide install
RUN CGO_ENABLED=0 GOOS=linux go build -a -tags go-microservice -o build/go-microservice .
#fetch dependencies
#using go get
#RUN go get -d -v
# Build the binary.
#RUN go build -o /go/bin/hello

############################
# STEP 2 build a small image
############################
FROM scratch
# Copy our static executable.
COPY --from=builder /go/src/go-microservice/build/go-microservice app
ENV PORT 3000
EXPOSE 3000
#RUN THE Bindary.
ENTRYPOINT ["/app"]
