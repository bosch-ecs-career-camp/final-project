#!/bin/bash

export location="westeurope"
export resourceGroup="stream4-rg"
export acrName="stream4acr"

az group create -l $location -n $resourceGroup 

az acr create --resource-group $resourceGroup \
  --name $acrName --sku Basic \
  --admin-enabled true 

ACR_PASS=`az acr credential show -n $acrName --query passwords[0].value`

subscr_ID=`az account show --query id --output tsv`
az ad sp create-for-rbac \
--name final-project --role Contributor \
--scopes /subscriptions/$subscr_ID/resourceGroups/$resourceGroup \
--sdk-auth
echo ""
echo -e "Json output shoud be added as github secret /AZURE_CREDENTIALS/\n"
echo "This password: $ACR_PASS shoud be added as github secret /REG_PASS/"