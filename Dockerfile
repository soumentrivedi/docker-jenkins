FROM phusion/baseimage:0.9.11
MAINTAINER Soumen Trivedi "soumen.trivedi@ericsson.com"

ENV HOME /root
ENV JENKINS_HOME /jenkins
RUN mkdir /scripts
ADD ./scripts /scripts
RUN /scripts/setup.sh
RUN /scripts/configureGit.sh
RUN /scripts/setupJenkins.sh
RUN /scripts/configureJenkinsPlugins.sh

# Enable SSH always
RUN /usr/sbin/enable_insecure_key
CMD [""]

EXPOSE 22 3000 8080
ENTRYPOINT /bin/bash



