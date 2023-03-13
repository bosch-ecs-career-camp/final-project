#!/bin/bash

export location="westeurope"
export resourceGroup="final-project"

az group create -l $location -n $resourceGroup 
az acr create --resource-group $resourceGroup \
  --name stream4bosch --sku Basic



