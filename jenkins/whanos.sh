#!/bin/bash

LAST_COMMIT=""

if test -f /usr/share/jenkins_hash/JENKINS_HASH_$1; then
    LAST_COMMIT=`cat /usr/share/jenkins_hash/JENKINS_HASH_$1`
fi
if [ "$LAST_COMMIT" != `git log -n 1  | grep commit | awk '{ print $2 }'` ]; then
    echo "Changes occured, contenarization needed"
    LANGUAGE=$(/var/jenkins_home/getLanguage.sh .)

    if [ $? -eq 1 ]; then
        echo "Error occured getting language"
        exit 1
    fi

    echo "Detected language: $LANGUAGE"
    if test -f "./Dockerfile"; then
        echo "Using base image"
        docker build . -t whanos-project-$1
    else
        echo "Using standalone image"
        docker build . -t whanos-project-$1 -f /images/$LANGUAGE/Dockerfile.standalone
    fi
    docker tag whanos-project-$1 localhost:5000/whanos-project-$1
    docker push localhost:5000/whanos-project-$1
    docker pull localhost:5000/whanos-project-$1
    docker rmi whanos-project-$1

    if test -f "./whanos.yml"; then
        echo "Deploying on kubernetes"
        FILE_CONTENT=`cat ./whanos.yml | base64 -w 0`
        curl -H "Content-Type: application/json" -X POST -d "{\"image\":\"localhost:5000/whanos-project-$1\",\"config\":\"$FILE_CONTENT\",\"name\":\"$1\"}" http://localhost:3030/deployments
    fi
    mkdir -p /usr/share/jenkins_hash
    echo `git log -n 1  | grep commit | awk '{ print $2 }'` > /usr/share/jenkins_hash/JENKINS_HASH_$1
else
    echo "No changes occured"
fi
