#!/bin/bash

# ---- credentials ---- 
echo "Get access credentials for a managed Kubernetes cluster"
az aks get-credentials --resource-group stream4-rg \
--name stream4-final-aks --overwrite-existing

# ----  ACTION RUNNER CONTROLLER ----

# ----  install cert-manager for enabling admission web-hooks ---- 
kubectl apply -f cert-manager.yaml

# ---- install and setup action runner controller ----
kubectl create namespace actions-runner-system
kubectl label namespaces actions-runner-system \
control-plane=controller-manager --overwrite=true
# -enable authentication to GitHub API-
kubectl create secret generic controller-manager \
    -n actions-runner-system \
    --from-literal=github_token=${GITHUB_TOKEN}

kubectl create -f actions-runner-controller.yaml

# ----  deploying ARC runners ----
sleep 120
cat runner_deployment.yml | envsubst | kubectl apply -f -
