#!/bin/bash

az ad sp create-for-rbac \
--name final-project --role contributor \
--scopes /subscriptions/f4da5d14-f99a-4ae5-84e7-2174caf342da/resourceGroups/final-project \
--sdk-auth