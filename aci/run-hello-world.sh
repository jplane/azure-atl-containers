
# create and start a container group
az container create \
    --resource-group azure-atl-containers \
    --name hello-world \
    --image mcr.microsoft.com/azuredocs/aci-helloworld \
    --dns-name-label azure-atl-aci-demo \
    --ports 80
