@echo off
color 0A
setlocal enabledelayedexpansion

cls
echo ============================================
echo                 Git 克隆仓库
echo ============================================
set /p repoUrl="请输入Git仓库的URL或git clone命令: "

if "%repoUrl%"=="" (
    echo 未输入有效的URL，请重新运行脚本并输入正确的URL。
    pause
    goto clone_menu
)

set "cleanUrl=%repoUrl%"
set "cleanUrl=%cleanUrl:git clone =%"
set "cleanUrl=%cleanUrl:git clone=%"

echo 正在克隆仓库，请稍候...
git clone %cleanUrl%

if %errorlevel% neq 0 (
    echo ============================================
    echo 克隆失败，请检查URL是否正确或网络连接。
    echo ============================================
) else (
    echo ============================================
    echo 克隆成功！
    echo ============================================
)

echo.
echo 感谢使用，再见！
timeout /t 3 >nul
exit