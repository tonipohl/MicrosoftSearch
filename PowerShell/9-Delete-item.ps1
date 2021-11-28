#-------------------------------------------
# 9-Delete-item.ps1
#-------------------------------------------
# Delete a specific item
# https://docs.microsoft.com/en-us/graph/connecting-external-content-connectors-api-postman
# November 2021, atwork.at. Toni Pohl

$connector = "workshops"
$itemid = "16"
Write-Output $itemid

Invoke-RestMethod `
        -Method DELETE `
        -Uri "https://graph.microsoft.com/v1.0/external/connections/$connector/items/$itemid" `
        -ContentType 'application/json' `
        -Headers $script:APIHeader `
        -ErrorAction Stop

# $result.properties
