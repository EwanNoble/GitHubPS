# Courtesy of http://www.codewrecks.com/blog/index.php/2017/05/28/run-pester-in-vsts-build/
param(
    [string]$OutputFile
)
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
Install-Module -Name Pester -Force -Verbose -Scope CurrentUser

Import-Module Pester
Invoke-Pester -OutputFile $outputFile -OutputFormat NUnitXml
