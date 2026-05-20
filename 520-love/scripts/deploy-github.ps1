# 一键发布到 GitHub Pages（需已安装 git、gh 并已 gh auth login）
param(
  [string]$RepoName = "520-love",
  [switch]$Public = $true
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Error "请先安装 Git: https://git-scm.com/"
}
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Write-Error "请先安装 GitHub CLI 并登录: https://cli.github.com/  运行 gh auth login"
}

if (-not (Test-Path ".git")) {
  git init -b main
  git add .
  git commit -m "feat: 520 rose love page with SEO and GitHub Pages"
}

$visibility = if ($Public) { "--public" } else { "--private" }
$remote = git remote get-url origin 2>$null
if (-not $remote) {
  gh repo create $RepoName $visibility --source=. --remote=origin --push
} else {
  git push -u origin main
}

Write-Host ""
Write-Host "下一步（在 GitHub 网页操作）："
Write-Host "1. 打开仓库 Settings -> Pages"
Write-Host "2. Source 选 GitHub Actions"
Write-Host "3. 等 Actions 跑完后访问: https://<你的用户名>.github.io/$RepoName/"
Write-Host "4. 运行: .\scripts\set-site-url.ps1 -BaseUrl `"https://<你的用户名>.github.io/$RepoName`""
