$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent



    $Machinelist = @(get-content -Path "$ScriptDir\Machinelist.txt")
    Foreach ($Machine in $Machinelist)
    {
        Write-Host "`n"
        Write-Host "Establishing remote connection to $machine : "  -NoNewline
        Try { $MySession = New-PSSession -ComputerName $machine -ErrorAction Stop; Write-Host "Done" -ForegroundColor Green }
        Catch { Write-Host "Failed" -ForegroundColor Red; Write-Host "`n"; Continue }
        
        
        $MyCommands = 
        {
            Write-Host "Upgrading : " -NoNewline
            Try { cd "C:\Patches" -ErrorAction Stop } Catch { }
            cmd.exe /c "upgrade_agent.bat" > $null 2>&1
            
            $Path1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
            $Installed1 = Get-ChildItem -Path $Path1 | ForEach { Get-ItemProperty $_.PSPath } | Where-Object { ($_.DisplayName -like "*AgentInstall*") -and ($_.Publisher -like "*Symantec Corp*") }
            $Version1 = ($Installed1).Displayversion

            If ($Version1 -eq "15.7.00200.01114") 
            { 
            Write-Host "Done" -ForegroundColor Green
            }

            ElseIf ($Version1 -notlike "*15.7.00200.01114*") 
            { 
            Write-Host "Upgrade failed" -ForegroundColor Red
            }

            Else 
            { 
            Write-Warning "Unable to find version" 
            }

        }

        Invoke-Command -Session $MySession -ScriptBlock $MyCommands
    }
