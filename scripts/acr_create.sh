#!/bin/bash

export location="westeurope"
export resourceGroup="stream4-rg"
export acrName="stream4-acr"

acrLength=`az acr list --query "[?name=='$acrName']"`
[[ ${#acrLength} -gt 3 ]] && echo "acr exist" || \
az acr create --resource-group $resourceGroup \
  --name $acrName --sku Basic \
  --admin-enabled true 


# acr password login shoud be added as github secret /REG_PASS/
# az acr credential show -n $acrName --query passwords[0].value