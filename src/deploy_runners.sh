#!/bin/bash


# ---- credentials ---- 
echo "Get access credentials for a managed Kubernetes cluster"
az aks get-credentials --resource-group stream4-rg \
--name stream4-final-aks --overwrite-existing

# ----  ACTION RUNNER CONTROLLER ----

# ----  install cert-manager for enabling admission web-hooks ---- 
sleep 10
kubectl apply -f cert-manager.yaml

# ---- install and setup action runner controller ----
sleep 10
kubectl create -f namespace.yml
# -enable authentication to GitHub API-
kubectl create secret generic controller-manager \
    -n actions-runner-system \
    --from-literal=github_token=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
    #${GITHUB_TOKEN}

kubectl create -f actions-runner-controller.yaml

# ----  deploying ARC runners ----
sleep 30
cat runner_deployment.yml | envsubst | kubectl apply -f -