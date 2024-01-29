<#
.NOTES
    Script Name: 00-CreateHyperVVM-async.ps1
    Author: Joseph Young <joe@youngsecurity.net>
    Date: 1/29/2024
    Copyright: (c) Young Security Inc.
    Licensed under the MIT License.
.SYNOPSIS
    This script boilerplate requires the `00-CreateHyperVVM.ps1` script and will create Hyper-V resources async on the local system.
.DESCRIPTION
    This script asynchronously runs the `00-CreateHyperVVM.ps1` script which requires eight arguments to be passed or defaults will be used.
    Arguments can be passed two ways.
        1. CLI prompts
        2. Using the `$argumentJob#` array variables for automation.
    

.EXAMPLE
    .\00-CreateHyperVVM-async.ps1 <arguments>
#>
function Get-UserInput {
    param (
        [string]$prompt,
        [int]$defaultValue
    )
    Write-Host "{$prompt}: " -NoNewline
    $userResponse = Read-Host
    if (-not $userResponse -or $userResponse -match '\D') { # Checks if input is not a number
        return $defaultValue
    }
    return [int]$userResponse
}

$scriptPath = ".\00-CreateHyperVVM.ps1"
$vmBaseName = "carl-nix-"
$vmStartIndex = 4

# Ask the user for the number of VMs to create
$vmCount = Get-UserInput -prompt "Enter the number of Hyper-V VMs to create" -defaultValue 5

$vmParams = for ($i = 0; $i -lt $vmCount; $i++) {
    @{
        vmName = "$vmBaseName$($vmStartIndex + $i)"
        cpu = '4'
        memory = '4GB'
        vmDirectoryPath = 'F:\Hyper-V\Virtual Machines\'
        vhdxPath = "F:\Hyper-V\Virtual Machines\$vmBaseName$($vmStartIndex + $i)\Virtual Hard Disks\$vmBaseName$($vmStartIndex + $i).vhdx"
        vhdxSize = '15GB'
        isoPath = 'E:\!_Apps\!_Linux\!_Ubuntu\ubuntu-23.10-live-server-amd64.iso'
        switchName = 'VM-TRUNK'
    }
}

$jobs = @()

foreach ($params in $vmParams) {
    $job = Start-Job -ScriptBlock {
        param($scriptPath, $params)
        & $scriptPath @params
    } -ArgumentList $scriptPath, $params
    $jobs += $job
}

# Wait and retrieve results
$jobs | Wait-Job
$results = $jobs | ForEach-Object { Receive-Job -Job $_ }

# Output the results
$results | ForEach-Object { Write-Output $_ }

# Clean up
$jobs | Remove-Job
