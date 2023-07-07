#!/usr/bin/env sh
set -u

# backup home to a remote location
# depends on autofs mount
notify-send -e -u normal "starting backup"

# set backup destination folder
declare -rx BACKUP_DESTINATION="rsync://bender"
declare -rx SUFFIX="_$(uname -n)_"

folders=("Documents"
         "Notebooks"
         "Sessions"
         "Videos")

declare -rx INCLUDES="$HOME/.backup_include"
declare -rx EXCLUDES="$HOME/.backup_exclude"

if [[ ! -f $INCLUDES ]] || [[ ! -f $EXCLUDES ]]; then
  echo "missing include||exclude files"
  sleep 1
  exit
fi

backup () {

  echo "starting backup from $HOME/$folder/ $BACKUP_DESTINATION/$folder/"
  rsync -n -r -o -g -v --progress \
        -u -H -i -s \
        --delete \
        --log-file=$loge \
        --backup-dir=$deleted \
        --suffix="$SUFFIX$timestampe" \
        --include-from=$INCLUDES \
        --exclude-from=$EXCLUDES \
        "$HOME/$folder/" "$BACKUP_DESTINATION/$folder/"


  echo "$HOME/$folder/ ------> $BACKUP_DESTINATION/$folder/"
  read -p "confirm backup? " yn

  case $yn in
      [Yy]* )
        rsync -r -o -g -v --progress \
              -u -H -i -s \
              --delete \
              --log-file=$loge \
              --backup-dir=$deleted \
              --suffix="$SUFFIX$timestampe" \
              --include-from=$INCLUDES \
              --exclude-from=$EXCLUDES \
              "$HOME/$folder/" "$BACKUP_DESTINATION/$folder/"
      ;;
      [Nn]* )
        echo "moving on to the next folder"
        continue
        ;;
      * ) echo "Please answer yes or no.";;
  esac

}

for folder in ${folders[@]}; do
  timestampe=$(date +%Y%m%d%H%M)

  deleted="_deleted"

  loge="/tmp/rsync-log-$timestampe"
  #touch $loge

  backup

done
