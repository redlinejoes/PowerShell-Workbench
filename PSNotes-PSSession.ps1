$HostNames = Get-Content "G:\My Drive\!_Work\Notes\PowerShell-Workbench\hostnames.txt"

try {
    ForEach ($HostName in $HostNames) {     
        $PSSession = New-PSSession -ComputerName $HostName #-Credential (Get-Credential)
        Invoke-Command -Session $PSSession -ScriptBlock { # some code            
            Write-Host `r
            Write-Host "hostname:" (hostname)
            Write-Host "whoami:" (whoami)                       
            
            # Upgrade already installed apps
            #winget upgrade --accept-source-agreements --include-unknown
            winget upgrade --accept-source-agreements --include-unknown --all
            #winget upgrade --accept-source-agreements --accept-package-agreements --id SlackTechnologies.Slack
            #winget upgrade --accept-source-agreements --accept-package-agreements --id Notepad++.Notepad++
            #winget upgrade --accept-source-agreements --accept-package-agreements --id MoonlightGameStreamingProject.Moonlight
            #winget upgrade --accept-source-agreements --accept-package-agreements --id Microsoft.PowerToys
            
            # Do not upgrade these apps
            #RoyalApps.RoyalTS

            # Install apps if they are not already installed
            #winget install -e --silent --accept-source-agreements --accept-package-agreements --id clsid2.mpc-hc
            
        } -ErrorAction Continue # Error handling
    }    
}
catch {    
    Write-Host "An Error Occured" -ForegroundColor Red
    Write-Host $PSItem.Exception.Message -ForegroundColor Red
}
finally {
    Write-Host `r`n
    $Error.Clear()
    Remove-PSSession -Session $PSSession
}
