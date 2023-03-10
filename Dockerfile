# base image
FROM ubuntu:20.04
RUN tail -f

#input GitHub runner version argument
# ARG RUNNER_VERSION
# ARG DEBIAN_FRONTEND=noninteractive

# LABEL Author="Sotirov"
# LABEL Email="sotirov.sasho@gmail.com"
# LABEL BaseImage="ubuntu:22.04"
# LABEL RunnerVersion=${RUNNER_VERSION}

## update the base packages + add a non-sudo user
#RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

# install the packages and dependencies along with jq so we can parse JSON (add additional packages as necessary)
#RUN apt-get install -y --no-install-recommends curl 

# cd into the user directory, download and unzip the github actions runner
#RUN cd /home/docker && mkdir actions-runner && cd actions-runner
#RUN curl -O -L https://github.com/actions/runner/releases/download/v2.302.1/actions-runner-linux-x64-2.302.1.tar.gz
#RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# install some additional dependencies
#RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

# add over the start.sh script
#ADD scripts/start.sh start.sh

# make the script executable
#RUN chmod +x start.sh

# set the user to "docker" so all subsequent commands are run as the docker user
#USER docker

# set the entrypoint to the start.sh script
#ENTRYPOINT ["./start.sh"]