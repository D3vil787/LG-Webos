@echo off
call "%~dp0config.bat"
set OUT=%OUTDIR%\probe-keys.txt
echo Read-only: records 20 seconds of remote control events.
echo SSH password: alpine. Right after typing it, press the button to identify a few times.
ssh %SSHOPT% root@%TV% "sh -s" < "%ROOT%\tv\probe-keys.sh" > "%OUT%" 2>&1
type "%OUT%"
echo.
echo Saved to %OUT%
pause
