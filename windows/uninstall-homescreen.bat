@echo off
call "%~dp0config.bat"
set OUT=%OUTDIR%\uninstall-homescreen.txt
echo Removes the custom home screen, autostart and Home key interception.
echo SSH password: alpine
ssh %SSHOPT% root@%TV% "sh -s" < "%ROOT%\tv\uninstall.sh" > "%OUT%" 2>&1
type "%OUT%"
echo.
echo Saved to %OUT%
pause
