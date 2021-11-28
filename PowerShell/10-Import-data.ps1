#-------------------------------------------
# 10-Import-data.ps1
#-------------------------------------------
# Import data from a CSV file
# https://docs.microsoft.com/en-us/graph/connecting-external-content-connectors-api-postman#step-9---ingest-items
# November 2021, atwork.at. Toni Pohl

$connector = "workshops"

$allsessions = Import-Csv ".\event-demo.csv" -Delimiter ";" -Encoding UTF8

$i = 0
foreach ($session in $allsessions) {

  $i++
  # In real world, use a GUID as Id, such as: $itemid = New-Guid
  # Convert "30.11.2021 10:15" to "2021-11-14T22:49:22.3701848Z"
  $sessionstart = [datetime]::parseexact($session.StartDate, 'dd.MM.yyyy HH:mm', $null).ToString('O')

  # overwrite with the new date format for a nice output
  $session.StartDate = $sessionstart
  Write-Output "-- $i --"
  Write-Output $session

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
    "id": "$($session.ID)",
    "title": "$($session.Title)",
    "date": "$($sessionstart)",
    "speaker": "$($session.Speaker)",
    "room": "$($session.Room)",
    "audience": "$($session.Audience)",
    "type": "$($session.Type)"
  },
  "content": {
    "type": "text",
    "value": "Imported item with Id $($session.ID). This is external content from an event in connector $($connector)."
  }
}
"@

  Invoke-RestMethod `
    -Method Put `
    -Uri "https://graph.microsoft.com/v1.0/external/connections/$connector/items/$($session.ID)" `
    -ContentType 'application/json' `
    -Headers $script:APIHeader `
    -Body $body `
    -ErrorAction Stop -Verbose 
}

Write-Output "Import done."
