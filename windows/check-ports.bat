@echo off
call "%~dp0config.bat"
echo Checking LG TV at %TV% ...
ping -n 2 %TV%
echo.
powershell -NoProfile -Command "foreach($p in 22,9922,3000,3001){ $r=Test-NetConnection -ComputerName '%TV%' -Port $p -WarningAction SilentlyContinue; '{0} port {1}: {2}' -f '%TV%',$p,$(if($r.TcpTestSucceeded){'OPEN'}else{'closed'}) }"
echo.
echo Port 22 must be OPEN for the other scripts. If it is closed after a reboot,
echo open Homebrew Channel on the TV once.
pause
