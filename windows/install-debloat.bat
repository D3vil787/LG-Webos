@echo off
call "%~dp0config.bat"
set OUT=%OUTDIR%\install-debloat.txt
echo Installs tv\debloat.sh as a Homebrew boot script and runs it now.
echo SSH password is asked 2 times (default: alpine).
scp %SSHOPT% "%ROOT%\tv\debloat.sh" root@%TV%:/var/lib/webosbrew/init.d/99-debloat.sh
ssh %SSHOPT% root@%TV% "chmod +x /var/lib/webosbrew/init.d/99-debloat.sh; sh /var/lib/webosbrew/init.d/99-debloat.sh; echo; initctl list | grep -E 'unified_service|dmost|statistics|qosm|rdxd|dmr|miracast|btmngr|pushmanager|preload'; echo; free -m" > "%OUT%" 2>&1
type "%OUT%"
echo.
echo Saved to %OUT%
pause
