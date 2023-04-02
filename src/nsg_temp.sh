# Create network security group .
# az network nsg create -g $resourceGroup -n bstn-nsg

export rootname="stream4"
export aks="$rootname-final-aks"
export location="switzerlandnorth"
export resourceGroup="$rootname-rg"
export acrName=$rootname"acr"
export nsgName="$rootname-nsg"
export vNet="$rootname-vnet"
export sNet="$rootname-snet"

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