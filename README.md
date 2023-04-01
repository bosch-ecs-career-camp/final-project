# A Kubernetes controller that operates self-hosted runners for GitHub Actions on Azure Kubernetes Service

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

This repository contains the scripts and configuration files for build and set up self-hosted GitHub action runners which could be spined up on demand. Implementation is based on an open-source project called Action Runner Controller. 

## Pre-Requisites
- Azure Subscription with at least [Contributor](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#contributor) + [User Access Administrator](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#user-access-administrator) built-in roles. You will be performing role assignments when integrating Azure Container Registry with AKS.
- Create Azure Resources and accses credentials:  
```bash
# Create a resource group for our ACR cluster
az group create -l $location -n $resourceGroup

# Create Azure Container Registry
az acr create --resource-group $resourceGroup \
  --name $acrName --sku Basic \
  --admin-enabled true 

subscr_ID=`az account show --query id --output tsv`

# Create a service principal for access to Azure resources.
az ad sp create-for-rbac \
--name final-project --role Contributor \
--scopes /subscriptions/$subscr_ID/resourceGroups/$resourceGroup \
--sdk-auth

# !!!Important!!!
# Json output shoud be added as github secret with name: AZURE_CREDENTIALS

# get ACR admin password
az acr credential show -n $acrName --query passwords[0].value
# output shoud be added as github secret with name: REG_PASS

# ... or just execute script src/prerequisite_run.sh and store secrets.
```
## Folder Structure

```text
.
├── .github
│   └── workflows
│       ├── docker_workflow.yml
│       ├── image_build.yml
│       ├── infrastructure_build.yml
│       ├── matrix_workflow.yml
│       └── test.yml
├── README.md
├── build
│   ├── Dockerfile
│   └── Dockerfile_scratch
├── controller
│   ├── actions-runner-controller.yaml
│   ├── cert-manager.yaml
│   ├── namespace.yml
│   └── runner_deployment.yml
└── src
    ├── deploy_runners.sh
    ├── infra_build.sh
    ├── nsg_temp.sh
    ├── prerequisite_run.sh
    ├── raw_script.sh
    └── start.sh
```

- `.github/workflow/`: contains the main project workflows and sample workflows used for sanity checks and demo
- `build/`: contains the Dockerfile of a custom runner image
- `controller/`: contains the actions-runner-controller and cert-manager configuration
- `src/`: contains the automation scripts

## References

- **GitHub Actions docs:** https://docs.github.com/en/actions
- **Self Hosted Runners docs:** https://docs.github.com/en/actions/hosting-your-own-runners
- **Azure AKS docs:** <https://docs.microsoft.com/en-us/azure/aks/>
- **Azure CLI docs:** <https://docs.microsoft.com/en-us/cli/azure/>
- **Acions Runner Controller Project docs:** https://github.com/actions/actions-runner-controller


## Authors

- [@sashosotirov](https://github.com/sashosotirov)


