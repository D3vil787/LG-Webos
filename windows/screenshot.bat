@echo off
call "%~dp0config.bat"
set OUT=%OUTDIR%\screenshot.txt
echo Takes a screenshot of the home screen. SSH password is asked 2 times (default: alpine).
ssh %SSHOPT% root@%TV% "sh -s" < "%ROOT%\tv\screenshot.sh" > "%OUT%" 2>&1
type "%OUT%"
scp %SSHOPT% root@%TV%:/tmp/homescreen.jpg "%OUTDIR%\homescreen.jpg"
echo.
echo Screenshot: %OUTDIR%\homescreen.jpg
pause
