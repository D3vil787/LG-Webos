#!/bin/sh
# 1) Opens com.anton.homescreen after boot and every time the TV wakes up from standby.
# 2) Home key on the remote: from any other app -> our screen; from our screen -> stock launcher.

APP=com.anton.homescreen

launch() {
  luna-send -n 1 luna://com.webos.applicationManager/launch "{\"id\":\"$APP\"}" < /dev/null > /dev/null 2>&1
}

find_rcu() {
  d=$(awk '/Name="LGE RCU"/{f=1} f && /Handlers=/{for(i=1;i<=NF;i++) if($i ~ /^event/) print $i; exit}' /proc/bus/input/devices 2>/dev/null)
  [ -z "$d" ] && d=event1
  echo /dev/input/$d
}

key_loop() {
  while true; do
    dev=$(find_rcu)
    if ! exec 3< "$dev"; then sleep 10; continue; fi
    while true; do
      ev=$(dd bs=16 count=1 <&3 2>/dev/null | od -A n -t x2)
      [ -z "$ev" ] && break
      case "$ev" in
        *" 0001 0305 0001 "*)
          fg=$(luna-send -n 1 luna://com.webos.applicationManager/getForegroundAppInfo '{}' < /dev/null 2>/dev/null)
          case "$fg" in
            *"$APP"*) ;;
            *) ( usleep 400000 2>/dev/null || sleep 1; launch ) & ;;
          esac
          ;;
      esac
    done
    exec 3<&-
    sleep 2
  done
}

key_loop &

# After a cold boot: give the system time to settle, then open the screen.
sleep 25
launch

# Open the screen on every transition into the "Active" power state.
prev="Active"
while true; do
  luna-send -i luna://com.webos.service.tvpower/power/getPowerState '{"subscribe":true}' < /dev/null 2>/dev/null | while read line; do
    case "$line" in
      *'"state"'*'"Active"'*)
        if [ "$prev" != "Active" ]; then
          sleep 4
          launch
        fi
        prev="Active"
        ;;
      *'"state"'*)
        prev="other"
        ;;
    esac
  done
  sleep 10
done
