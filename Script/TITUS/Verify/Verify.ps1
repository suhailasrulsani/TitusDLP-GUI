$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Remove-Item -Path "$ScriptDir\TitusStatus.xlsx" -Force -ErrorAction SilentlyContinue

	$Servers = @(get-content -Path "$ScriptDir\Servers.txt")
    $Results1 = Foreach ($Server in $Servers)
    {
        Try
        {
            $MySession = New-PSSession -ComputerName $Server -ErrorAction Stop
            $MyCommands1 =
            {
                #region Checking Version
                $PathVersion = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
                $PathVersion2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
                $Installed1 = Get-ChildItem -Path $PathVersion | ForEach { Get-ItemProperty $_.PSPath } | Where-Object { $_.Publisher -like "*Titus Inc. (http://www.titus.com)*" }
                $Installed2 = Get-ChildItem -Path $PathVersion2 | ForEach { Get-ItemProperty $_.PSPath } | Where-Object { $_.Publisher -like "*Titus Inc. (http://www.titus.com)*" }

                If ($Installed1) { $Version = ($Installed1).Displayversion }
                ElseIf ($Installed2) { $Version = ($Installed2).Displayversion }
                Else { $Version = "False" }

                If ($Version -eq "21.3.2124.4")
                {
                    $Version1 = "21.3.2124.4"
                }

                Else
                {
                    $Version1 = "Incorrect"
                }
                #endregion Checking Version

                $Titus1 = (Get-WmiObject Win32_Service | Where-Object { ($_.Name -like "*Titus.Enterprise.Client.Service*") }).State; $Titus2 = (Get-WmiObject Win32_Service | Where-Object { ($_.Name -like "*Titus.Enterprise.HealthMonitor.Service*") }).State; $StatusE = $Titus1; $StatusW = $Titus2
                If ($StatusE -like "*running*") { $ServiceStateE = "Running" } ElseIf ($StatusE -like "*Stopped*") { $ServiceStateE = "Stopped" } ElseIf ($StatusE -eq $null) { $ServiceStateE = "False" }
                If ($StatusW -like "*running*") { $ServiceStateW = "Running" } ElseIf ($StatusW -like "*Stopped*") { $ServiceStateW = "Stopped" } ElseIf ($StatusW -eq $null) { $ServiceStateW = "False" }

                $Desktop = (Get-ChildItem -Path "C:\Program Files\TITUS\TITUS Classification for Desktop" | Measure-Object).Count
                If ($Desktop -like "*34*")
                {
                    $Desktop1 = "34"
                }

                Else
                {
                    $Desktop1 = "Missing"
                }

                $Classification = (Get-ChildItem -Path "C:\Program Files\TITUS\Titus Message Classification" | Measure-Object).Count
                If ($Classification -like "*1*")
                {
                    $Classification1 = "1"
                }

                Else
                {
                    $Classification1 = "Missing"
                }

                $Plugins = (Get-ChildItem -Path "C:\Program Files\TITUS\Titus Plugins" | Measure-Object).Count
                If ($Plugins -like "*32*")
                {
                    $Plugins1 = "32"
                }

                Else
                {
                    $Plugins1 = "Missing"
                }
    

                $Services = (Get-ChildItem -Path "C:\Program Files\TITUS\Titus Services" -Recurse | Measure-Object).Count
                If ($Services -like "*250*")
                {
                    $Services1 = "250"
                }

                Else
                {
                    $Services1 = "Missing"
                }
         

                $Shared = (Get-ChildItem -Path "C:\Program Files\TITUS\Titus Shared" | Measure-Object).Count
                If ($Shared -like "*34*")
                {
                    $Shared1 = "34"
                }

                Else
                {
                    $Shared1 = "Missing"
                }
           

                [PSCustomObject]@{
                Server = $env:COMPUTERNAME
                Status = 'Success'
                Version = $Version1
                'Titus Enterprise Client Service' = $ServiceStateE
                'Titus Enterprise Health Monitor Service' = $ServiceStateW
                Desktop = $Desktop1
                Classification = $Classification1
                Plugins = $Plugins1
                Services = $Services1
                Shared = $Shared1

                }
            }
            Invoke-Command -Session $MySession -ScriptBlock $MyCommands1
        }

        Catch
        {
            [PSCustomObject]@{
            Server = $Server
            Status = 'Fail'
            Version = $null
            'Titus Enterprise Client Service' = $null
            'Titus Enterprise Health Monitor Service' = $null
            Desktop = $null
            Classification = $null
            Plugins = $null
            Services = $null
            Shared = $null
            }
        }
    }

    $ConditionalFormat =$(
    New-ConditionalText -Text Fail -Range 'B:B' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Incorrect -Range 'C:C' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Stopped -Range 'D:D' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Stopped -Range 'E:E' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Missing -Range 'F:F' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Missing -Range 'G:G' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Missing -Range 'H:H' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Missing -Range 'I:I' -BackgroundColor Red -ConditionalTextColor Black
    New-ConditionalText -Text Missing -Range 'J:J' -BackgroundColor Red -ConditionalTextColor Black
)

$results1 | Select-Object Server, Status, Version, 'Titus Enterprise Client Service', 'Titus Enterprise Health Monitor Service', Desktop, Classification, Plugins, Services, Shared | Export-Excel -Path "$ScriptDir\TitusStatus.xlsx" -AutoSize -TableName "TitusStatus" -WorksheetName "TitusStatus" -ConditionalFormat $ConditionalFormat -Show -Activate
Get-PSSession | Remove-PSSession
