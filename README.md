
#build docker image
docker build -t go-micro .

#Run the docker image
docker run -p 3000:3000 go-micro .

#generate grpc protobuf
protoc --go_out=plugins=grpc:. proto/consignment/consignment.proto

#Generate go-micro protobuf.
protoc -I. --go_out=plugins=micro:. proto/consignment/consignment.proto




#RUN Micro Service Docker Image
 docker run -p 8080:8080 \
> -e MICRO_SERVER_ADDRESS=:8080 \
> -e MICRO_REGISTRY=mdns go-docker
2019/02/26 11:16:07 Server starting.......
2019/02/26 11:16:07 Transport [http] Listening on [::]:8080
2019/02/26 11:16:07 Broker [http] Connected to [::]:40383
2019/02/26 11:16:07 Registry [mdns] Registering node: go.micro.srv.consignment-52566079-408c-4cdb-99e5-88a9de9ebf86

