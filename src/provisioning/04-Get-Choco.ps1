# Install Choco from an elevated PowerShell session                                                             
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# After choco is done installing, add more apps
choco install -y chocolateygui googlechrome lastpass grammarly winrar python3 treesizefree