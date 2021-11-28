#-------------------------------------------
# 5-Register-schema-events.ps1
#-------------------------------------------
# Register a schema for the data source
# https://docs.microsoft.com/en-us/graph/connecting-external-content-connectors-api-postman#step-7---register-connection-schema
# November 2021, atwork.at. Toni Pohl

$connector = "workshops"

$body = @"
{ 
  "baseType": "microsoft.graph.externalItem", 
  "properties": [ 
    {
      "name": "id",
      "type": "string",
      "isSearchable": true,
      "isRetrievable": true,
      "isQueryable": true,
      "labels": [],
      "aliases": []
    },
    {
      "name": "title",
      "type": "string",
      "isSearchable": true,
      "isRetrievable": true,
      "isQueryable": true,
      "labels": [],
      "isRefinable": false,
      "aliases": []
    },
    {
      "name": "date",
      "Type": "DateTime", 
      "isSearchable": false, 
      "isQueryable": true, 
      "isRetrievable": true, 
      "isRefinable": true, 
      "Labels": [ "lastModifiedDateTime" ]
    },
    {
      "name": "speaker",
      "Type": "String", 
      "isSearchable": true, 
      "isQueryable": true, 
      "isRetrievable": true,
      "isRefinable": false
    },
    {
      "name": "room",
      "Type": "String", 
      "isSearchable": true, 
      "isQueryable": true, 
      "isRetrievable": false
    },
    {
      "name": "audience",
      "Type": "String", 
      "isSearchable": true, 
      "isQueryable": true, 
      "isRetrievable": true,
      "isRefinable": false
    },
    {
      "name": "type",
      "Type": "String", 
      "isSearchable": true, 
      "isQueryable": true, 
      "isRetrievable": true,
      "isRefinable": false
    }
  ] 
  }
"@

Invoke-RestMethod `
  -Method POST `
  -Uri "https://graph.microsoft.com/v1.0/external/connections/$connector/schema" `
  -ContentType 'application/json' `
  -Headers $script:APIHeader `
  -Body $body `
  -ErrorAction Stop

