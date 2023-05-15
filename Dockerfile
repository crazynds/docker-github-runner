FROM ubuntu:latest


COPY installdependencies.sh /tmp/installdependencies.sh

RUN chmod +x /tmp/installdependencies.sh
RUN apt update
RUN apt install curl -y
RUN /tmp/installdependencies.sh

RUN useradd -ms /bin/bash runner

# Create a folder && download && extract
RUN mkdir /actions-runner && chown runner.runner /actions-runner && \
	su runner && \
	cd /actions-runner && \
	curl -o /actions-runner/actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz


COPY run.sh /actions-runner/start.sh
COPY input /actions-runner/input
RUN chmod +x /actions-runner/start.sh
RUN chown runner /actions-runner/start.sh

RUN apt-get -y autoremove \
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /runner

USER runner


CMD cd /actions-runner && ./start.sh

