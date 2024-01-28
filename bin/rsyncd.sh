#!/usr/bin/env bash

export timestampe=$(date +'%Y-%m-%d_%H-%M-%S')
echo $timestampe

backupdelta="/mnt/usb/backup/backupdelta"

if [[ -d $backupdelta ]]; then

	mkdir -pv $backupdelta/$timestampe

	rsync -rtPp --log-file=rsync.log --stats --delete --delete-before --delete-excluded --progress --ignore-existing -u -l -b -i -s \
		--suffix="_backup" --backup-dir=$backupdelta/$timestampe \
		--exclude-from=/home/b08x/RobotStuff/backup_exclude.txt /home/b08x/Public/ /mnt/bender/backup/Public/

	chown -R b08x:b08x $backupdelta/$timestampe
else
	echo "no usb drive mounted. exiting"
fi
