#-------------------------------------------
# 4-Delete-connector.ps1
#-------------------------------------------
# Delete an existing connector
# See more at https://docs.microsoft.com/en-us/graph/connecting-external-content-connectors-api-postman
# November 2021, atwork.at. Toni Pohl

$connector = "workshops"

$result = Invoke-RestMethod `
-Method DELETE `
-Uri "https://graph.microsoft.com/v1.0/external/connections/$connector" `
-ContentType 'application/json' `
-Headers $script:APIHeader `
-Body $body `
-ErrorAction Stop

# Show the result
$result
