param(
 [Parameter(Mandatory=$True)]
 [string]
 $resourceGroupName,

 [string]
 $parametersFilePath = "parameters.json"
)

# load the parameters so we can use them in the script
$params = ConvertFrom-Json -InputObject (Gc $parametersFilePath -Raw)

$streamanalytics_name = $params.parameters.streamanalytics_name.value
Write-Host "Starting Stream Analytics Job '$streamanalytics_name' in resource group '$resourceGroupName'.";
Start-AzureRmStreamAnalyticsJob -ResourceGroupName $resourceGroupName -Name $streamanalytics_name
