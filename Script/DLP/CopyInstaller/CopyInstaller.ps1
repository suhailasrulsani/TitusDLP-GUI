$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Machinelist = @(get-content -Path "$ScriptDir\Machinelist.txt")

#BalikPapan
$BPN = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\BPNKRNVMDLPED01-Balikpapan\AgentInstallers\AgentInstaller_Win64\*"
#Dumai
$DMI = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\PKUVMDLPED01-Pekan Baru\AgentInstallers\AgentInstaller_Win64\*"
#Jakarta
$JKT = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\JKTVMDLPED01-Jakarta\AgentInstaller_Win64\*"
#Kerinci
$KER = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\KERVMDLPED01-Kerinci\AgentInstallers\AgentInstaller_Win64\*"
#Marunda
$MAR = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\JKTVMDLPED01-Jakarta\AgentInstaller_Win64\*"
#Medan
$MED = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\MEDVMDLPED01-Medan\AgentInstallers\AgentInstaller_Win64\*"
#Padang
$PDG = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\PKUVMDLPED01-Pekan Baru\AgentInstallers\AgentInstaller_Win64\*"
#PekanBaru
$PKU = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\PKUVMDLPED01-Pekan Baru\AgentInstallers\AgentInstaller_Win64\*"
#Porsea
$PSA = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\PSAVMDLPED01-Porsea\AgentInstallers\AgentInstaller_Win64\*"
#Beijing
$BJ = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#JiuJiang
$JJ = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\JXVMDLPED01-Jiujiang (Jiangxi)\AgentInstallers\AgentInstaller_Win64\*"
#Longtan
$LTA = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#Nanjing
$NJ = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#Putian
$PT = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\JXVMDLPED01-Jiujiang (Jiangxi)\AgentInstallers\AgentInstaller_Win64\*"
#Rizhao
$RZ = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\RZVMDLPED01-Rizhao\AgentInstallers\AgentInstaller_Win64\*"
#ShangHai
$SZDCSH = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#ShangHai
$SZDCSC = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#SuQian
$SQ = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\RZVMDLPED01-Rizhao\AgentInstallers\AgentInstaller_Win64\*"
#Wuxi
$WX = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#Xiamen
$XM = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#XinHui
$XH = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#Zhangzhou
$SZDCZZ = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\XHVMDLPED01-Xinhui\AgentInstallers\AgentInstaller_Win64\*"
#KL
$KUL = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\KULBSCVMDLPED01-Averis BS\AgentInstallers\AgentInstaller_Win64\*"
#Jakarta
$RAP = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\JKTVMDLPED01-Jakarta\AgentInstaller_Win64\*"
#Mentakab
$MTK = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\KULBSCVMDLPED01-Averis BS\AgentInstallers\AgentInstaller_Win64\*"
#Singapore
$SIN = "\\Kulbscvmfs03.globalnet.lcl\it\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\SINUOBVMDLPED01-Singapore\AgentInstallers\SG_AgentInstaller_Win64_15.7MP2\*"
#LiYang
$LL = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\JXVMDLPED01-Jiujiang (Jiangxi)\AgentInstallers\AgentInstaller_Win64\*"
#Vancouver
$VAN = "\\Kulbscvmfs03.globalnet.lcl\it\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\SINUOBVMDLPED01-Singapore\AgentInstallers\SG_AgentInstaller_Win64_15.7MP2\*"
#Macao
$MOM = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\HK1VMDLPED01-HongKong AON\AgentInstallers\HK_AgentInstaller_Win64_15.7MP2\*"
#Macao
$MC = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\HK1VMDLPED01-HongKong AON\AgentInstallers\HK_AgentInstaller_Win64_15.7MP2\*"
#HongKong
$HK = "\\kulbscvmfs03\IT\98 Software Installer\99-Other\DLP Agents\DLP\15.7MP2 - Endpoint Agent Installers\HK1VMDLPED01-HongKong AON\AgentInstallers\HK_AgentInstaller_Win64_15.7MP2\*"



$Machinelist = @(get-content -Path "$ScriptDir\Machinelist.txt")
Foreach ($machine in $Machinelist)
{
    Write-Host "`n"
    Write-Host "$Machine" -ForegroundColor White -BackgroundColor Red
    
    Write-Host "Site : " -NoNewline
    If ($Machine -match '^DMI')
    {
        Write-Host "Dumai" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $DMI -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^KUL')
    {
        Write-Host "KualaLumpur" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $KUL -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^BPN')
    {
        Write-Host "BalikPapan" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $BPN -Destination $Patches -ErrorAction Stop | Out-Null
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^JKT')
    {
        Write-Host "Jakarta" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $JKT -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^RAP')
    {
        Write-Host "Jakarta" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $JKT -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^KER')
    {
        Write-Host "Kerinchi / Pectech" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $KER -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^MAR')
    {
        Write-Host "Marunda" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $JKT -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^MED')
    {
        Write-Host "Marunda" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $MAR -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^PDG')
    {
        Write-Host "Padang" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $PKU -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^PKU')
    {
        Write-Host "PekanBaru" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $PKU -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^PSA')
    {
        Write-Host "Porsea" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $PSA -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^BJ')
    {
        Write-Host "Beijing" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $BJ -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^LTA')
    {
        Write-Host "Longtan" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $LTA -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^NJ')
    {
        Write-Host "Nanjing" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $NJ -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^PT')
    {
        Write-Host "Putian" -ForegroundColor Green
        Write-Host "Copying Installer to $Machine : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $PT -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^RZ')
    {
        Write-Host "Rizhao" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $RZ -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^SZDCSH')
    {
        Write-Host "ShangHai" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $SZDCSH -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^SZDCSC')
    {
        Write-Host "ShangHai" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $SZDCSC -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^SQ')
    {
        Write-Host "SuQian" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $SQ -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^WX')
    {
        Write-Host "Wuxi" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $WX -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^XM')
    {
        Write-Host "Xiamen" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $XM -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^XH')
    {
        Write-Host "Xinhui" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $XH -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^SZDCZZ*')
    {
        Write-Host "Zhangzhou" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $SZDCZZ -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^JJ*')
    {
        Write-Host "JiuJiang" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $JJ -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

     ElseIf ($Machine -match '^PTA*')
    {
        Write-Host "Putian" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $PTA -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^MTK*')
    {
        Write-Host "Mentakab" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $MTK -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^SIN*')
    {
        Write-Host "Singapore" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $SIN -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }
    
   ElseIf ($Machine -match '^LL*')
    {
        Write-Host "Liyang" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $LL -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^VAN*')
    {
        Write-Host "Vancouver" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $VAN -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^MC*')
    {
        Write-Host "Macao" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $MC -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^MOM*')
    {
        Write-Host "Macao" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $MOM -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }

    ElseIf ($Machine -match '^HK*')
    {
        Write-Host "HongKong" -ForegroundColor Green
        Write-Host "Copying Installer : " -NoNewline

        $Patches = "\\$Machine\c$\Patches\"
        $InstallAgent = "\\$Machine\c$\Patches\Install_Agent.bat"

        New-Item -ItemType Directory -Path $Patches -Force -ErrorAction Stop | Out-Null
        Start-BitsTransfer -DisplayName "Transferring to $Machine" -Source $HK -Destination $Patches -ErrorAction Stop
        If (Test-Path $InstallAgent) { Write-host "SUCCESS" -ForegroundColor Green  }
        Elseif (!(Test-Path $InstallAgent)) { Write-Host "FAILED" -ForegroundColor Red }
    }
        
    }