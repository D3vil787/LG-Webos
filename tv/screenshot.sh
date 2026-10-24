#!/bin/sh
# Opens the home screen and saves a screenshot to /tmp/homescreen.jpg on the TV.
rm -f /tmp/homescreen.jpg
luna-send -n 1 luna://com.webos.applicationManager/launch '{"id":"com.anton.homescreen"}' < /dev/null
sleep 4
for m in DISPLAY GRAPHIC; do
  luna-send -n 1 luna://com.webos.service.tv.capture/executeOneShot "{\"path\":\"/tmp/homescreen.jpg\",\"method\":\"$m\",\"width\":1920,\"height\":1080,\"format\":\"JPEG\"}" < /dev/null
  [ -s /tmp/homescreen.jpg ] && break
done
ls -la /tmp/homescreen.jpg
