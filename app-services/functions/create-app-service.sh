
# assumes you have already run setup.sh

# get ACR password
acr_pwd=$(az acr credential show --name azureatlcontainers --query passwords[0].value --output tsv)

# create function app
az functionapp create \
    --name azure-atl-containers-func \
    --storage-account azureatlstorage \
    --resource-group azure-atl-containers \
    --plan azure-atl-containers-plan \
    --functions-version 3 \
    --deployment-container-image-name azureatlcontainers.azurecr.io/func-app:v1 \
    --docker-registry-server-user azureatlcontainers \
    --docker-registry-server-password $acr_pwd
