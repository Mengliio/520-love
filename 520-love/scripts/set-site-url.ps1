# 用法: .\scripts\set-site-url.ps1 -BaseUrl "https://你的用户名.github.io/520-love"
param(
  [Parameter(Mandatory = $true)]
  [string]$BaseUrl
)

$BaseUrl = $BaseUrl.TrimEnd('/') + '/'
$root = Split-Path $PSScriptRoot -Parent

$files = @(
  (Join-Path $root "robots.txt"),
  (Join-Path $root "sitemap.xml")
)

foreach ($f in $files) {
  if (-not (Test-Path $f)) { continue }
  (Get-Content $f -Raw -Encoding UTF8) `
    -replace 'https://YOUR_USERNAME\.github\.io/520-love/', $BaseUrl `
    -replace 'https://YOUR_SITE_URL/', $BaseUrl |
    Set-Content $f -Encoding UTF8 -NoNewline
  Write-Host "Updated: $f"
}

Write-Host "Done. Base URL = $BaseUrl"
