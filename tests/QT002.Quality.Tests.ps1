Describe "Code quality tests" -Tag "Quality" {

    $Scripts = Get-ChildItem -Path $PSScriptRoot\..\src\*.ps1 -File -Recurse

    $Rules = Get-ScriptAnalyzerRule
    $ExcludeRules = @()

    foreach ($Script in $Scripts) {
        Context $Script.BaseName {
            forEach ($Rule in $Rules) {
                It "Should pass Script Analyzer rule $Rule" {
                    $Result = Invoke-ScriptAnalyzer -Path $Script.FullName -IncludeRule $Rule -ExcludeRule $ExcludeRules
                    $Result.Count | Should Be 0
                }
            }

            It "Should have a unit test file" {
                $Result = Get-ChildItem -Path "$PSScriptRoot\*$($Script.BaseName).Tests.ps1" -File -Recurse
                $Result.Count | Should Be 1
            }
        }
    }
}
