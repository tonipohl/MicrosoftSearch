#-------------------------------------------
# 7-Ingest-data.ps1
#-------------------------------------------
# Create a new item
# https://docs.microsoft.com/en-us/graph/connecting-external-content-connectors-api-postman#step-9---ingest-items
# November 2021, atwork.at. Toni Pohl

# 2021-04-27T11:04:00Z
$now = Get-Date -Format O
Write-Output $now

# In real world, use a GUID as Id. This here is just to simplify the Id to make it more readable.
# $itemid = New-Guid
$itemid = Get-Date -Format "HHmmss"
Write-Output $itemid

$body = @"
{
  "acl": [
    {
      "type": "everyone",
      "value": "c5f19b2d-0a77-454a-9b43-abf298c3b34e",
      "accessType": "grant"
    }
  ],
  "properties": {
    "id": "$itemid",
    "Title": "Using Search with Id $itemid",
    "Date": "$now",
    "Speaker": "undefined",
    "Room": "Room1",
    "Audience": "Collab",
    "Type": "Session"
  },
  "content": {
    "type": "text",
    "value": "This is external content and activity information brought to Microsoft Search."
  }
}
"@

$result = Invoke-RestMethod `
        -Method PUT `
        -Uri "https://graph.microsoft.com/v1.0//external/connections/$connector/items/$itemid" `
        -ContentType 'application/json' `
        -Headers $script:APIHeader `
        -Body $body `
        -ErrorAction Stop

# Show the result
$result
