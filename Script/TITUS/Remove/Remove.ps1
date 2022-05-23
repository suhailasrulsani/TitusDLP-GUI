
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

        #region Remove
        #Write-Host "Removing Titus : " -NoNewline -ForegroundColor Cyan
        $MyCommands1 =
        {
            cd "c:\patches\titus"
            cmd.exe /c "TITUS-CleanupTool.exe /run"
        }

        Invoke-Command -Session $MySession -ScriptBlock $MyCommands1

        #region Restart
        $Input_restart = Read-Host "Do you want to restart the server now? (y/n)"
        switch ($Input_restart)
        {
            'y'
            {
                Write-Host "Restarting $Server : " -NoNewline
                Try { Restart-Computer -ComputerName $Server -Force -ErrorAction Stop; Write-Host "Done" -ForegroundColor Green }
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

        Get-PSSession | Remove-PSSession
        #endregion
    }
