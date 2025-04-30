@echo off
color 0A
setlocal enabledelayedexpansion

:: ------------------------------
:: 用户配置区域（一行一个仓库地址）
call :add_repo "git@github.com:meimolihan/compose.git"
call :add_repo "git@github.com:meimolihan/hexo-main.git"
call :add_repo "git@github.com:meimolihan/sh.git"
call :add_repo "git@github.com:meimolihan/file.git"
call :add_repo "git@github.com:meimolihan/cdn.git"
call :add_repo "git@github.com:meimolihan/music.git"
call :add_repo "git@github.com:meimolihan/hugo-main.git"
call :add_repo "git@github.com:meimolihan/random-pic-api.git"
call :add_repo "git@github.com:meimolihan/video.git"
:: ------------------------------
goto :menu

:add_repo
set /a repo_count+=1
set "repo[!repo_count!]=%~1"
goto :eof

:menu
cls
echo 请选择要克隆的仓库：
echo =========================
for /l %%i in (1,1,%repo_count%) do (
    set "repo_url=!repo[%%i]!"
    for %%a in ("!repo_url!") do set "repo_name=%%~na"
    echo %%i. 克隆【GitHub】仓库：!repo_name!
)
echo =========================
echo x. 克隆所有仓库
echo a. 手动输入仓库地址
echo 0. 退出
echo =========================

set /p "choice=请输入选项: "
set "lc_choice=!choice!"

if "!lc_choice!"=="0" exit

if /i "!lc_choice!"=="x" (
    echo 正在准备克隆所有仓库...
    echo =========================
    set "all_success=1"
    for /l %%i in (1,1,%repo_count%) do (
        set "repo_url=!repo[%%i]!"
        for %%a in ("!repo_url!") do set "repo_name=%%~na"
        echo 正在克隆仓库：!repo_name!
        git clone "!repo_url!"
        if !errorlevel! neq 0 (
            echo [错误] 克隆仓库：!repo_name! 失败
            set "all_success=0"
        ) else (
            echo [成功] 克隆仓库：!repo_name! 完成
        )
        echo.
    )
    if "!all_success!"=="1" (
        echo 所有仓库克隆成功！
    ) else (
        echo 部分仓库克隆失败，请检查网络或仓库地址。
    )
    pause
    goto :menu
)

if /i "!lc_choice!"=="a" (
    set /p "manual_repo=请输入仓库地址: "
    if not defined manual_repo (
        echo 仓库地址不能为空，请重新输入。
        pause
        goto :menu
    )
    echo 正在克隆仓库：!manual_repo!
    git clone "!manual_repo!"
    if !errorlevel! equ 0 (
        echo [成功] 克隆仓库：!manual_repo! 完成
    ) else (
        echo [错误] 克隆仓库：!manual_repo! 失败
    )
    pause
    goto :menu
)

:: 处理数字选项
set "valid=0"
for /l %%i in (1,1,%repo_count%) do (
    if "!lc_choice!"=="%%i" (
        set "valid=1"
        set "repo_url=!repo[%%i]!"
        for %%a in ("!repo_url!") do set "repo_name=%%~na"
        echo 正在克隆仓库：!repo_name!
        git clone "!repo_url!"
        if !errorlevel! equ 0 (
            echo [成功] 克隆仓库：!repo_name! 完成
        ) else (
            echo [错误] 克隆仓库：!repo_name! 失败
        )
        pause
        goto :menu
    )
)

if "!valid!"=="0" (
    echo 无效的选项，请重新输入。
    pause
    goto :menu
)

endlocal