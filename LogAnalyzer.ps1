<#
.SYNOPSIS
    SharePoint/Windows Log Analyzer Script

.DESCRIPTION
    This script parses ULS or Windows Event logs, extracts
    ERROR/WARNING messages, and exports results into a CSV or HTML file.
    Useful for admins who want quick visibility into issues.

.NOTES
    Author: Christopher
    GitHub: https://github.com/<your-username>
#>

param (
    [string]$LogPath = "C:\Logs\ULS.log",
    [string]$OutputPath = ".\LogReport.csv",
    [switch]$HTML
)

Write-Host "Analyzing logs from $LogPath..." -ForegroundColor Cyan

if (!(Test-Path $LogPath)) {
    Write-Error "Log file not found at $LogPath"
    exit
}

# Read and filter log lines
$logData = Get-Content $LogPath | Where-Object {
    ($_ -match "ERROR") -or ($_ -match "WARNING")
}

$parsedData = @()

foreach ($line in $logData) {
    $fields = $line -split "\s{2,}"   # split on multiple spaces
    if ($fields.Length -ge 3) {
        $parsedData += [PSCustomObject]@{
            Timestamp = $fields[0]
            Process   = $fields[1]
            Message   = $fields[-1]
            Level     = if ($line -match "ERROR") { "ERROR" } else { "WARNING" }
        }
    }
}

# Export results
if ($HTML) {
    $htmlPath = [System.IO.Path]::ChangeExtension($OutputPath, "html")
    $parsedData | ConvertTo-Html -Property Timestamp, Process, Level, Message -Title "Log Report" |
        Out-File $htmlPath
    Write-Host "HTML Report saved to $htmlPath" -ForegroundColor Green
} else {
    $parsedData | Export-Csv -Path $OutputPath -NoTypeInformation
    Write-Host "CSV Report saved to $OutputPath" -ForegroundColor Green
}
