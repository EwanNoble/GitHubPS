function Invoke-GitHubRestMethod() {
    param(
        [ValidateSet("GET", "POST", "PUT", "DELETE")]
        [string]$Method,
        [ValidateNotNullOrEmpty()]
        [string]$APIEndpoint
    )

    $Protocol = "https"
    $BaseDomain = "api.github.com"

    $UriBuilder = New-Object System.UriBuilder -ArgumentList $Protocol, $BaseDomain, 443, $APIEndpoint

    $Response = Invoke-RestMethod -Method $Method -Uri $UriBuilder.Uri.AbsoluteUri -Headers @{Authorization = "token $Global:GitHubConnection"  }

    return $Response
}
