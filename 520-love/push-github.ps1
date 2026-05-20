# Mengliio - push to GitHub (no gh required)
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$remote = "https://github.com/Mengliio/520-love.git"

Write-Host "=== Push to Mengliio/520-love ===" -ForegroundColor Cyan
Write-Host "Before run: create empty repo at https://github.com/new named 520-love" -ForegroundColor Yellow

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw "Install Git first: https://git-scm.com/"
}

if (-not (Test-Path ".git")) { git init -b main }

git add .
if (git status --porcelain) {
  git commit -m "feat: 520 rose love page"
}

try {
  git remote get-url origin | Out-Null
  git remote set-url origin $remote
} catch {
  git remote add origin $remote
}

git push -u origin main

Write-Host ""
Write-Host "Site: https://Mengliio.github.io/520-love/" -ForegroundColor Green
Write-Host "Enable Pages: Settings -> Pages -> Source: GitHub Actions" -ForegroundColor Yellow
Start-Process "https://github.com/Mengliio/520-love/settings/pages"
