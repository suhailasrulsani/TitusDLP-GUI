$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Servers = @(get-content -Path "$ScriptDir\Servers.txt")

Foreach ($Server in $Servers)
{
    Write-Host "`n"        
    Write-Host "$Server" -ForegroundColor White -BackgroundColor Red
    

    #region check if TITUSClassificationSetup.exe exist in Titus folder
    Write-Host "Check if TITUSClassificationSetup exist in C:\Patches\Titus : " -NoNewline
    $pathsetup = "\\$Server\c$\patches\Titus\TITUSClassificationSetup.exe"
    If (Test-Path -Path $pathsetup)
    {
        Write-Host "Done" -ForegroundColor Green
    }

    If (!(Test-Path -Path $pathsetup))
    {
        Write-Host "File not Exist" -ForegroundColor Green
        Write-Host "Transferring setup file to C:\Patches\Titus : " -NoNewline
        New-Item -ItemType Directory -Path "\\$Server\c$\Patches\Titus" -Force -ErrorAction SilentlyContinue > $null 2>&1
        Try { Copy-Item -Path "$ScriptDir\File\*" -Destination "\\$Server\c$\Patches\Titus\" -Force -Recurse -ErrorAction Stop; Write-Host "Done" -ForegroundColor Green } Catch { Write-Warning "Write-Warning ($_.Exception.Message)" }
    }
    #endregion check if TITUSClassificationSetup.exe exist in Titus folder   

    #region check if connection can be established
    Write-Host "Checking remote connection to $Server : " -NoNewline
    Try
    {
        $Session = New-PSSession -ComputerName $Server -ErrorAction Stop
        Write-Host "Done" -ForegroundColor Green
    }

    Catch
    {
        Write-Host "Fail to established connection. Please perform the installation manually." -ForegroundColor Red
        Continue
    }
    #endregion check if connection can be established

}




Get-PSSession | Remove-PSSession