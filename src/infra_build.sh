#!/bin/bash

# ----  variables ----
export rootname="stream4"
export aks="$rootname-final-aks"
export location="switzerlandnorth"
export resourceGroup="$rootname-rg"
export acrName=$rootname"acr"
export nsgName="$rootname-nsg"

# ---- network
export vNet="$rootname-vnet"
export addressPrefixVNet="192.168.0.0/24"
export sNet="$rootname-snet"
export addressPrefixSNet="192.168.0.0/26"
export sku=Standard

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
--no-ssh-key -x \
--attach-acr $acrName 

# ---- create nsg and security rules -----
az network nsg create -g $resourceGroup -n $nsgName

az network nsg rule create \
--name denyAllInbound \
--nsg-name $nsgName \
--resource-group $resourceGroup \
--priority 4096 \
--access Deny \
--direction Inbound \
--destination-port-ranges '*'

az network nsg rule create \
--name denyAllOutbound \
--nsg-name $nsgName \
--resource-group $resourceGroup \
--access Deny \
--priority 500 \
--direction Outbound \
--destination-port-ranges '*'

az network nsg rule create \
--name AllowHttpsTraffic \
--nsg-name $nsgName \
--resource-group $resourceGroup \
--priority 499 \
--destination-port-ranges 443 \
--direction Outbound \
--protocol Tcp

az network vnet subnet update \
--resource-group $resourceGroup \
--vnet-name $vNet \
--name $sNet \
--network-security-group $nsgName
