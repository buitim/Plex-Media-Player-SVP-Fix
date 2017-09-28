@echo off
:: BatchGotAdmin (Source: https://goo.gl/hZ2Zsn by Lokesh Kumar and Edudjr)
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------

@echo "Fixing Plex Media Player SVP .dll"
set NamePath="C:\"
pushd %Pathname%
robocopy "C:\Program Files (x86)\SVP 4\mpv64" "C:\Program Files\Plex\Plex Media Player" mpv-1.dll
@echo "Done."
pause
