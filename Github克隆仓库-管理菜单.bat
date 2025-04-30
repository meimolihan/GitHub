@echo off
color 0A
setlocal enabledelayedexpansion

:: ------------------------------
:: �û���������һ��һ���ֿ��ַ��
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
echo ��ѡ��Ҫ��¡�Ĳֿ⣺
echo =========================
for /l %%i in (1,1,%repo_count%) do (
    set "repo_url=!repo[%%i]!"
    for %%a in ("!repo_url!") do set "repo_name=%%~na"
    echo %%i. ��¡��GitHub���ֿ⣺!repo_name!
)
echo =========================
echo x. ��¡���вֿ�
echo a. �ֶ�����ֿ��ַ
echo 0. �˳�
echo =========================

set /p "choice=������ѡ��: "
set "lc_choice=!choice!"

if "!lc_choice!"=="0" exit

if /i "!lc_choice!"=="x" (
    echo ����׼����¡���вֿ�...
    echo =========================
    set "all_success=1"
    for /l %%i in (1,1,%repo_count%) do (
        set "repo_url=!repo[%%i]!"
        for %%a in ("!repo_url!") do set "repo_name=%%~na"
        echo ���ڿ�¡�ֿ⣺!repo_name!
        git clone "!repo_url!"
        if !errorlevel! neq 0 (
            echo [����] ��¡�ֿ⣺!repo_name! ʧ��
            set "all_success=0"
        ) else (
            echo [�ɹ�] ��¡�ֿ⣺!repo_name! ���
        )
        echo.
    )
    if "!all_success!"=="1" (
        echo ���вֿ��¡�ɹ���
    ) else (
        echo ���ֲֿ��¡ʧ�ܣ����������ֿ��ַ��
    )
    pause
    goto :menu
)

if /i "!lc_choice!"=="a" (
    set /p "manual_repo=������ֿ��ַ: "
    if not defined manual_repo (
        echo �ֿ��ַ����Ϊ�գ����������롣
        pause
        goto :menu
    )
    echo ���ڿ�¡�ֿ⣺!manual_repo!
    git clone "!manual_repo!"
    if !errorlevel! equ 0 (
        echo [�ɹ�] ��¡�ֿ⣺!manual_repo! ���
    ) else (
        echo [����] ��¡�ֿ⣺!manual_repo! ʧ��
    )
    pause
    goto :menu
)

:: ��������ѡ��
set "valid=0"
for /l %%i in (1,1,%repo_count%) do (
    if "!lc_choice!"=="%%i" (
        set "valid=1"
        set "repo_url=!repo[%%i]!"
        for %%a in ("!repo_url!") do set "repo_name=%%~na"
        echo ���ڿ�¡�ֿ⣺!repo_name!
        git clone "!repo_url!"
        if !errorlevel! equ 0 (
            echo [�ɹ�] ��¡�ֿ⣺!repo_name! ���
        ) else (
            echo [����] ��¡�ֿ⣺!repo_name! ʧ��
        )
        pause
        goto :menu
    )
)

if "!valid!"=="0" (
    echo ��Ч��ѡ����������롣
    pause
    goto :menu
)

endlocal