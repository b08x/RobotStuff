#!/usr/bin/env bash

export timestampe=$(date +'%Y-%m-%d_%H-%M-%S')
echo $timestampe

mkdir -pv /mnt/bender/storage/backupdelta/$timestampe

rsync -avPrtv --log-file=rsync.log --stats --delete --delete-before --progress --ignore-existing -u -l -b -i -s \
	--suffix=$timestampe --backup-dir=/mnt/bender/storage/backupdelta/$timestampe \
	--exclude-from=/home/b08x/backup_exclude.txt /home/b08x/Public /mnt/bender/backup/

chown -R b08x:b08x /mnt/bender/storage/backupdelta/$timestampe
