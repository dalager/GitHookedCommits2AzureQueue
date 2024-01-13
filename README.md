# Git commits to Azure Queue

This is a simple tool that tracks commits across all your git repositoris and logs them to an azure storage queue.

## Install hook

Sets up a global git hook that will be called after each commit and will post the commit to the azure queue.

Any local `post-commit` hook will be called after the global hook.

Run this

```powershell
.\hooks\install_global_hook.ps1
```

Take a look at the [post-commit](hooks/post-commit) hook to see what it does.

## Setup Azure infrastructure

This is where the commits will be logged to

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

### Post install state

- the resource group `commitlogger-rg` contains the storage account and the queue with the logs
- the environment variable `COMMITLOGGER_QUEUE_URL` contains the authorized post url to the queue
- there is a global `post-commit` hook installed in `~/.git-hooks` that will post to the queue after each commit
- if you have a local `post-commit` hook in your repository, it will be called after the global hook

### Cleanup

- run `.\iac\drop_resources.ps1` to delete the resource group and all resources in it and the environment variable `COMMITLOGGER_QUEUE_URL`
- run `.\hooks\uninstall_global_hook.ps1` to uninstall the global git hook
