#!/bin/sh
# Installs the custom home screen on a rooted LG webOS TV (Homebrew Channel).
# Run on the TV as root:  sh /tmp/lg-webos/tv/install.sh
# Expects the repo's app/ and tv/ folders uploaded to /tmp/lg-webos/.

set -u
APP=com.anton.homescreen
BASE=/tmp/lg-webos
DEVAPPS=/media/developer/apps/usr/palm
LS2DEV=/var/luna-service2-dev
WB=/var/lib/webosbrew

echo "=== 1. App files -> $DEVAPPS/applications/$APP"
# Not in /media/cryptofs: apps there are treated as LG Store apps and fail
# with "Failed to identify a proper DRM file" (-302).
rm -rf "$DEVAPPS/applications/$APP"
mkdir -p "$DEVAPPS/applications"
cp -r "$BASE/app/$APP" "$DEVAPPS/applications/"
chmod -R 755 "$DEVAPPS/applications/$APP"

mkdir -p "$DEVAPPS/packages/$APP"
cat > "$DEVAPPS/packages/$APP/packageinfo.json" <<EOF
{"app":"$APP","id":"$APP","loc_name":"Home","package_format_version":2,"vendor":"anton","version":"1.0.0"}
EOF

echo "=== 2. Luna bus permissions (without them launch requests are silently dropped)"
cat > "$LS2DEV/roles.d/$APP.app.json" <<EOF
{"appId":"$APP","type":"regular","allowedNames":["$APP-*"],"permissions":[{"service":"$APP-*","outbound":["*"]}]}
EOF
cat > "$LS2DEV/client-permissions.d/$APP.app.json" <<EOF
{"$APP-*":["all"]}
EOF
ls-control scan-services < /dev/null

echo "=== 3. App icons (taken from the installed apps themselves, never shipped in the repo)"
sh "$BASE/tv/copy-icons.sh"

echo "=== 4. Watcher: autostart on boot / wake-up + Home key interception"
cp "$BASE/tv/homescreen-watch.sh" "$WB/homescreen-watch.sh"
chmod +x "$WB/homescreen-watch.sh"
mkdir -p "$WB/init.d"
cat > "$WB/init.d/98-homescreen" <<'EOF'
#!/bin/sh
/var/lib/webosbrew/homescreen-watch.sh > /dev/null 2>&1 &
EOF
chmod +x "$WB/init.d/98-homescreen"

pkill -f homescreen-watch.sh 2>/dev/null
pkill -f getPowerState 2>/dev/null
sleep 1
setsid "$WB/homescreen-watch.sh" < /dev/null > /dev/null 2>&1 &
sleep 2
ps | grep -v grep | grep homescreen-wat

echo "=== 5. Opening the screen"
luna-send -n 1 luna://com.webos.applicationManager/launch "{\"id\":\"$APP\"}" < /dev/null

echo
echo "Installed. If the 'Home' tile is missing from the stock launcher, reboot the TV once."
