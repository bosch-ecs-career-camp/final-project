#!/bin/bash

export location="westeurope"
export resourceGroup="final-project"
export acrName=stream4bosch

az acr create --resource-group $resourceGroup \
  --name $acrName --sku Basic

az acr login --name $acrName


