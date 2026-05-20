@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 520网页 一键上传到 GitHub

echo.
echo ========================================
echo   520 网页 - 一键上传到 GitHub
echo   用户名: Mengliio
echo   仓库:   520-love
echo ========================================
echo.

where git >nul 2>&1
if errorlevel 1 (
    echo [错误] 没装 Git，请先安装:
    echo https://git-scm.com/download/win
    echo 安装后重新双击本文件
    pause
    exit /b 1
)

echo [1/5] 准备文件...
if not exist .git git init -b main
git add .
git commit -m "upload 520 page" 2>nul
if errorlevel 1 (
    echo 没有新改动，继续上传...
)

echo.
echo [2/5] 连接 GitHub 仓库...
git remote remove origin 2>nul
git remote add origin https://github.com/Mengliio/520-love.git
git branch -M main

echo.
echo [3/5] 正在上传（可能会弹出浏览器让你登录）...
echo.
git push -u origin main

if errorlevel 1 (
    echo.
    echo ========================================
    echo   上传失败 - 请看下面解决办法
    echo ========================================
    echo.
    echo 办法1: 用 GitHub Desktop（最简单）
    echo   - 打开 GitHub Desktop
    echo   - 文件 - 添加本地仓库
    echo   - 选这个文件夹: %cd%
    echo   - 点 发布仓库，名字填 520-love
    echo.
    echo 办法2: 网页手动上传
    echo   - 浏览器会打开仓库页面
    echo   - 点 add file - Upload files
    echo   - 把本文件夹里所有文件拖进去
    echo.
    start https://github.com/Mengliio/520-love
    pause
    exit /b 1
)

echo.
echo [4/5] 上传成功！
echo.
echo [5/5] 正在打开 Pages 设置页...
start https://github.com/Mengliio/520-love/settings/pages

echo.
echo ========================================
echo   接下来在网页上只做一件事:
echo   Source 选 GitHub Actions
echo   或选 main 分支 + 根目录，点 Save
echo.
echo   等 2 分钟后打开你的网站:
echo   https://Mengliio.github.io/520-love/
echo ========================================
echo.
pause
