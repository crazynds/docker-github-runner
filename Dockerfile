FROM ubuntu:lunar


COPY installdependencies.sh /tmp/installdependencies.sh

RUN chmod +x /tmp/installdependencies.sh
RUN apt update
RUN apt install curl git build-essential python3 -y

RUN apt install apt-transport-https ca-certificates curl software-properties-common -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu lunar stable"

RUN apt install docker-ce-cli -y
RUN /tmp/installdependencies.sh

# Create a folder && download && extract
RUN mkdir /actions-runner && \
	cd /actions-runner && \
	curl -o /actions-runner/actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz


COPY run.sh /actions-runner/start.sh
COPY input /actions-runner/input
RUN chmod +x /actions-runner/start.sh

RUN apt-get -y autoremove \
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /runner

USER root


CMD cd /actions-runner && ./start.sh

