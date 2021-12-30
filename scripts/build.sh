#!/bin/bash

./kubernetes/kubeapi &
echo '{ "insecure-registries":    ["localhost:5000"] }' | sudo -u root tee /etc/docker/daemon.json
sudo -u root systemctl restart docker
sudo -u root rm -rf jenkins/ && git checkout jenkins/
docker build . -f jenkins/Dockerfile -t whanos-jenkins
cd jenkins && docker run -d -v $(pwd):/var/jenkins_home -v $(pwd)/../images:/images --net=host -v /var/run/docker.sock:/var/run/docker.sock `docker images -aq | head -n 1`
cd .. && docker exec -it `docker ps -aq | head -n 1` docker run -d -p 5000:5000 --restart=always --name whanos-registry registry:2 && docker exec -it `docker ps -aq | head -n 2 | tail -n +2` /bin/bash