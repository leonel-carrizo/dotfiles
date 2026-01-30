param(
    [switch]$noconfirm,
    [string]$except,
    [switch]$dryrun,
    [switch]$help,

    # Capture unknown parameters
    [Parameter(ValueFromRemainingArguments = $true)]
    $UnknownParams
)

# -----------------------------
# HELP MESSAGE
# -----------------------------
function Show-Help {
    Write-Host ""
    Write-Host "Usage:"
    Write-Host "  clean_profiles.ps1 [-noconfirm] [-dryrun] [-except user1,user2] [-help]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -noconfirm     Do not ask before logging out a user"
    Write-Host "  -dryrun        Do not delete anything; only show actions"
    Write-Host "  -except        Comma-separated list of users to exclude"
    Write-Host "  -help, -h      Show this help message"
    Write-Host ""
}

# -----------------------------
# SHOW HELP IF REQUESTED
# -----------------------------
if ($help -or ($UnknownParams -contains "-h")) {
    Show-Help
    exit 0
}

# -----------------------------
# UNKNOWN PARAMETER CHECK
# -----------------------------
if ($UnknownParams) {
    Write-Host "ERROR: Unknown parameter(s): $UnknownParams"
    Show-Help
    exit 1
}

# -----------------------------
# SCRIPT DIRECTORY & LOGGING
# -----------------------------
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$logFile = Join-Path $scriptDir "log_cleanup_profiles.log"

function Log {
    param([string]$msg)
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "$timestamp - $msg" | Out-File -FilePath $logFile -Append -Encoding utf8
}

Log "=== Cleanup started ==="

# -----------------------------
# DRY RUN MESSAGE
# -----------------------------
if ($dryrun) {
    Write-Host "[DRYRUN] Simulation mode active — no profiles will be deleted."
    Log "[DRYRUN] Simulation mode active — no profiles will be deleted."
}

# -----------------------------
# PROTECTED USERS
# -----------------------------
$protectedUsers = @("localmanager")

if ($except) {
    $extra = $except.Split(",") | ForEach-Object { $_.Trim() }
    $protectedUsers += $extra
}

# System profiles that must never be removed
$systemProfiles = @(
    "C:\Users\Default",
    "C:\Users\Default User",
    "C:\Users\Public",
    "C:\Users\All Users",
    "C:\Users\localmanager"
)

Write-Host "Scanning user profiles..."
Log "Scanning user profiles..."

# -----------------------------
# TOTALS
# -----------------------------
$totalBytes = 0
$totalDeleted = 0
$totalProcessed = 0

# -----------------------------
# GET USER PROFILES
# -----------------------------
$profiles = Get-CimInstance Win32_UserProfile |
    Where-Object {
        $_.LocalPath -like "C:\Users\*" -and
        ($systemProfiles -notcontains $_.LocalPath)
    }

$profileCount = $profiles.Count
$index = 0

foreach ($profile in $profiles) {

    $index++
    $percent = [math]::Round(($index / $profileCount) * 100, 0)

    Write-Progress -Activity "Cleaning Profiles" `
                   -Status "Processing profile $index of $profileCount ($percent%)" `
                   -PercentComplete $percent

    $userPath = $profile.LocalPath
    $userName = Split-Path $userPath -Leaf
    $totalProcessed++

    # Skip protected users
    if ($protectedUsers -contains $userName) {
        Write-Host "`nSkipping protected user: $userName"
        Log "Skipping protected user: $userName"
        continue
    }

    Write-Host "`nProcessing user: $userName"
    Log "Processing user: $userName"

    # -----------------------------
    # CHECK IF USER IS LOGGED IN
    # -----------------------------
    $loggedOn = Get-CimInstance Win32_LoggedOnUser |
                Where-Object { $_.Antecedent.Name -eq $userName }

    if ($loggedOn) {
        Write-Host "User $userName is currently logged in."
        Log "User $userName is logged in."

        # Obtener SessionID real usando "query user"
        $sessionLine = query user | Select-Object -Skip 1 |
                       Where-Object { $_ -match "^\s*$userName\s" }

        if ($sessionLine) {
            $sessionId = ($sessionLine -split "\s+")[2]
        }

        if (-not $sessionId) {
            Write-Host "Could not determine session ID for $userName — skipping logout."
            Log "Could not determine session ID for $userName — skipping logout."
            continue
        }

        if (-not $noconfirm -and -not $dryrun) {
            $answer = Read-Host "Do you want to log out $userName to delete their profile? (y/n)"
            if ($answer -ne "y") {
                Write-Host "Skipping user $userName."
                Log "Skipped $userName (logout refused)."
                continue
            }
        }

        if ($dryrun) {
            Write-Host "[DRYRUN] Would log out $userName (Session ID: $sessionId)"
            Log "[DRYRUN] Would log out $userName (Session ID: $sessionId)"
        }
        else {
            try {
                Write-Host "Logging out $userName (Session ID: $sessionId)..."
                Log "Logging out $userName (Session ID: $sessionId)..."
                logoff.exe $sessionId
                Start-Sleep -Seconds 3
            }
            catch {
                $errMsg = $_.Exception.Message
                Write-Host "Could not log out ${userName}: ${errMsg}"
                Log "ERROR logging out ${userName}: ${errMsg}"
                continue
            }
        }
    }

    # -----------------------------
    # CALCULATE REAL PROFILE FOLDER SIZE
    # -----------------------------
    Write-Host "Calculating profile folder size for $userName..."
    Log "Calculating profile folder size for $userName..."

    try {
        $sizeBytes = (Get-ChildItem -Path $userPath -Recurse -Force -ErrorAction SilentlyContinue |
                      Measure-Object -Property Length -Sum).Sum

        if (-not $sizeBytes) { $sizeBytes = 0 }

        $sizeMB = [math]::Round($sizeBytes / 1MB, 2)
        $sizeGB = [math]::Round($sizeBytes / 1GB, 2)

        Write-Host "Profile folder size: $sizeMB MB ($sizeGB GB)"
        Log "Profile folder size: $sizeMB MB ($sizeGB GB)"

        # Add to total
        $totalBytes += $sizeBytes
    }
    catch {
        Write-Host "Could not calculate profile size."
        Log "ERROR calculating profile size for $userName"
    }

    # -----------------------------
    # DELETE PROFILE
    # -----------------------------
    if ($dryrun) {
        Write-Host "[DRYRUN] Would delete profile: $userPath"
        Log "[DRYRUN] Would delete profile: $userPath"
    }
    else {
        try {
            Write-Host "Deleting profile for $userName..."
            Log "Deleting profile for $userName..."
            Remove-CimInstance -InputObject $profile -ErrorAction Stop
            Write-Host "Profile deleted: $userPath"
            Log "Profile deleted: $userPath"
            $totalDeleted++
        }
        catch {
            $errMsg = $_.Exception.Message
            Write-Host "Failed to delete profile for ${userName}: ${errMsg}"
            Log "ERROR deleting profile for ${userName}: ${errMsg}"
            continue
        }
    }
}

# -----------------------------
# FINAL TOTAL SIZE REPORT
# -----------------------------
$totalGB = [math]::Round($totalBytes / 1GB, 2)
$totalMB = [math]::Round($totalBytes / 1MB, 2)

Write-Host "`n====================================="

if ($dryrun) {
    Write-Host "SUMMARY (DRY RUN)"
    Write-Host "Profiles scanned: $totalProcessed"
    Write-Host "Profiles that would be deleted: $totalProcessed"
    Write-Host "Total size to be cleaned: $totalMB MB ($totalGB GB)"
    Log "Total size to be cleaned: $totalMB MB ($totalGB GB)"
}
else {
    Write-Host "SUMMARY"
    Write-Host "Profiles scanned: $totalProcessed"
    Write-Host "Profiles deleted: $totalDeleted"
    Write-Host "Total size cleaned: $totalMB MB ($totalGB GB)"
    Log "Total size cleaned: $totalMB MB ($totalGB GB)"
}

Write-Host "====================================="

Log "=== Cleanup finished ==="
Write-Host "`nCleanup completed."

