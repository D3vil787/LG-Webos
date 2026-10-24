@echo off
call "%~dp0config.bat"
echo Rebooting the TV. SSH password: alpine
echo After the reboot open Homebrew Channel once if SSH does not come up.
ssh %SSHOPT% root@%TV% "reboot"
pause
