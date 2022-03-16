#Used to continue on error
$ErrorActionPreference = 'SilentlyContinue'

#It is assumed that csv file is named as subscriptions.csv
Import-Csv .\subscriptions.csv | ForEach-Object {
    Write-Host "$($_.Name), is the subscription and $($_.tag), is the tag."
	$subscription_Name = $_.Name
	$tag = $_.tag
	$tags = @{"Application"=$tag}
	Select-AzureSubscription -Current -SubscriptionName $subscription_Name
	foreach ( $resourcegroup in Get-AzResourceGroup ) {
		#Update-Aztag will update the existing tags and merge it. It will also ignore if the tag is already applied
	    Update-AzTag -ResourceId $resource.id -Tag $tags -Operation Merge
	}
	
}
