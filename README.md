# Git commits to Azure Queue

This is a simple tool that tracks commits across all your git repositoris and logs them to an azure storage queue as json.

From here you can hook it up to functions, logicapps, local apps or something else to store or process elsewhere.

```json
{
  "commit_hash": "093b25400dd5cf56c95bf0000022fe7063a073c8",
  "repository": "git@github.com:dalager/commitlogger.git",
  "branch": "main",
  "author": "Christian Dalager",
  "commit_message": "Updating readme"
}
```

![Alt text](img/storageexplorer.png)

## Install hook

Sets up a global git hook that will be called after each commit and will post the commit to the azure queue.

Any local `post-commit` hook will be called after the global hook.

Run this

```powershell
>.\hooks\install_global_hook.ps1
```

Take a look at the [post-commit](hooks/post-commit) hook to see what it does.

## Setup Azure infrastructure

Using only the Azure CLI and Powershell, this will create the following resources

- Resource group `commitlogger-rg`
- Storage account, Standard LRS, `commitloggerstorage<+RandomInt>`
- Storage queue `commitqueue`
- Access policy "addcommits" with only add permissions to the queue
- An Secure Access Signature (SAS) token that can be used to post to the queue

This is a VERY simple and almost free setup. The storage account is the only thing that will cost you money, and it will cost you almost nothing.
Unless you are an insane commit machine, of course. Which you are not. Right?

### Pre-requisites

- Powershell
- Azure subscription
- Install of [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

### Run the following commands

```powershell
>az login
>az account set --subscription <subscription id>
```

And then run the following command to create the infrastructure

```powershell
>.\iac\create_resources.ps1
```

## Post install state

- The resource group `commitlogger-rg` contains the storage account and the queue with the logs
- The environment variable `COMMITLOGGER_QUEUE_URL` contains the authorized post url to the queue
- There is a global `post-commit` hook installed in `~/.git-hooks` that will post to the queue after each commit
- If you have a local `post-commit` hook in your repository, it will be called after the global hook

## Test the endpoint

With VS code and the restclient extension you can test the endpoint by opening the [push_test_message_to_endpoint.http](push_test_message_to_endpoint.http) file and sending the request.

Then open the storage queue in either the [Azure portal](https://portal.azure.com/) or with the [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/).

### Cleanup

Run the following commands to clean up the resources

`>.\iac\drop_resources.ps1`
Will delete the resource group and all resources in it and the environment variable `COMMITLOGGER_QUEUE_URL`

`>.\hooks\uninstall_global_hook.ps1`

Will uninstall the global git hook

## Known issues

On windows with `gitui` the global hook is not called.
