#!/bin/sh
# Read-only: lists apps, autostart scripts, upstart jobs and memory.
echo ===SYSTEM_APPS===
ls /usr/palm/applications
echo
echo ===STORE_APPS===
ls -la /media/cryptofs/apps/usr/palm/applications 2>/dev/null
echo
echo ===DEVELOPER_APPS===
ls -la /media/developer/apps/usr/palm/applications 2>/dev/null
echo
echo ===HOMEBREW_AUTOSTART===
ls -la /var/lib/webosbrew/init.d 2>/dev/null
echo
echo ===RUNNING_JOBS===
initctl list 2>/dev/null | sort
echo
echo ===WATCHER===
ps | grep -v grep | grep homescreen-wat
echo
echo ===MEMORY===
free -m
