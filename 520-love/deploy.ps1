# 520-love 一键发布到 GitHub Pages
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host "=== 520-love 部署到 GitHub Pages ===" -ForegroundColor Cyan

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "请先安装 Git: https://git-scm.com/" }
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw "请先安装 GitHub CLI 并运行: gh auth login" }

gh auth status
$username = gh api user -q .login
$pagesUrl = "https://$username.github.io/520-love/"
Write-Host "GitHub 用户: $username"
Write-Host "网站地址: $pagesUrl"

if (-not (Test-Path ".git")) { git init -b main }

git add .
if (git status --porcelain) {
  git commit -m "feat: 520 rose love page with SEO and GitHub Pages"
}

try { git remote get-url origin | Out-Null; git push -u origin main }
catch { gh repo create 520-love --public --source=. --remote=origin --push }

foreach ($f in "robots.txt", "sitemap.xml") {
  if (Test-Path $f) {
    (Get-Content $f -Raw) -replace 'https://YOUR_USERNAME\.github\.io/520-love/', $pagesUrl | Set-Content $f -NoNewline
  }
}
git add robots.txt sitemap.xml 2>$null
if (git status --porcelain robots.txt sitemap.xml) {
  git commit -m "chore: update sitemap"
  git push
}

Write-Host ""
Write-Host "仓库: https://github.com/$username/520-love" -ForegroundColor Green
Write-Host "网站: $pagesUrl" -ForegroundColor Green
Write-Host "请到仓库 Settings -> Pages -> Source 选 GitHub Actions" -ForegroundColor Yellow

Start-Process "https://github.com/$username/520-love/settings/pages"
