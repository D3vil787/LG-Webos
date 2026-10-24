@echo off
call "%~dp0config.bat"
set OUT=%OUTDIR%\install-homescreen.txt
echo Installs the custom home screen. SSH password is asked 3 times (default: alpine).
echo.
echo Step 1 of 3: preparing a temp folder on the TV.
ssh %SSHOPT% root@%TV% "rm -rf /tmp/lg-webos; mkdir -p /tmp/lg-webos"
echo Step 2 of 3: uploading app and scripts.
scp %SSHOPT% -r "%ROOT%\app" "%ROOT%\tv" root@%TV%:/tmp/lg-webos/
echo Step 3 of 3: installing.
ssh %SSHOPT% root@%TV% "sh /tmp/lg-webos/tv/install.sh" > "%OUT%" 2>&1
type "%OUT%"
echo.
echo Saved to %OUT%
pause
