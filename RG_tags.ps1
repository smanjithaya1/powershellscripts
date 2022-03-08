# Add the tags in this format, in the below variable $tags = @{"Dept"="Finance"; "Status"="Normal"}
$tags = @{}
foreach ( $subscription in Get-Subscriptions ) {
  Write-Host "$subscription.Name is the current subscription"
  Select-AzureSubscription -Current -SubscriptionName $subscription.Name
  foreach ( $resourcegroup in Get-AzResourceGroup ) {
    New-AzTag -ResourceId $resourcegroup.ResourceId -tag $tags
  }
}
