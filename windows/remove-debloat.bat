@echo off
call "%~dp0config.bat"
echo Removes the debloat boot script. Services come back after the next reboot.
echo SSH password: alpine
ssh %SSHOPT% root@%TV% "rm -f /var/lib/webosbrew/init.d/99-debloat.sh; ls -la /var/lib/webosbrew/init.d"
pause
