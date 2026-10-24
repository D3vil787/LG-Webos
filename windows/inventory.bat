@echo off
call "%~dp0config.bat"
set OUT=%OUTDIR%\inventory.txt
echo Read-only: apps, autostart, services, memory. SSH password (rooted via Homebrew): alpine
ssh %SSHOPT% root@%TV% "sh -s" < "%ROOT%\tv\inventory.sh" > "%OUT%" 2>&1
type "%OUT%"
echo.
echo Saved to %OUT%
pause
