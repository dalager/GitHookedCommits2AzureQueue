$resourcegroup = "commitlogger-rg"
$envvariable = "COMMITLOGGER_QUEUE_URL"


# delete resource group
write-output "deleting resource group $resourcegroup"
az group delete --name $resourcegroup --yes


# delete environment variable
write-output "deleting environment variable $envvariable"
[Environment]::SetEnvironmentVariable("$envvariable", $null, "User")
