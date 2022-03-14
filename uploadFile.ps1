$workspaceName = "workspacename"
$SubscriptionId = "subscription_id"

$fileName = "myawesomepackage.whl"
$filePath = "packages/myawesomepackage.whl"

Import-Module Az.Accounts

########################################################################################
#CONNECT TO AZURE

$Context = Get-AzContext

if ($Context -eq $null) {
    Write-Information "Need to login"
    Connect-AzAccount -Subscription $SubscriptionId
}
else
{
    Write-Host "Context exists"
    Write-Host "Current credential is $($Context.Account.Id)"
    if ($Context.Subscription.Id -ne $SubscriptionId) {
        $result = Select-AzSubscription -Subscription $SubscriptionId
        Write-Host "Current subscription is $($result.Subscription.Name)"
    }
    else {
        Write-Host "Current subscription is $($Context.Subscription.Name)"
    }
}
########################################################################################

# ------------------------------------------
# get Bearer token for current user for Synapse Workspace API
$token = (Get-AzAccessToken -Resource "https://dev.azuresynapse.net").Token
$headers = @{ Authorization = "Bearer $token" }
# ------------------------------------------

$uri = "https://$workspaceName.dev.azuresynapse.net/"
$uri += "libraries/$fileName?api-version=2020-12-01"

$result = Invoke-RestMethod -Method Put -ContentType "application/octet-stream" -Infile "$filePath" -Uri $uri -Headers $headers

Write-Host ($result | ConvertTo-Json)
