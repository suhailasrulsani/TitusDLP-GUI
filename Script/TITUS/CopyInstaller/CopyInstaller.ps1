$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

    $Servers = @(get-content -Path "$ScriptDir\Servers.txt")
 
	foreach ($Server in $Servers)
    {
        Write-Host "Copying Installer and Cleanup Tool to $Server : " -NoNewline -ForegroundColor Cyan
        Try 
        { 
            New-Item -ItemType Directory -Path "\\$Server\c$\Patches" -Force -ErrorAction Stop | Out-Null
            New-Item -ItemType Directory -Path "\\$Server\c$\Patches\Titus" -Force -ErrorAction Stop | Out-Null
            Start-BitsTransfer -DisplayName "Transferring to $Server" -Source "$ScriptDir\File\*" -Destination "\\$Server\c$\Patches\Titus" -ErrorAction Stop
            #Copy-Item "$ScriptDir\File\*" -Destination "\\$Server\c$\Patches\Titus" -Force -ErrorAction Stop | Out-Null
            Write-Host "Done" -ForegroundColor Green
        }

        Catch 
        {
            Write-Warning ($_.Exception.Message)
            Continue
        }
        
    }
