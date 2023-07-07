#!/usr/bin/env bash

services=("gvfs-afc-volume-monitor"
          "gvfs-daemon"
          "gvfs-gphoto2-volume-monitor"
          "gvfs-metadata"
          "gvfs-mtp-volume-monitor"
          "gvfs-udisks2-volume-monitor")

for s in ${services[@]}; do
  systemctl --user stop $s.service || continue
done

echo "gvfs services stopped"
