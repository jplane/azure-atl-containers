
# assumes you have already create a databricks workspace...
#  https://docs.microsoft.com/en-us/azure/azure-databricks/quickstart-create-databricks-workspace-portal?toc=/azure/databricks/toc.json&bc=/azure/databricks/breadcrumb/toc.json#create-an-azure-databricks-workspace
# ...and logged in via the databricks CLI
#  https://docs.microsoft.com/en-us/azure/databricks/dev-tools/cli/
# ...and you have already run setup.sh

# get ACR password
acr_pwd=$(az acr credential show --name azureatlcontainers --query passwords[0].value --output tsv)

# create databricks cluster in workspace
databricks clusters create --json "{
        \"cluster_name\": \"azure-atl-cluster\",
        \"num_workers\": 0,
        \"node_type_id\": \"Standard_DS3_v2\",
        \"docker_image\": {
            \"url\": \"azureatlcontainers.azurecr.io/databricks:v1\",
            \"basic_auth\": {
                \"username\": \"azureatlcontainers\",
                \"password\": \"$acr_pwd\"
            }
        },
        \"spark_version\": \"6.5.x-scala2.11\"
    }"
