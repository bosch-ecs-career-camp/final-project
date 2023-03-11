#!/bin/bash

export location="westeurope"
export resourceGroup="final-project"

az group create -l $location -n $resourceGroup 
az acr create --resource-group $resourceGroup \
  --name final-project-acr --sku Basic



