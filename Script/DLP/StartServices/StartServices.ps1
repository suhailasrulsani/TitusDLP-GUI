$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$Machinelist = @(get-content -Path "$ScriptDir\Machinelist.txt")
Foreach ($Machine in $machinelist)
    {
        $Machinelist = @(get-content -Path "$ScriptDir\Machinelist.txt")
        Get-PSSession | Remove-PSSession
        Write-Host "$machine : " -NoNewline
        Try { $MySession = New-PSSession -ComputerName $machine -ErrorAction Stop; }
        Catch { Write-Host "Failed" -ForegroundColor Red; Write-Host "`n"; Continue }
        Finally { $Error.Clear() }

        Write-Host
        $MyCommands =
        {
            Write-Host "Starting EDPA : " -NoNewline
            Try
            {
                Set-Service -Name EDPA -StartupType Automatic -ErrorAction Stop
                Start-Service -Name EDPA -ErrorAction Stop
                Write-Host "Done" -ForegroundColor Green
            }   


            Catch
            {
                Write-Warning ($_.Exception.Message)
            }

            Write-Host "Starting WDP : " -NoNewline
            Try
            {
                Set-Service -Name WDP -StartupType Automatic -ErrorAction Stop
                Start-Service -Name WDP -ErrorAction Stop
                Write-Host "Done" -ForegroundColor Green
            }   


            Catch
            {
                Write-Warning ($_.Exception.Message)
            }

        }
    Invoke-Command -Session $MySession -ScriptBlock $MyCommands -ErrorAction Stop
    }
    Write-Host "`n"
