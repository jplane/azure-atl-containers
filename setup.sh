
# assumes you have already logged into the Azure CLI
#  https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest

# create resource group
az group create --name azure-atl-containers --location eastus2

# create a storage account
az storage account create \
    --name azureatlstorage \
    --resource-group azure-atl-containers \
    --sku Standard_LRS

# create container registry
az acr create \
    --name azureatlcontainers \
    --resource-group azure-atl-containers \
    --sku Basic \
    --admin-enabled true

# get ACR password
acr_pwd=$(az acr credential show --name azureatlcontainers --query passwords[0].value --output tsv)

# create app service plan
az appservice plan create \
    --name azure-atl-containers-plan \
    --resource-group azure-atl-containers \
    --number-of-workers 1 \
    --sku B1 \
    --is-linux
