#!/bin/sh
# Removes the custom home screen, its watcher and its bus permissions.
# The stock LG launcher is never modified, so nothing else needs restoring.

APP=com.anton.homescreen
DEVAPPS=/media/developer/apps/usr/palm
LS2DEV=/var/luna-service2-dev
WB=/var/lib/webosbrew

rm -f "$WB/init.d/98-homescreen"
pkill -f homescreen-watch.sh 2>/dev/null
pkill -f getPowerState 2>/dev/null
rm -f "$WB/homescreen-watch.sh"

luna-send -n 1 luna://com.webos.applicationManager/closeByAppId "{\"id\":\"$APP\"}" < /dev/null > /dev/null 2>&1
rm -rf "$DEVAPPS/applications/$APP" "$DEVAPPS/packages/$APP"
rm -f "$LS2DEV/roles.d/$APP.app.json" "$LS2DEV/client-permissions.d/$APP.app.json"
ls-control scan-services < /dev/null

echo "Removed. Reboot the TV to drop the 'Home' tile from the stock launcher."
ls -la "$WB/init.d"
