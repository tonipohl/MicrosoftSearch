#-------------------------------------------
# 11-Query.ps1
# Important: Works only with user auth!
#-------------------------------------------
# Query Microsoft Search
# https://docs.microsoft.com/en-us/graph/search-concept-overview
# https://docs.microsoft.com/en-us/graph/api/search-query?view=graph-rest-1.0
# November 2021, atwork.at. Toni Pohl

<#
Remember, this is a delegated user experience. The user currently requires the following Graph permissions:
Calendars.ReadCalendars.Read
ExternalItem.Read.All
Files.Read.All
Mail.Read
Sites.Read.All
#>

$body = @"
{
  "requests": [
    {
      "entityTypes": [ "driveItem" ],
      "query": { "queryString": "contoso" }
    }
  ]
}
"@


$Result = Invoke-RestMethod `
  -Method POST `
  -Uri "https://graph.microsoft.com/v1.0/search/query" `
  -ContentType 'application/json' `
  -Headers $script:APIHeader `
  -Body $body `
  -ErrorAction Stop

$Result.value
