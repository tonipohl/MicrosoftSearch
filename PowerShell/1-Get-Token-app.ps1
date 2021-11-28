#-------------------------------------------
# 1-Get-Token-app.ps1
#-------------------------------------------
# Get an authentication token as app
# See how to create an app at https://docs.microsoft.com/en-us/graph/auth-v2-service
# November 2021, atwork.at. Toni Pohl

$tenantId = '<tenantid>'
$appId = "<appid>"
$secret = "<secret>"

function Initialize-Authorization {
    param
    (
        [string]
        $ResourceURL = 'https://graph.microsoft.com',
  
        [string]
        [parameter(Mandatory)]
        $tenantId,
      
        [string]
        [Parameter(Mandatory)]
        $secret,
  
        [string]
        [Parameter(Mandatory)]
        $appId
    )

    $Authority = "https://login.microsoftonline.com/$tenantId/oauth2/token"

    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $EncodedKey = [System.Web.HttpUtility]::UrlEncode($secret)

    $body = "grant_type=client_credentials&client_id=$appId&client_secret=$EncodedKey&resource=$ResourceUrl"

    # Request a Token from the Graph Api
    $authresult = Invoke-RestMethod -Method POST `
        -Uri $Authority `
        -ContentType 'application/x-www-form-urlencoded' `
        -Body $body

    # store the result on the $script object that is only available to the script scope
    $script:APIHeader = @{'Authorization' = "Bearer $($authresult.access_token)" }

    # If needed, for developing purposes, we store the current token locally, e.g. for using in PostMan
    Write-Output $authresult.access_token | Out-File -FilePath ".\token.txt" -Encoding Ascii

    # If needed, check the token content
    # https://jwt.ms/
}

# Get authorization data with the app data
Initialize-Authorization -tenantId $tenantId -secret $secret -appId $appId

$script:APIHeader
