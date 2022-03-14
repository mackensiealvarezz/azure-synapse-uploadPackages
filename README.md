# Upload packages to Synapse using Powershell

In this repo you will find a file called "uploadFile.ps1" that has an example on how to upload packages to synapse workspace.

## How to use

All you need to do is replace these variables in *uploadFile.ps1*.
```ps1
$workspaceName = "workspacename"
$SubscriptionId = "subscription_id"

$fileName = "myawesomepackage.whl"
$filePath = "packages/myawesomepackage.whl"
```

## How it works

1. The script will sign into the right subscription.
2. It will get a Bearer token to authorize with synapse.
3. It will make a REST api call to the synapse workspace to upload the file.


## How to use in automation

Here is an example how you can use this in your CD pipeline(*Azure Devops*)
```
- task: AzurePowerShell@5
  inputs:
    azureSubscription: my-arm-service-connection
    scriptType: filePath
    scriptPath: $(Build.SourcesDirectory)\uploadFile.ps1
    azurePowerShellVersion: latestVersion
    pwsh: true
```

Make sure that the Service connection you use has access to the Synapse workspace.

## Learn more

Learn more about the synapse workspace REST API by visiting:
https://docs.microsoft.com/en-us/rest/api/synapse/
