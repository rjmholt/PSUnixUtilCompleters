# Informative messages to let users know that completers have been registered

Write-Warning @"
=== DEPRECATION NOTICE ===

This module is now available as Microsoft.PowerShell.UnixCompleters.
The PSUnixUtilCompleters module package is now deprecated in favour of the new package,
and will not be receiving updates.

To update to the new module:

    Install-Module Microsoft.PowerShell.UnixCompleters

Don't forget to uninstall this module in the next PowerShell session.
"@

Write-Verbose "Registering UNIX native util completers"

# We don't have access to the module at load time, since loading occurs last
# Instead we set up a one-time event to set the OnRemove scriptblock once the module has been loaded
$null = Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -MaxTriggerCount 1 -Action {
    $m = Get-Module PSUnixUtilCompleters
    $m.OnRemove = {
        Write-Verbose "Deregistering UNIX native util completers"
    }
}