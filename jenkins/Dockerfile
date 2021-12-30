FROM jenkins/jenkins:lts

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

USER root

#install docker 
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy curl && \
    curl -sSL https://get.docker.com/ | sh

ENV ADMIN_PASSWORD=test 

ENV CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins.yml

COPY ./jenkins/plugins.txt /usr/share/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/plugins.txt