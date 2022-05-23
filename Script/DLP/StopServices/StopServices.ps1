$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Location = "$Scriptdir\x64\service_shutdown.exe"

    $Input_restart = Read-Host "Stop DLP Agent Service Now? (y/n)"
    switch ($Input_restart) 
    {
        'y'
        {
            $Machinelist = @(get-content -Path "$ScriptDir\Machinelist.txt")
            Foreach ($Machine in $Machinelist)
            {
                Write-Host "`n"
                #region Check PSSession Connection
                Write-Host "Establishing remote connection to $machine : "  -NoNewline
                Try { $MySession = New-PSSession -ComputerName $machine -ErrorAction Stop; Write-Host "Done" -ForegroundColor Green }
                Catch { Write-Host "Failed" -ForegroundColor Red; Write-Host "`n"; Continue }
                #endregion Check PSSession Connection

                #region Stop EDPA & WDPA by running service_shutdown.exe
                Write-Host "Stopping EDPA & WDP Services : " -NoNewline

                Try { Copy-Item -Path $Location -Destination "\\$machine\c$\Program Files\Manufacturer\Endpoint Agent\" -ErrorAction Stop } Catch {}
                Try { Copy-Item -Path $Location -Destination "\\$machine\c$\Program Files\Manufacturer (x86)\Endpoint Agent\" -ErrorAction Stop } Catch {}

                $MyCommands = 
                {
                    Try { cd "C:\Program Files\Manufacturer\Endpoint Agent" -ErrorAction Stop } Catch { }
                    cmd.exe /c "service_shutdown.exe -p=Welcome1" > $null 2>&1
                    Try { cd "C:\Program Files (x86)\Manufacturer\Endpoint Agent" -ErrorAction Stop } Catch { }
                    cmd.exe /c "service_shutdown.exe -p=Welcome1" > $null 2>&1

                    $Edpa = (Get-WmiObject Win32_Service | Where-Object { ($_.Name -like "*EDPA*") }).State; $Wdp = (Get-WmiObject Win32_Service  | Where-Object { ($_.Name -like "*WDP*") }).State

                    If (($Edpa -eq "Stopped") -and ($Wdp -eq "Stopped") ) { Write-Host "Both service is now stopped." -ForegroundColor Green }
                    ElseIf (!($Edpa) -and !($Wdp)) { Write-Host "Both service is not exist." -ForegroundColor Green }
                    Else {Write-Host "Failed to stop service."}
                }

                Invoke-Command -Session $MySession -ScriptBlock $MyCommands
                
            #endregion Stop EDPA & WDPA by running service_shutdown.exe
            }
        }

        'n' 
        { 
            Continue
        }

        Default { Write-Warning "Invalid Input" }
    }
