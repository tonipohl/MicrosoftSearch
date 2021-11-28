#-------------------------------------------
# 1-Get-Token-user.ps1
#-------------------------------------------
# Get an authentication token as user with device code flow
# November 2021, atwork.at. Toni Pohl

$tenantId = '<tenantid>'
$appId = "<appid>"
$secret = "<secret>"
$Resource = "https://graph.microsoft.com/"

$DeviceCodeRequestParams = @{
    Method = 'POST'
    Uri    = "https://login.microsoftonline.com/$tenantId/oauth2/devicecode"
    Body   = @{
        client_id = $appId
        resource  = $Resource
    }
}

$DeviceCodeRequest = Invoke-RestMethod @DeviceCodeRequestParams
Write-Host $DeviceCodeRequest.message -ForegroundColor Yellow

# https://aka.ms/devicelogin

$TokenRequestParams = @{
    Method = 'POST'
    Uri    = "https://login.microsoftonline.com/$tenantId/oauth2/token"
    Body   = @{
        grant_type    = "urn:ietf:params:oauth:grant-type:device_code"
        code          = $DeviceCodeRequest.device_code
        client_id     = $appId
        client_secret = $secret
    }
}
$TokenRequest = Invoke-RestMethod @TokenRequestParams

# Generate the header
$script:APIHeader = @{'Authorization' = "Bearer $($TokenRequest.access_token)" }

# If needed, for developing purposes, we store the current token locally, e.g. for using in PostMan
Write-Output $authresult.access_token | Out-File -FilePath ".\token.txt" -Encoding Ascii

# If needed, check the token content
# https://jwt.ms/
