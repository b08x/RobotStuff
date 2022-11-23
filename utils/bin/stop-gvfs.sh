#!/usr/bin/env bash

stop_service() {
  application=$1
  systemctl --user stop $application.service
}

services=("gvfs-afc-volume-monitor"
          "gvfs-daemon"
          "gvfs-gphoto2-volume-monitor"
          "gvfs-metadata"
          "gvfs-mtp-volume-monitor"
          "gvfs-udisks2-volume-monitor")

for s in ${services[@]}; do
  stop_service $s || continue
done

return 0
