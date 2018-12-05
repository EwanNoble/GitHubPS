function Set-GitHubConnection() {
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
