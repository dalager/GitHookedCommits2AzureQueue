# Commit Tracker

This is a simple tool that tracks commits across all your git repositoris and logs them to an azure storage queue.

## Install hook

## Setup Azure infrastructure

### Pre-requisites

- Powershell
- Azure subscription
- Install of [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

### Run the following commands

```powershell
az login
az account set --subscription <subscription id>
```

And then run the following command to create the infrastructure

```powershell
.\iac\create_resources.ps1
```
