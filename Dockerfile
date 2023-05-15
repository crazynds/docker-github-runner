FROM debian:stable


COPY installdependencies.sh /tmp/installdependencies.sh

RUN chmod +x /tmp/installdependencies.sh
RUN apt update
RUN apt install curl -y
RUN /tmp/installdependencies.sh



# Create a folder
RUN mkdir /actions-runner && cd /actions-runner
# Download the latest runner package
RUN curl -o actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz
# Extract the installer
RUN tar xzf ./actions-runner-linux-x64-2.304.0.tar.gz

COPY run.sh /actions-runner/run.sh
RUN chmod +x /actions-runner/run.sh

RUN apt-get -y autoremove \
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER root


CMD /actions-runner/run.sh

