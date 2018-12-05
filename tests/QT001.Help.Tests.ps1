# --- Validate the module manifest
$ModulePath = (Resolve-Path -Path .\src\*.psd1).Path

Describe -Name 'Module Tests' -Fixture {
    It -Name "The module has a valid manifest file" -Test {
        {Test-ModuleManifest -Path $ModulePath} | Should Not Throw
    }
}

# --- Import Module once the manifest test has passed
Import-Module $ModulePath -Force -Global

# --- Ensure that each function has valid help
Describe "Help tests for GitHubPS Public Functions" -Tags "Quality" {

    $Functions = Get-Command -Module GitHubPS -CommandType Function

    foreach ($Function in $Functions) {

        $Help = Get-Help $Function.name

        Context $Help.name {

            It "Has a Synopsis" {
                $Help.synopsis | Should Not BeNullOrEmpty
            }

            It "Has a description" {
                $Help.description | Should Not BeNullOrEmpty
            }

            It "Has an example" {
                $Help.examples | Should Not BeNullOrEmpty
            }

            foreach ($Parameter in $Help.parameters.parameter) {

                if ($Parameter -notmatch 'whatif|confirm') {

                    It "Has a Parameter description for '$($Parameter.name)'" {
                        $Parameter.Description.text | Should Not BeNullOrEmpty
                    }
                }
            }
        }
    }
}

Describe "Help tests for GitHubPS Private Functions" -Tags "Quality" {

    $Scripts = Get-ChildItem -Path $PSScriptRoot\..\src\Functions\Private\*.ps1 -File -Recurse
    $Scripts | ForEach-Object {
        Remove-Module $_.BaseName -ErrorAction SilentlyContinue
    }

    foreach ($Script in $Scripts) {
        $CurrentFunctions = Get-ChildItem function:
        Import-Module $Script
        $ScriptFunctions = Get-ChildItem function: | Where-Object { $CurrentFunctions -notcontains $_ }

        foreach ($ScriptFunction in $ScriptFunctions) {
            $Help = Get-Help $ScriptFunction.name

            Context $Script.BaseName {

                It "Has a synopsis" {
                    $Help.Synopsis | Should Not BeNullOrEmpty
                }

                It "Has a description" {
                    $Help.Description | Should Not BeNullOrEmpty
                }

                It "Has an example" {
                    $Help.Examples | Should Not BeNullOrEmpty
                }

                foreach ($Parameter in $Help.Parameters.Parameter) {
                    if ($Parameter -notmatch 'whatif|confirm') {
                        It "Has a Parameter description for $($Parameter.Name)" {
                            $Parameter.Description.Text | Should Not BeNullOrEmpty
                        }
                    }
                }
            }
        }
    }
}
