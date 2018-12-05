function Set-GitHubConnection() {
<#
    .SYNOPSIS
    Sets the session GitHub connection.

    .DESCRIPTION
    Tests your PAT Token is valid and sets a global variable for use in future API calls within the session.

    .PARAMETER OAuthToken
    A PAT token created within GitHub

    .EXAMPLE
    Set-GitHubConnection -OAuthToken <GitHub PAT token>
#>
    param(
        [string]$OAuthToken
    )
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


    try {
        $UserResponse = Invoke-RestMethod -Method GET -Headers @{Authorization = "token $OAuthToken" } -Uri "https://api.github.com/user"
        Write-Host " - Successfully logged in, welcome $($UserResponse.name)!" -ForegroundColor Green
        $Global:GitHubConnection = $OAuthToken
    }
    catch {
        if ($_.Exception.Response.StatusCode.Value__ -eq 401) {
            throw "Unauthorized, is your OAuthToken correct?"
        }
        else {
            throw $_.Exception
        }
    }
}
