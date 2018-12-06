. "$PSScriptRoot\..\src\Functions\Private\Invoke-GitHubRestMethod.ps1"

Describe "Invoke-GitHubRestMethod" -Tag "Unit" {

    It "Should use TLS 1.2" {
        Mock Invoke-RestMethod { return @{}}

        Invoke-GitHubRestMethod -Method GET -APIEndpoint "user"

        [Net.ServicePointManager]::SecurityProtocol.Equals([Net.SecurityProtocolType]::Tls12) | Should Be $true
    }
}
