
# assumes you have already run setup.sh

# get ACR password
acr_pwd=$(az acr credential show --name azureatlcontainers --query passwords[0].value --output tsv)

# create web app
az webapp create \
    --resource-group azure-atl-containers \
    --plan azure-atl-containers-plan \
    --name azure-atl-containers-web \
    --deployment-container-image-name azureatlcontainers.azurecr.io/web-app:v1 \
    --docker-registry-server-user azureatlcontainers \
    --docker-registry-server-password $acr_pwd
