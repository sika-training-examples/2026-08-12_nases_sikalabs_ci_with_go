# Up
docker network create counter
docker build -t counter .
docker run -d --name redis --net counter redis
docker run -d --name counter --net counter -p 80:80 counter

# Down
docker stop counter
docker stop redis
docker rm counter
docker rm redis
docker network rm counter
