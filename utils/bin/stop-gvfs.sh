#!/usr/bin/env bash

systemctl --user stop gvfs-afc-volume-monitor.service && \
systemctl --user stop gvfs-daemon.service && \
systemctl --user stop gvfs-gphoto2-volume-monitor.service && \
systemctl --user stop gvfs-metadata.service && \
systemctl --user stop gvfs-mtp-volume-monitor.service && \
systemctl --user stop gvfs-udisks2-volume-monitor.service
