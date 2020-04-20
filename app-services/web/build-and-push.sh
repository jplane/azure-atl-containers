
# assumes you have already run setup.sh

# build docker image
docker build --tag azure-atl-web-app ./app

# get ACR password
acr_pwd=$(az acr credential show --name azureatlcontainers --query passwords[0].value --output tsv)

# login to ACR
docker login azureatlcontainers.azurecr.io --username azureatlcontainers --password $acr_pwd

# tag image for ACR
docker tag azure-atl-web-app azureatlcontainers.azurecr.io/web-app:v1

# push image to ACR
docker push azureatlcontainers.azurecr.io/web-app:v1
