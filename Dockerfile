FROM debian:stable


COPY installdependencies.sh /tmp/installdependencies.sh

RUN chmod +x /tmp/installdependencies.sh
RUN apt update
RUN apt install curl -y
RUN /tmp/installdependencies.sh



# Create a folder && download && extract
RUN mkdir /actions-runner && \
	cd /actions-runner && \
	curl -o /actions-runner/actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz && \
	tar xzf ./actions-runner-linux-x64-2.304.0.tar.gz && \
	ls -l


COPY run.sh /actions-runner/run.sh
RUN chmod +x /actions-runner/run.sh

RUN apt-get -y autoremove \
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN useradd -ms /bin/bash runner
RUN chown runner.runner /actions-runner -R


USER runner


CMD cd /actions-runner && ./run.sh

