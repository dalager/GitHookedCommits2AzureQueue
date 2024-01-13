$random = Get-Random -Minimum 1000 -Maximum 9999
$resourcegroup = "commitlogger-rg"
$location = "westeurope"
$storageaccount = "commitloggerstorage$random"
$storagequeue = "commitqueue"
$envvariable = "COMMITLOGGER_QUEUE_URL"
# Create resource group
az group create --name $resourcegroup --location $location

# Create storage account
az storage account create --name $storageaccount --resource-group $resourcegroup --location $location --sku Standard_LRS

# create queue
az storage queue create --name $storagequeue --account-name $storageaccount

# create shared access policy for pushing messages
az storage queue policy create --account-name $storageaccount --queue-name $storagequeue --name "addcommits" --permissions "a" --expiry "2028-12-31T23:59:00Z"

# create a sas token for pushing messages
$token = az storage queue generate-sas --account-name $storageaccount --name $storagequeue --policy-name "addcommits" -o tsv 

Write-Output "SAS token for pushing messages:`n $token"

$storageendpoint = az storage account show --name $storageaccount --resource-group $resourcegroup --query "primaryEndpoints.queue" -o tsv

$queueposturl = "$storageendpoint$storagequeue/messages?$token"
write-output "This url can be used for posting messages to the queue for the next 5 years:`n $queueposturl"

Write-Output "saving to environment variable $envvariable"
# add as environment variable
[Environment]::SetEnvironmentVariable("$envvariable", $queueposturl, "User")

# ensure that the environment variable is available in the current session
$env:COMMITLOGGER_QUEUE_URL = $queueposturl

Write-Output "Environment variable `n$envvariable `nis now set to `n$queueposturl"
write-output "It will be available to the git post-commit hook script"

