@echo off
rem IP address of the TV in your local network. Change it once here.
set TV=192.168.1.99
set SSHOPT=-o StrictHostKeyChecking=no
set ROOT=%~dp0..
set OUTDIR=%~dp0output
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
