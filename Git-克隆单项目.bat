@echo off
color 0A
setlocal enabledelayedexpansion

cls
echo ============================================
echo                 Git ��¡�ֿ�
echo ============================================
set /p repoUrl="������Git�ֿ��URL��git clone����: "

if "%repoUrl%"=="" (
    echo δ������Ч��URL�����������нű���������ȷ��URL��
    pause
    goto clone_menu
)

set "cleanUrl=%repoUrl%"
set "cleanUrl=%cleanUrl:git clone =%"
set "cleanUrl=%cleanUrl:git clone=%"

echo ���ڿ�¡�ֿ⣬���Ժ�...
git clone %cleanUrl%

if %errorlevel% neq 0 (
    echo ============================================
    echo ��¡ʧ�ܣ�����URL�Ƿ���ȷ���������ӡ�
    echo ============================================
) else (
    echo ============================================
    echo ��¡�ɹ���
    echo ============================================
)

echo.
echo ��лʹ�ã��ټ���
timeout /t 3 >nul
exit