# --- Expose each Public and Private function as part of the module
foreach ($PrivateFunction in Get-ChildItem -Path "$($PSScriptRoot)\Functions\Private\*.ps1" -Recurse -Verbose:$VerbosePreference) {

    # --- Dot source functions
    . $PrivateFunction.FullName
}

foreach ($Publicfunction in Get-ChildItem -Path "$($PSScriptRoot)\Functions\Public\*.ps1" -Recurse -Verbose:$VerbosePreference) {

    # --- Dot source functions
    . $PublicFunction.FullName

    # --- Export functions
    Export-ModuleMember -Function $Publicfunction.BaseName
}

# --- Clean up variables on module removal
$ExecutionContext.SessionState.Module.OnRemove = {
    Remove-Variable -Name GitHubConnection -Force -ErrorAction SilentlyContinue
}
