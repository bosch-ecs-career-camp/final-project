FROM ubuntu:22.04

ARG RUNNER_VERSION=2.302.1
ARG DEBIAN_FRONTEND=noninteractive

LABEL Author="Sotirov"
LABEL Email="sotirov.sasho@gmail.com"
LABEL BaseImage="ubuntu:22.04"
LABEL RunnerVersion=${RUNNER_VERSION}

RUN apt-get update -y && apt-get upgrade -y && useradd -m ghub
RUN apt-get install -y --no-install-recommends curl nodejs wget unzip vim git \
    build-essential libssl-dev libffi-dev python3 jq python3-venv python3-dev python3-pip
RUN cd /home/ghub && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN chown -R ghub ~ghub && /home/ghub/actions-runner/bin/installdependencies.sh

ADD scripts/start.sh start.sh

RUN chmod +x start.sh

USER ghub

ENTRYPOINT ["./start.sh"]