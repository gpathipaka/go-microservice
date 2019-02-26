
#REF: https://docs.docker.com/engine/reference/builder/
#********************************************
# STEP 1 build executable binary go-microservice
#********************************************
FROM golang:alpine AS bilder
#Add Maintanier info
LABEL maintainer="Gangadhar Pathipaka"

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

#set the current working directory inside the container
WORKDIR /go/src/go-microservice

#copy everything from current directory to the PWD inside the container
COPY . .

#download all dependencies 
RUN go get -d -v ./...

#Build the Binary
#RUN go build -o /go/bin/go-microservice
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /go/bin/go-microservice
#*********************************
# STEP 2 build a small image 
#*********************************
FROM scratch

#Copy our static executable.
COPY --from=0 /go/bin/go-microservice /go/bin/go-microservice

EXPOSE 3000

#Run the go-microservice Binary
ENTRYPOINT [ "/go/bin/go-microservice" ]