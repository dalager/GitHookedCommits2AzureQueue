$random = Get-Random -Minimum 1000 -Maximum 9999
$resourcegroup = "commitlogger-rg"
$location = "westeurope"
$storageaccount = "commitloggerstorage$random"
$storagequeue = "commitqueue"
$commitloggerdb = "commitloggerdb$random"

# Create resource group
az group create --name $resourcegroup --location $location

# Create storage account
az storage account create --name $storageaccount --resource-group $resourcegroup --location $location --sku Standard_LRS

# create queue
az storage queue create --name $storagequeue --account-name $storageaccount

# create shared access policy for pushing messages
az storage queue policy create --account-name $storageaccount --queue-name $storagequeue --name "addcommits" --permissions "a" --expiry "2028-12-31T23:59:00Z"

# create a sas token for pushing messages
$token = az storage queue generate-sas --account-name $storageaccount -o tsv --policy-name "addcommits"






# create cosmosdb
az cosmosdb create -n commitloggerdb$random -g $RESOURCE_GROUP --enable-free-tier true
