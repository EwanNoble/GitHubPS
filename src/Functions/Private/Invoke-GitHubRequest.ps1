function Invoke-GitHubRestMethod() {
    <#
    .SYNOPSIS
    Call the GitHub API

    .DESCRIPTION
    Wrapper for Invoke-RestMethod which will call the GitHub API using the OAuthToken set in Set-GitHubConnection

    .PARAMETER Method
    Method for the request, must be one of "GET", "POST", "PUT" or "DELETE"

    .PARAMETER APIEndpoint
    The GitHub API endpoint to call

    .EXAMPLE
    Invoke-GitHubRestMethod -Method GET -APIEndpoint user
#>
    param(
        [ValidateSet("GET", "POST", "PUT", "DELETE")]
        [string]$Method,
        [ValidateNotNullOrEmpty()]
        [string]$APIEndpoint
    )
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $Protocol = "https"
    $BaseDomain = "api.github.com"
    $UriBuilder = New-Object System.UriBuilder -ArgumentList $Protocol, $BaseDomain, 443, $APIEndpoint

    $Response = Invoke-RestMethod -Method $Method -Uri $UriBuilder.Uri.AbsoluteUri -Headers @{Authorization = "token $Script:GitHubConnection"}

    return $Response
}
