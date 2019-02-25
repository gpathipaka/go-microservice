
#build docker image
docker build -t go-micro .

#Run the docker image
docker run -p 3000:3000 go-micro .
