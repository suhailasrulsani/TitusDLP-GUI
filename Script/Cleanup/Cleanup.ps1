Clear-Host
$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Servers = @(get-content -Path "$ScriptDir\servers.txt")

Foreach ($Server in $Servers)
{
    Write-Host "Cleaning up c:\patches in $Server : " -NoNewline

    Function cleanc
    {
        Try
        {
            New-Item -ItemType Directory -Path "\\$Server\c$\patches" -Force -ErrorAction Stop > $null 2>&1
            Remove-Item -Path "\\$Server\c$\patches\*" -Force -Recurse -ErrorAction Stop
            Copy-Item -Path "$ScriptDir\InstallUpdatesh.Vbs" -Destination "\\$Server\c$\patches\" -ErrorAction Stop
            #Copy-Item -Path "$ScriptDir\File\*" -Destination "\\$Server\c$\patches\" -ErrorAction Stop
            Write-Host "Done" -ForegroundColor Green
        }

        Catch
        {
            Write-Warning ($_.Exception.Message)
        }
    }




    cleanc
}