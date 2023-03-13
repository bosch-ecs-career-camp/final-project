#!/bin/bash

#docker build --build-arg RUNNER_VERSION=2.302.0 .
token=$PAT
orgName=bosch-ecs-career-camp
repoName=final-project
imageName=runner:v1


docker run -e GH_TOKEN=$token -e GH_OWNER=$orgName -e GH_REPOSITORY=$repoName -d $imageName


res=`az acr list --query "[?name=='stream4bosch']"`
if [[ ${#res} -gt 3 ]]; then echo ok ; fi


acrLength=`az acr list --query "[?name=='stream4bosvch']"`
[[ ${#acrLength} -gt 3 ]] && echo "acr exist" || \
az acr create --resource-group $resourceGroup \
  --name $acrName --sku Basic