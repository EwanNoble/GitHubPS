<#
   _____ _ _   _    _       _     _____   _____
  / ____(_) | | |  | |     | |   |  __ \ / ____|
 | |  __ _| |_| |__| |_   _| |__ | |__) | (___
 | | |_ | | __|  __  | | | | '_ \|  ___/ \___ \
 | |__| | | |_| |  | | |_| | |_) | |     ____) |
  \_____|_|\__|_|  |_|\__,_|_.__/|_|    |_____/
#>

$ExecutionContext.SessionState.Module.OnRemove = {
    Remove-Variable -Name GitHubConnection -Force -ErrorAction SilentlyContinue
}
