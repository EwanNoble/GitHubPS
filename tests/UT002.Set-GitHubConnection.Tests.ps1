. "$PSScriptRoot\..\src\Functions\Public\Set-GitHubConnection.ps1"

Describe "Set-GitHubConnection" -Tag "Unit" {

    It "Should use TLS 1.2" {
        Mock Invoke-RestMethod { return @{}}

        Set-GitHubConnection -OAuthToken "Whatever"

        [Net.ServicePointManager]::SecurityProtocol.Equals([Net.SecurityProtocolType]::Tls12) | Should Be $true
    }

    It "Should set a Script variable when successful" {
        Mock Invoke-RestMethod {
            return @{
                StatusCode = 200
            }
        }

        $OAuthToken = "Whatever"

        Set-GitHubConnection -OAuthToken $OAuthToken
        $Script:GitHubConnection | Should Be $OAuthToken
    }

    It "Should throw if unauthorized PAT" {
        Mock Invoke-RestMethod {
            throw [System.Net.WebException]::new()
        }

        $OAuthToken = "Whatever"

        {Set-GitHubConnection -OAuthToken $OAuthToken} | Should throw
    }
}
