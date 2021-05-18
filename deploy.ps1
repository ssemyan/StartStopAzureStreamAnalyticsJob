<#
 .SYNOPSIS
    Deploys a template to Azure

 .DESCRIPTION
    Deploys an Azure Resource Manager template

 .PARAMETER resourceGroupName
    The resource group where the template will be deployed. Can be the name of an existing or a new resource group.

 .PARAMETER templateFilePath
    Optional, path to the template file. 

 .PARAMETER parametersFilePath
    Optional, path to the parameters file. Defaults to parameters.json. 
#>

param(
 [Parameter(Mandatory=$True)]
 [string]
 $resourceGroupName,

 [string]
 $templateFilePath = "template.json",

 [string]
 $parametersFilePath = "parameters.json"
)

#******************************************************************************
# Script body
# Execution begins here
#******************************************************************************
$ErrorActionPreference = "Stop"

# sign in and select subscription
#Write-Host "Logging in...";
#Login-AzureRmAccount -SubscriptionID $subscriptionId;

# verify resource group exists
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName 

# Test
Write-Host "Testing deployment...";
$testResult = Test-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -TemplateParameterFile $parametersFilePath -ErrorAction Stop;
if ($testResult.Count -gt 0)
{
	Write-Error ($testResult | ConvertTo-Json -Depth 5 | Out-String);
}

# Start the deployment
Write-Host "Starting deployment...";
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -TemplateParameterFile $parametersFilePath -Verbose;
