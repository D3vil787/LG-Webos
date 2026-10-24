#!/bin/sh
# Stops telemetry / ACR / casting / preload services on every boot.
# Installed as /var/lib/webosbrew/init.d/99-debloat.sh (the root fs is read-only,
# so /etc/init/*.conf cannot be edited; Homebrew Channel runs init.d scripts at boot).
#
# unified_service_server*    - ACR ("Live Plus") content recognition
# required_dmost             - LG data / ad statistics
# webos-statistics-manager   - usage statistics
# qosm                       - network quality reporting
# rdxd                       - remote diagnostics
# dmr                        - DLNA media renderer
# miracast                   - screen mirroring
# btmngr                     - Bluetooth manager (remove this line if you use BT audio)
# pushmanager                - push notifications
# webos-preload-manager      - preloading apps in the background

initctl stop unified_service_server
initctl stop unified_service_server_factory
initctl stop required_dmost
initctl stop webos-statistics-manager
initctl stop qosm
initctl stop rdxd
initctl stop dmr
initctl stop miracast
initctl stop btmngr
initctl stop pushmanager
initctl stop webos-preload-manager
