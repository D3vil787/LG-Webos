#!/bin/sh
# Copies each tile app's own icon (and its iconColor) into the home screen folder.
# The icons belong to their apps' owners, so they are copied on the TV, not stored in git.

STORE=/media/cryptofs/apps/usr/palm/applications
DST=/media/developer/apps/usr/palm/applications/com.anton.homescreen

pick() {
  dir=$1
  for key in extraLargeIcon largeIcon mediumLargeIcon icon; do
    v=$(sed -n "s/.*\"$key\" *: *\"\([^\"]*\)\".*/\1/p" "$dir/appinfo.json" 2>/dev/null | head -n 1)
    if [ -n "$v" ] && [ -f "$dir/$v" ]; then echo "$dir/$v"; return; fi
  done
}

color() {
  sed -n 's/.*"iconColor" *: *"\([^"]*\)".*/\1/p' "$1/appinfo.json" 2>/dev/null | head -n 1
}

copy_one() {
  key=$1; app=$2
  f=$(pick "$STORE/$app")
  echo "$key ($app): ${f:-not found, the tile will show a letter}"
  [ -n "$f" ] && cp "$f" "$DST/icon_$key.png"
}

# key  app id  -- keep in sync with the tiles in app/com.anton.homescreen/index.html
copy_one kp    com.685631.3411
copy_one lampa lampa.tv
copy_one yt    youtube.leanback.v4

c1=$(color $STORE/com.685631.3411); c2=$(color $STORE/lampa.tv); c3=$(color $STORE/youtube.leanback.v4)
echo "var ICON_COLORS={kp:'${c1:-#1d1f20}',lampa:'${c2:-#1d1f20}',yt:'${c3:-#1d1f20}'};" > "$DST/icons.js"
cat "$DST/icons.js"
