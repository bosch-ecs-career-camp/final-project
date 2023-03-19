#!/bin/bash

export location="westeurope"
export resourceGroup="final-project"
az group create -l $location -n $resourceGroup 

subscr_ID=`az account show --query id --output tsv`
az ad sp create-for-rbac \
--name final-project --role contributor \
--scopes /subscriptions/$subscr_ID/resourceGroups/stream4-rg \
--sdk-auth