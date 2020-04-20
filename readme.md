# Azure-in-the-ATL: Containers in Azure (its not just AKS)

Slides are [here](./ContainersInAzure.pptx)

## Pre-requisites

1. An Azure subscription
1. All demos use shell scripting, on Windows you'll want to [install Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)
1. [Install Docker](https://docs.docker.com/get-docker/)
    - on Windows be sure to install the special WSL2 backend instead of 'regular' Docker Desktop https://docs.docker.com/docker-for-windows/wsl-tech-preview/
1. [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
1. [Install the Databricks CLI](https://docs.microsoft.com/en-us/azure/databricks/dev-tools/cli/)

## Setup (do this first)

1. Open a bash prompt and [log into the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest)
1. Run [setup.sh](./setup.sh)

## ACI demo

Run [run-hello-world.sh](./aci/run-hello-world.sh); note that you may need to modify the DNS name in the script to ensure uniqueness.

Within the Azure portal, navigate to the 'hello-world' ACI in the 'azure-atl-containers' resource group. Open a browser window to the FQDN address specified for your ACI.

## App Service (web) demo

Run [build-and-push.sh](./app-services/web/build-and-push.sh) to build the web app Docker image locally and push it to the Azure Container Registry created in the setup script.

Next, run [create-app-service.sh](./app-services/web/create-app-service.sh) to create a Linux container-based app service instance in Azure; note that you may need to modify the app service name in the script to ensure uniqueness.

Within the Azure portal, navigate to the 'azure-atl-containers' resource group and find your newly created web app service. Browse to the URL specified in the app service overview panel to ensure proper configuration and deployment.

## App Service (function) demo

Run [build-and-push.sh](./app-services/functions/build-and-push.sh) to build the function app Docker image locally and push it to the Azure Container Registry created in the setup script.

Next, run [create-app-service.sh](./app-services/functions/create-app-service.sh) to create a Linux container-based app service instance in Azure; note that you may need to modify the app service name in the script to ensure uniqueness.

Within the Azure portal, navigate to the 'azure-atl-containers' resource group and find your newly created functions app service. Browse to the URL specified in the app service overview panel to ensure proper configuration and deployment.

## Databricks demo

The first few steps cannot be scripted, and must be performed manually.

First, [create a Databricks workspace](https://docs.microsoft.com/en-us/azure/azure-databricks/quickstart-create-databricks-workspace-portal#create-an-azure-databricks-workspace) within the 'azure-atl-containers' resource group in Azure.

Next, navigate to your new Databricks workspace in the Azure portal and click the 'Launch Workspace' button. Once in the workspace, [create a Personal Access Token](https://docs.microsoft.com/en-us/azure/databricks/dev-tools/api/latest/authentication#--generate-a-token) and copy the token for use in the next step.

Run the following shell command to configure Databricks CLI authentication:

```bash
databricks configure --token
```

When prompted, enter your Databricks workspace URL and token.

Run [build-and-push.sh](./databricks-containers/build-and-push.sh) to build the custom Databricks Docker image locally and push it to the Azure Container Registry created in the setup script.

Next, run [create-cluster.sh](./databricks-containers/create-cluster.sh) to create a Databricks cluster that uses your custom Docker image.

Within the Databricks workspace, open a new Python notebook running on the cluster created in the previous step. In the notebook, run the following Python code to ensure you can access the Faker library installed in the custom Docker image:

```python
from faker import Faker
fake = Faker()

fake.name()
fake.address()
```

In a standard Databricks cluster install, you would not have immediate access to this library. So if the above code works correctly, you can be certain that your custom Docker image is functioning as expected.