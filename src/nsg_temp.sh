# Create network security group .
# az network nsg create -g $resourceGroup -n bstn-nsg

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

az network nsg create -g $resourceGroup -n aks-nsg

az network nsg rule create \
--name aksFilter \
--nsg-name aks-nsg \
--resource-group $resourceGroup \
--priority 500 \
--destination-port-ranges 8443 443 9402 \
--destination-address-prefixes '*' \
--source-port-ranges '*' \
--source-address-prefixes '*'

az network vnet subnet update \
--resource-group $resourceGroup \
--vnet-name $vNet \
--name $sNet \
--network-security-group aks-nsg