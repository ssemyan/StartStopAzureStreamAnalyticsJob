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

# check if job exists
$job = Get-AzureRmStreamAnalyticsJob -ResourceGroupName $resourceGroupName -Name $streamanalytics_name -ErrorAction SilentlyContinue
if(!$job)
{
	Write-Host "Stream Analytics Job '$streamanalytics_name' in resource group '$resourceGroupName' not found.";
}
else
{
	Write-Host "Stopping Stream Analytics Job '$streamanalytics_name' in resource group '$resourceGroupName'.";
	Stop-AzureRmStreamAnalyticsJob -ResourceGroupName $resourceGroupName -Name $streamanalytics_name
}
