#!/bin/bash

export location="westeurope"
export resourceGroup="images"
export acrName=stream4bosch

acrLength=`az acr list --query "[?name=='stream4bosch']"`
[[ ${#acrLength} -gt 3 ]] && echo "acr exist" || \
az acr create --resource-group $resourceGroup \
  --name $acrName --sku Basic


