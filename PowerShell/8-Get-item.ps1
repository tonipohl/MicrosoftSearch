#-------------------------------------------
# 8-Get-item.ps1
#-------------------------------------------
# Get a specific item by its id
# https://docs.microsoft.com/en-us/graph/connecting-external-content-connectors-api-postman
# November 2021, atwork.at. Toni Pohl

$connector = "workshops"
$itemid = "31"
Write-Output $itemid

$result = Invoke-RestMethod `
        -Method GET `
        -Uri "https://graph.microsoft.com/v1.0/external/connections/$connector/items/$itemid" `
        -ContentType 'application/json' `
        -Headers $script:APIHeader `
        -ErrorAction Stop


# Show the result
$result
$result.properties

