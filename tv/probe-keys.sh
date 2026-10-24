#!/bin/sh
# Read-only: lists input devices and records 20 s of raw key events.
# Press the remote button you want to identify while it runs.
echo ===INPUT_DEVICES===
cat /proc/bus/input/devices
echo
ls -la /dev/input/
echo

echo ===LISTENING_20_SECONDS_PRESS_HOME_NOW===
rm -rf /tmp/keyprobe; mkdir -p /tmp/keyprobe
for d in /dev/input/event*; do
  n=$(basename $d)
  timeout -t 20 cat $d > /tmp/keyprobe/$n.bin 2>/dev/null &
done
sleep 21

echo ===CAPTURED_BYTES_PER_DEVICE===
ls -la /tmp/keyprobe/
echo

for f in /tmp/keyprobe/*.bin; do
  if [ -s "$f" ]; then
    echo "--- $f"
    od -A d -t x2 "$f" | head -n 40
  fi
done
