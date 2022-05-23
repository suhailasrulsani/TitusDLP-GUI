
$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
	$Servers = @(get-content -Path "$ScriptDir\Servers.txt")
 
	foreach ($Server in $Servers)
    {
        Write-Host "`n"
        #region Establishing remote connection to $Server
        Write-Host "Establishing remote connection to $Server : " -NoNewline -ForegroundColor Cyan
        Try
        {
            $MySession = New-PSSession -ComputerName $Server -ErrorAction Stop
            Write-Host "Done" -ForegroundColor Green
        }
        
        Catch 
        {
            Write-Warning ($_.Exception.Message)
            Continue
        }
        #endregion  

        #region Check for server OS architecture
        $MyCommands1 =
        {
            Write-Host "Checking OS Architecture : " -NoNewline -ForegroundColor Cyan
            $OS = (Get-WmiObject Win32_OperatingSystem).OsArchitecture
            If ($OS -eq "64-bit")
            {
                Write-Host "64bit" -ForegroundColor Green
                
                #region Check office bitness
                Write-Host "Checking Office Bitness : " -NoNewline -ForegroundColor Cyan
                Try
                {
                    $Bitness = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook" -ErrorAction Stop).Bitness
                    If ($Bitness -eq "x64")
                    {
                        Write-Host "64bit" -ForegroundColor Green

                        #region Installing VC_redist.x64 and VC_redist.x86
                        Write-Host "Installing VC_redist.x64.exe and VC_redist.x86.exe : " -NoNewline -ForegroundColor Cyan
                        cd "C:\Patches\Titus\"
                        cmd.exe /c "VC_redist.x64.exe /q /norestart" > $null 2>&1
                        cmd.exe /c "VC_redist.x86.exe /q /norestart" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green
                        #endregion Installing VC_redist.x64 and VC_redist.x86

                        #region Installing Titus
                        Write-Host "Installing Titus : " -NoNewline -ForegroundColor Cyan
                        cd "C:\Patches\Titus\"
                        cmd.exe /c "msiexec.exe /i TITUS_Classification_Setup_x64.msi INSTALLCLIENT_TMC=0 INSTALLCLIENT_TCO=1 INSTALLCLIENT_TCD=1 OUTLOOK_BITNESS=x64 OFFICE_BITNESS=x64 CONFIGURATIONFILE=https://hkdc2vmtt02.globalnet.lcl/TITUS.prod.tcpg CONFIGLOCATION=https://hkdc2vmtt02.globalnet.lcl/TITUS.prod.tcpg COLLECTORLOCATION=https://hkdc2vmtt02.globalnet.lcl  /qn" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green
                        #endregion Installing Titus

                        #region Restarting explorer and Titus.Enterprise.Client.Service
                        Write-Host "Restarting Explorer : " -NoNewline -ForegroundColor Cyan
                        Write-Host "Done" -ForegroundColor Green
                        Write-Host "Restarting Titus.Enterprise.Client.Service : " -NoNewline -ForegroundColor Cyan
                        Try
                        {
                            Restart-Service -Name Titus.Enterprise.Client.Service -Force -ErrorAction Stop
                            Write-Host "Done" -ForegroundColor Green
                        }

                        Catch
                        {
                            Write-Warning ($_.Exception.Message)
                        }
                        #endregion Restarting explorer and Titus.Enterprise.Client.Service
                    }

                    ElseIf ($Bitness -eq "x86")
                    {
                        Write-Host "32bit" -ForegroundColor Green

                        #region Installing VC_redist.x64 and VC_redist.x86
                        Write-Host "Installing VC_redist.x86.exe and VC_redist.x64.exe : " -NoNewline -ForegroundColor Cyan
                        cd "C:\Patches\Titus\"
                        cmd.exe /c "VC_redist.x86.exe /q /norestart" > $null 2>&1
                        cmd.exe /c "VC_redist.x64.exe /q /norestart" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green
                        #endregion Installing VC_redist.x64 and VC_redist.x86

                        #region Installing Titus
                        Write-Host "Installing Titus : " -NoNewline -ForegroundColor Cyan
                        cd "C:\Patches\Titus\"
                        cmd.exe /c "msiexec.exe /i TITUS_Classification_Setup_x64.msi INSTALLCLIENT_TMC=0 INSTALLCLIENT_TCO=0 INSTALLCLIENT_TCD=1 OUTLOOK_BITNESS=x86 OFFICE_BITNESS=x86 CONFIGURATIONFILE=https://hkdc2vmtt02.globalnet.lcl/TITUS.prod.tcpg CONFIGLOCATION=https://hkdc2vmtt02.globalnet.lcl/TITUS.prod.tcpg COLLECTORLOCATION=https://hkdc2vmtt02.globalnet.lcl /qn" > $null 2>&1
                        cmd.exe /c "msiexec.exe /i TITUS_Classification_Setup_x86.msi INSTALLCLIENT_TMC=0 INSTALLCLIENT_TCO=1 INSTALLCLIENT_TCD=0 OUTLOOK_BITNESS=x86 OFFICE_BITNESS=x86 /qn" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green
                        #endregion Installing Titus

                        #region Restarting explorer and Titus.Enterprise.Client.Service
                        Write-Host "Restarting Explorer : " -NoNewline -ForegroundColor Cyan
                        Write-Host "Done" -ForegroundColor Green
                        Write-Host "Restarting Titus.Enterprise.Client.Service : " -NoNewline -ForegroundColor Cyan
                        Try
                        {
                            Restart-Service -Name Titus.Enterprise.Client.Service -Force -ErrorAction Stop
                            Write-Host "Done" -ForegroundColor Green
                        }

                        Catch
                        {
                            Write-Warning ($_.Exception.Message)
                        }
                        #endregion Restarting explorer and Titus.Enterprise.Client.Service
                    }
                }

                Catch
                {
                    Write-Warning ($_.Exception.Message)
                }
                #endregion   
            }

            ElseIf ($OS -eq "32-bit")
            {
                Write-Host "32bit" -ForegroundColor Green

                #region Check office bitness
                Write-Host "Checking Office Bitness : " -NoNewline -ForegroundColor Cyan
                Try
                {
                    $Bitness = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook" -ErrorAction Stop).Bitness
                    If ($Bitness -eq "x86")
                    {
                        Write-Host "32bit" -ForegroundColor Green

                        #region Installing VC_redist.x86
                        Write-Host "Installing VC_redist.x86.exe : " -NoNewline -ForegroundColor Cyan
                        cd "C:\Patches\Titus\"
                        cmd.exe /c "VC_redist.x86.exe /q /norestart" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green
                        #endregion Installing VC_redist.x86

                        #region Installing Titus
                        Write-Host "Installing Titus : " -NoNewline -ForegroundColor Cyan
                        cd "C:\Patches\Titus\"
                        cmd.exe /c "msiexec.exe /i TITUS_Classification_Setup_x86.msi INSTALLCLIENT_TMC=0 INSTALLCLIENT_TCO=1 INSTALLCLIENT_TCD=1 OUTLOOK_BITNESS=x86 OFFICE_BITNESS=x86 CONFIGURATIONFILE=https://hkdc2vmtt02.globalnet.lcl/TITUS.prod.tcpg CONFIGLOCATION=https://hkdc2vmtt02.globalnet.lcl/TITUS.prod.tcpg COLLECTORLOCATION=https://hkdc2vmtt02.globalnet.lcl  /qn" > $null 2>&1
                        Write-Host "Done" -ForegroundColor Green
                        #endregion Installing Titus

                        #region Restarting explorer and Titus.Enterprise.Client.Service
                        Write-Host "Restarting Explorer : " -NoNewline -ForegroundColor Cyan
                        Write-Host "Done" -ForegroundColor Green
                        Write-Host "Restarting Titus.Enterprise.Client.Service : " -NoNewline -ForegroundColor Cyan
                        Try
                        {
                            Restart-Service -Name Titus.Enterprise.Client.Service -Force -ErrorAction Stop
                            Write-Host "Done" -ForegroundColor Green
                        }

                        Catch
                        {
                            Write-Warning ($_.Exception.Message)
                        }
                        #endregion Restarting explorer and Titus.Enterprise.Client.Service
                    }
                }

                Catch
                {
                    Write-Warning ($_.Exception.Message)
                }
                #endregion
            }
        }

        Invoke-Command -Session $MySession -ScriptBlock $MyCommands1

        Get-PSSession | Remove-PSSession
        #endregion
    }
