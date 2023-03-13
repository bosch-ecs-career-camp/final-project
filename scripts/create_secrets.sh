#!/bin/bash

subscr_ID=`az account show --query id --output tsv`
az ad sp create-for-rbac \
--name final-project --role contributor \
--scopes /subscriptions/$subscr_ID/resourceGroups/final-project \
--sdk-auth