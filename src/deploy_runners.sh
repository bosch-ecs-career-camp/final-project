#!/bin/bash


# ---- credentials ---- 
echo "Get access credentials for a managed Kubernetes cluster"
az aks get-credentials --resource-group stream4-rg \
--name stream4-final-aks --overwrite-existing

# ----  ACTION RUNNER CONTROLLER ----

# ----  install cert-manager for enabling admission web-hooks ---- 
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml

# ---- install and setup action runner controller ----
kubectl create -f https://github.com/actions/actions-runner-controller/releases/download/v0.27.0/actions-runner-controller.yaml

# ----	enable authentication to GitHub API ----
kubectl create secret generic controller-manager \
    -n actions-runner-system \
    --from-literal=github_token=${GITHUB_TOKEN}

# ----  deploying ARC runners ----

cat ./src/runner_deployment.yml | envsubst | kubectl apply -f -