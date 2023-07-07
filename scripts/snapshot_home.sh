#!/bin/bash

SOURCEDIR="/home"
TARGETDIR="/mnt/backup"

# Check if the backup directory is mounted
if ! mountpoint -q $TARGETDIR
then
  echo "Mounting $TARGETDIR..."

  sudo mount -o noatime,compress=zlib:3,ssd,discard,space_cache=v2,autodefrag,subvol=/subvol_backup \
  /dev/sdb1 $TARGETDIR
fi

# Create a timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create a read-only snapshot
sudo btrfs subvolume snapshot -r $SOURCEDIR $SOURCEDIR/snapshot_$TIMESTAMP

# Send the snapshot to the target directory
sudo btrfs send $SOURCEDIR/snapshot_$TIMESTAMP | sudo btrfs receive $TARGETDIR

# Verify if the snapshot was sent successfully
if [ $? -eq 0 ]; then
  echo "Snapshot sent successfully."
  # Remove the snapshot from the source directory
  sudo btrfs subvolume delete $SOURCEDIR/snapshot_$TIMESTAMP
  echo "Snapshot removed from the source directory."
else
  echo "Backup failed. The snapshot was not removed."
fi


