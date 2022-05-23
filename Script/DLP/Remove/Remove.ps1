$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Location = "$Scriptdir\x64\service_shutdown.exe"


    $Input_restart = Read-Host "Uninstall DLP Agent Now? (y/n)"
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

                    If (($Edpa -eq "Stopped") -and ($Wdp -eq "Stopped") ) { Write-Host "Both service is now stopped. Uninstallation will continue now" -ForegroundColor Green }
                    ElseIf (!($Edpa) -and !($Wdp)) { Write-Host "Both service is not exist. Uninstallation will continue now" -ForegroundColor Green }
                    Else {Write-Host "Failed to stop service. Uninstallation will continue anyway"}
                }

                Invoke-Command -Session $MySession -ScriptBlock $MyCommands
                
            #endregion Stop EDPA & WDPA by running service_shutdown.exe

                #region Executing clean_agent.exe
                Write-Host "Executing clean_agent.exe : " -NoNewline

                Try { $OS = (Get-WmiObject Win32_OperatingSystem -ErrorAction Stop).OsArchitecture } Catch { } Finally { $Error.Clear() }
                
                $Path = "\\$machine\c$\Patches\"
                $Source64 = "$ScriptDir\x64\clean_agent.exe"
                $Source32 = "$ScriptDir\x86\clean_agent.exe"

                If ($OS -eq "64-bit") { Try { Copy-Item $Source64 -Destination $Path -Force -Recurse -ErrorAction Stop } Catch { } }
                ElseIf ($OS -eq "32-bit") { Try { Copy-Item $Source32 -Destination $Path -Force -Recurse -ErrorAction Stop } Catch { } }

                $MyCommands2 =
                {
                    Try { cd "C:\Patches" -ErrorAction Stop } Catch { }
                    cmd.exe /c "echo y | clean_agent.exe -p=Welcome1" #> $null 2>&1
                }

                Invoke-Command -Session $MySession -ScriptBlock $MyCommands2
                #endregion Executing clean_agent.exe

                #region Try to Uninstall using msiexec /x method
                $MyCommands3 = 
                {
                    Write-Host "Perform uninstallation using msiexec method and remove leftover : " -NoNewline

                    $Path1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" > $null 2>&1
                    $Installed1 = Get-ChildItem -Path $Path1 | ForEach { Get-ItemProperty $_.PSPath } | Where-Object { ($_.DisplayName -like "*AgentInstall*") -and ($_.Publisher -like "*Symantec Corp*") } > $null 2>&1
                    $String1 = ($Installed1).UninstallString > $null 2>&1
                    $Path2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" > $null 2>&1
                    $Installed2 = Get-ChildItem -Path $Path2 | ForEach { Get-ItemProperty $_.PSPath } | Where-Object { ($_.DisplayName -like "*AgentInstall*") -and ($_.Publisher -like "*Symantec Corp*") } > $null 2>&1
                    $String2 = ($Installed2).UninstallString > $null 2>&1

                    If ($String1) 
                    { 
                        Write-Host "$String1" -ForegroundColor Green
                        Write-Host "Uninstalling DLP : " -NoNewline
                        cmd.exe /c "$String1 /q UNINSTALLPASSWORD=Welcome1" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green

                    }

                    ElseIf ($String2) 
                    { 
                        Write-Host "$String2" -ForegroundColor Green
                        Write-Host "Uninstalling DLP : " -NoNewline
                        cmd.exe /c "$String2 /q UNINSTALLPASSWORD=Welcome1" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green
                    }

                    Else
                    {
                        Write-Host "Done" -ForegroundColor Green
                    }


     
                }

                Invoke-Command -Session $MySession -ScriptBlock $MyCommands3
                #endregion Try to Uninstall using msiexec /x method

                #region Checking status after uninstallation
                Write-Host "Checking Uninstallation Status : " -NoNewline
                $MyCommands4 =
                {

                    $PathVersion = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
                    $PathVersion2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
                    $Installed1 = Get-ChildItem -Path $PathVersion | ForEach { Get-ItemProperty $_.PSPath } | Where-Object { ($_.DisplayName -like "*AgentInstall*") -and ($_.Publisher -like "*Symantec Corp*") }
                    $Installed2 = Get-ChildItem -Path $PathVersion2 | ForEach { Get-ItemProperty $_.PSPath } | Where-Object { ($_.DisplayName -like "*AgentInstall*") -and ($_.Publisher -like "*Symantec Corp*") }

                    If ($Installed1) { $Version = ($Installed1).Displayversion }
                    ElseIf ($Installed2) { $Version = ($Installed2).Displayversion }
                    Else { $Version = "False" }

                    # Check vfsmfd.sys, vnwcd.sys and vrtam.sys
                    $Path1 = "C:\Windows\System32\drivers\vfsmfd.sys"; $Path2 = "C:\Windows\System32\drivers\vnwcd.sys"; $Path3 = "C:\Windows\System32\drivers\vrtam.sys";
                    If (Test-Path -Path $Path1) { $vfsmfd = "True" } Else { $vfsmfd = "False" }
                    If (Test-Path -Path $Path2) { $vnwcd = "True" } Else { $vnwcd = "False" }
                    If (Test-Path -Path $Path3) { $vrtam = "True" } Else { $vrtam = "False" }

                    # Check log file
                    $logfile1 = "C:\Program Files\Manufacturer\Endpoint Agent\edpa0.log"; $logfile2 = "C:\Program Files\Manufacturer\Endpoint Agent\edpa_ext0.log"; $Folder1 = "C:\Program Files\Manufacturer\Endpoint Agent"

                    If (Test-Path -Path $logfile1) { $edpa1 = "True" } Else { $edpa1 = "False" }
                    If (Test-Path -Path $logfile2) { $edpa2 = "True" } Else { $edpa2 = "False" }

                    # Check Services
                    $Edpa = (Get-WmiObject Win32_Service | Where-Object { ($_.Name -like "*EDPA*") }).State; $Wdp = (Get-WmiObject Win32_Service | Where-Object { ($_.Name -like "*WDP*") }).State; $StatusE = $Edpa; $StatusW = $Wdp
                    If ($StatusE -like "*running*") { $ServiceStateE = "Running" } ElseIf ($StatusE -like "*Stopped*") { $ServiceStateE = "Stopped" } ElseIf ($StatusE -eq $null) { $ServiceStateE = "False" }
                    If ($StatusW -like "*running*") { $ServiceStateW = "Running" } ElseIf ($StatusW -like "*Stopped*") { $ServiceStateW = "Stopped" } ElseIf ($StatusW -eq $null) { $ServiceStateW = "False" }

                    [PSCustomObject]@{
                        Machine   = $env:COMPUTERNAME
                        Version        = $Version
                        'vfsmfd.sys'   = $vfsmfd
                        'vnwcd.sys'    = $vnwcd
                        'vrtam.sys'    = $vrtam
                        'edpa0.log'    = $edpa1
                        'edpa_ext0.log'= $edpa2
                        'EDPA Service' = $ServiceStateE
                        'WDP Service'  = $ServiceStateW
                        Status         = 'Success'
                    }
                }
                $results = Invoke-Command -Session $MySession -ScriptBlock $MyCommands4
                $results | Select-Object Machine, Status, Version, vfsmfd.sys, vnwcd.sys, vrtam.sys, 'edpa0.log', 'edpa_ext0.log', 'EDPA Service', 'WDP Service' | Format-Table -AutoSize
                #endregion Checking status after uninstallation

                #region Restart
                $Input_restart = Read-Host "Server need to restart after uninstallation. Do you want to restart the server now? (y/n)"
                switch ($Input_restart)
                {
                    'y'
                    {
                        Write-Host "Restarting $Machine : " -NoNewline
                        Try { Restart-Computer -ComputerName $Machine -Force -ErrorAction Stop; Write-Host "Done" -ForegroundColor Green }
                        Catch { Write-Warning ($_); Continue }
                        Finally { $Error.Clear() }
                    }

                    'n'
                    {
                        Continue
                    }

                    Default { Write-Warning "Invalid Input" }

                }
                #endregion Restart
            }
        }

        'n' 
        { 
            Continue
        }

        Default { Write-Warning "Invalid Input" }
    }
