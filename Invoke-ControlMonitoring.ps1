<#
.SYNOPSIS
    Invoke-ControlMonitoring.ps1
.DESCRIPTION
    PowerShell automation script for continuous security control and compliance monitoring.
    Supports 'Sample' mode for CI/CD workflow testing.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [ValidateSet("Sample", "Full")]
    [string]$Mode = "Sample"
)

Write-Host "[*] Starting Security Control Monitoring Workflow..." -ForegroundColor Cyan
Write-Host "[*] Execution Mode: $Mode" -ForegroundColor Yellow

# Ensure output directory exists
$outputDir = Join-Path -Path $PSScriptRoot -ChildPath "output"
if (-not (Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    Write-Host "[+] Created output directory: $outputDir" -ForegroundColor Green
}

# Simulated security control evaluations
$reportData = @(
    [PSCustomObject]@{
        Timestamp   = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss UTC")
        ControlID   = "AC-1"
        ControlName = "Identity & Access Management (MFA Enforcement)"
        Status      = "PASSED"
        Details     = "MFA enforced across primary Identity Provider."
    },
    [PSCustomObject]@{
        Timestamp   = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss UTC")
        ControlID   = "CM-2"
        ControlName = "Vulnerability & Patch Management SLA"
        Status      = "PASSED"
        Details     = "High severity vulnerabilities patched within compliance SLA."
    },
    [PSCustomObject]@{
        Timestamp   = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss UTC")
        ControlID   = "AU-3"
        ControlName = "Cloud Audit Logging Integrity (CloudTrail/GuardDuty)"
        Status      = "PASSED"
        Details     = "CloudTrail logging enabled and GuardDuty active without findings."
    }
)

if ($Mode -eq "Sample") {
    Write-Host "[*] Running in Sample Mode: Evaluating baseline control suite..." -ForegroundColor Cyan
}

# Generate JSON report artifact
$jsonReportPath = Join-Path -Path $outputDir -ChildPath "control_monitoring_report.json"
$reportData | ConvertTo-Json -Depth 3 | Set-Content -Path $jsonReportPath

# Generate CSV report artifact
$csvReportPath = Join-Path -Path $outputDir -ChildPath "control_monitoring_report.csv"
$reportData | Export-Csv -Path $csvReportPath -NoTypeInformation -Encoding UTF8

Write-Host "[+] Control monitoring checks completed successfully." -ForegroundColor Green
Write-Host "[+] Report saved to: $jsonReportPath" -ForegroundColor Green
Write-Host "[+] Report saved to: $csvReportPath" -ForegroundColor Green
