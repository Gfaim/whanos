#!/bin/bash

docker rm -f `docker ps -aq | head -n 2`
docker rmi -f `docker images whanos-jenkins -q`
docker rm -f whanos-registry
docker rmi -f `docker images localhost:5000/whanos-project* -q`
kill -9 `jobs -ps`
fuser -k 8080/tcp
fuser -k 3030/tcp
