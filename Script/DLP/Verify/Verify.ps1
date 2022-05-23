$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Remove-Item -Path "ScriptDir\DLPStatus.xlsx" -Force -ErrorAction SilentlyContinue

$Machinelist = @(get-content -Path "$ScriptDir\Machinelist.txt")
$Results = Foreach ($machine in $machinelist)
{
    Try
    {
        $Session = New-PSSession -ComputerName $machine -ErrorAction Stop
        $MyCommands = 
        {

            #Check Version
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
        Invoke-Command -Session $Session -ScriptBlock $MyCommands
    }

    Catch 
    {
        [PSCustomObject]@{
        Machine         = $machine
        Version        = $null
        'vfsmfd.sys'   = $null
        'vnwcd.sys'    = $null
        'vrtam.sys'    = $null
        'edpa0.log'    = $null
        'edpa_ext0.log'= $null
        'EDPA Service' = $null
        'WDP Service'  = $null
        Status         = 'Fail'
        }
    }
}

#$results | Select-Object Machine, Status, Version, vfsmfd.sys, vnwcd.sys, vrtam.sys, 'edpa0.log', 'edpa_ext0.log', 'EDPA Service', 'WDP Service' | Format-Table -AutoSize

$ConditionalFormat =$(
New-ConditionalText -Text Fail -Range 'B:B' -BackgroundColor Red -ConditionalTextColor Black
New-ConditionalText -Text False -Range 'C:J' -BackgroundColor Red -ConditionalTextColor Black
New-ConditionalText -Text Stopped -Range 'I:J' -BackgroundColor Red -ConditionalTextColor Black
)

$results | Select-Object Machine, Status, Version, vfsmfd.sys, vnwcd.sys, vrtam.sys, 'edpa0.log', 'edpa_ext0.log', 'EDPA Service', 'WDP Service' | Export-Excel -Path "$ScriptDir\DLPStatus.xlsx" -AutoSize -TableName "DLPStatus" -WorksheetName "DLPStatus" -ConditionalFormat $ConditionalFormat -Show -Activate
Get-PSSession | Remove-PSSession
