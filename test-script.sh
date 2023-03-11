#!/bin/bash

#docker build --build-arg RUNNER_VERSION=2.302.0 .
token=$PAT
orgName=bosch-ecs-career-camp
repoName=final-project
imageName=runner:v1


docker run -e GH_TOKEN=$token -e GH_OWNER=$orgName -e GH_REPOSITORY=$repoName -d $imageName
