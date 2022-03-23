#Used to continue on error
$ErrorActionPreference = 'SilentlyContinue'

#It is assumed that csv file is named as subscriptions.csv
Import-Csv .\source.csv | ForEach-Object {
  Write-Host "$($_.Name), is the subscription, $($_.rg) is the resource group and $($_.tag), is the tag."
  $subscription_Name = $_.Name
  $resource_group = $_.rg
  $tag = $_.tag
  $tags = @{"Application"=$tag}
  Select-AzureSubscription -Current -SubscriptionName $subscription_Name
  resource = Get-AzResourceGroup -Name $resource_group
  Update-AzTag -ResourceId $resource.id -Tag $tags -Operation Merge
 }
