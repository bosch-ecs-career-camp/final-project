#!/bin/bash

export location="westeurope"
export resourceGroup="final-project"
export acrName=stream4bosch

acrLength=`az acr list --query "[?name=='stream4bosch']"`
[[ ${#acrLength} -gt 3 ]] && echo "acr exist" || \
az acr create --resource-group $resourceGroup \
  --name $acrName --sku Basic \
  --admin-enabled true 


