# kommandr installer (Windows PowerShell)
#   irm https://raw.githubusercontent.com/colbymchenry/kommandr/main/install.ps1 | iex
#
# Downloads the prebuilt kommandr.exe for your CPU from the latest GitHub release,
# verifies its sha256, installs it to ~\.kommandr\bin, and adds that to your PATH.
# Native Windows -- no WSL, no tmux (kommandr runs PowerShell via ConPTY), and the
# binary self-updates after install.
#
# Env overrides:
#   $env:KOMMANDR_VERSION=v0.1.0     pin a release (default: latest)
#   $env:KOMMANDR_HOME=...           install root (default: ~\.kommandr)
#   $env:KOMMANDR_BASE_URL=...       download from a mirror instead of GitHub
$ErrorActionPreference = 'Stop'

$Repo     = 'colbymchenry/kommandr'
$KommHome = if ($env:KOMMANDR_HOME) { $env:KOMMANDR_HOME } else { Join-Path $HOME '.kommandr' }
$BinStore = Join-Path $KommHome 'bin'
$Version  = if ($env:KOMMANDR_VERSION) { $env:KOMMANDR_VERSION } else { 'latest' }

function Say($m) { Write-Host "[kommandr] $m" -ForegroundColor Cyan }
function Die($m) { Write-Host "[kommandr] $m" -ForegroundColor Red; exit 1 }

# --- detect arch -----------------------------------------------------------
switch ($env:PROCESSOR_ARCHITECTURE) {
  'AMD64' { $arch = 'amd64' }
  'ARM64' { $arch = 'arm64' }
  default { Die "unsupported architecture '$($env:PROCESSOR_ARCHITECTURE)' (need 64-bit x64 or ARM64)." }
}
$asset = "kommandr-windows-$arch.exe"

# --- resolve base URL ------------------------------------------------------
if     ($env:KOMMANDR_BASE_URL) { $base = $env:KOMMANDR_BASE_URL.TrimEnd('/') }
elseif ($Version -eq 'latest')  { $base = "https://github.com/$Repo/releases/latest/download" }
else                            { $base = "https://github.com/$Repo/releases/download/$Version" }

$tmp = Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null
try {
  $exeTmp = Join-Path $tmp $asset
  Say "downloading $asset ($Version)..."
  Invoke-WebRequest -Uri "$base/$asset" -OutFile $exeTmp -UseBasicParsing

  # --- verify sha256 against checksums.txt ---------------------------------
  $sums = Join-Path $tmp 'checksums.txt'
  try { Invoke-WebRequest -Uri "$base/checksums.txt" -OutFile $sums -UseBasicParsing } catch { $sums = $null }
  if ($sums -and (Test-Path $sums)) {
    $want = Get-Content $sums | ForEach-Object {
      $p = $_.Trim() -split '\s+'
      if ($p.Count -ge 2 -and ($p[1].TrimStart('*') -eq $asset)) { $p[0] }
    } | Select-Object -First 1
    if ($want) {
      $got = (Get-FileHash -Algorithm SHA256 -Path $exeTmp).Hash.ToLower()
      if ($got -ne $want.ToLower()) { Die "checksum mismatch for $asset -- aborting for safety." }
      Say 'checksum verified.'
    } else { Say "no checksum entry for $asset -- skipping verification." }
  } else { Say 'checksums.txt unavailable -- skipping verification.' }

  # --- install -------------------------------------------------------------
  New-Item -ItemType Directory -Path $BinStore -Force | Out-Null
  $dest = Join-Path $BinStore 'kommandr.exe'
  Copy-Item -Path $exeTmp -Destination $dest -Force
  Say "installed binary -> $dest"

  # --- add to user PATH (idempotent; SetEnvironmentVariable, not setx) ------
  $userPath = [Environment]::GetEnvironmentVariable('Path', 'User'); if (-not $userPath) { $userPath = '' }
  if (-not (($userPath -split ';') -contains $BinStore)) {
    [Environment]::SetEnvironmentVariable('Path', ($userPath.TrimEnd(';') + ';' + $BinStore), 'User')
    Say "added $BinStore to your user PATH (open a new terminal to pick it up)."
  }
  $env:Path = "$env:Path;$BinStore"
  Say 'installed. run:  kommandr'
}
finally { Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue }
