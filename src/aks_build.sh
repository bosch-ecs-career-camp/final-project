#!/bin/bash

# ----  variables ----
export rootname="stream4"
export aks="$rootname-final-aks"
export location="switzerlandnorth"
export resourceGroup="$rootname-rg"
export acrName=$rootname"acr"

# ---- network
export vNet="$rootname-vnet"
export addressPrefixVNet="192.168.0.0/24"
export sNet="$rootname-snet"
export addressPrefixSNet="192.168.0.0/26"
export sku=Standard


# # ---- create resource group ----
# echo "Creating $resourceGroup in $location..."
# az group create -l $location -n $resourceGroup 

# ---- create virtual network ----
echo "Creating $vNet"
az network vnet create \
--address-prefixes $addressPrefixVNet \
--name $vNet \
--location $location \
--resource-group $resourceGroup \
--subnet-name $sNet \
--subnet-prefixes $addressPrefixSNet 

# ---- create k8s service ----
echo "Creating $aks"
snetID=$(az network vnet subnet show \
--resource-group $resourceGroup \
--vnet-name $vNet --name $sNet \
--query id -o tsv)

az aks create --name $aks \
--resource-group $resourceGroup \
--location $location \
--node-count 1 \
--node-vm-size Standard_DS2_v2 \
--network-plugin kubenet \
--vnet-subnet-id $snetID \
--generate-ssh-keys \
--attach-acr $acrName 

# ---- credentials ---- 
echo "Get access credentials for a managed Kubernetes cluster"
az aks get-credentials \
--resource-group $resourceGroup \
--name $aks \
--overwrite-existing