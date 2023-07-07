#!/usr/bin/env sh
set -u

# backup home to a remote location
# depends on autofs mount
notify-send -e -u normal "starting backup"

# set backup destination folder
declare -rx BACKUP_DESTINATION="rsync://bender"

folders=("Documents"
         "Images"
         "Library"
         "Notebook"
         "Studio"
         "Videos")



declare -rx INCLUDES="$HOME/.backup_include"
declare -rx EXCLUDES="$HOME/.backup_exclude"

if [[ ! -f $INCLUDES ]] || [[ ! -f $EXCLUDES ]]; then
  echo "missing include||exclude files"
  sleep 1
  exit
fi


# if an argument is passed to this script
# then assign the action variable to that argument
# if nothing is passed then load the menu

if [ "${1-nothing}" = "nothing" ]; then
  action=$(whiptail --title "Backup Menu" --menu "Choose an option" 20 48 10 \
  "backup" "backup only" \
  "sync" "sync only" \
  "sync and backup" "sync then backup" \
  "backup and sync" "backup then sync" \
  "backup and reboot" "backup then reboot" \
  "backup and shutdown" "backup then shutdown" 3>&1 1>&2 2>&3)
else
  action="$1"
fi

# if there is no argument passed or the menu is cancelled
# then polietly exit
if [[ -z "$action" ]]; then
  echo "nevermind then"
  sleep 0.25
  exit
fi

sync () {
  echo "starting sync from $BACKUP_DESTINATION/$folder/ to $HOME/$folder/"
  rsync -n -r -t -o -g -v --progress \
        -u -H -i -s \
        --log-file=$loge \
        --backup-dir=$deleted \
        --suffix="_$HOSTNAME'_'$timestampe" \
        --include-from=$INCLUDES \
        --exclude-from=$EXCLUDES \
        "$BACKUP_DESTINATION/$folder/" "$HOME/$folder/"

  echo "$HOME/$folder/ <------ $BACKUP_DESTINATION/$folder/"
  read -p "confirm sync? " yn
  case $yn in
      [Yy]* )
        rsync -r -t -o -g -v --progress \
              -u -H -i -s \
              --log-file=$loge \
              --backup-dir=$deleted \
              --suffix="_$HOSTNAME'_'$timestampe" \
              --include-from=$INCLUDES \
              --exclude-from=$EXCLUDES \
              $BACKUP_DESTINATION/$folder/ $HOME/$folder/

        echo "removing empty directories..."
        fd . -t d -t e $HOME/$folder/ -x rm -rf {}
      ;;
      [Nn]* )
        continue
        ;;
      * ) echo "Please answer yes or no.";;
  esac

  cat /dev/null > $loge
}

backup () {

  echo "starting backup from $HOME/$folder/ $BACKUP_DESTINATION/$folder/"
  rsync -n -r -o -g -v --progress \
        -u -H -i -s \
        --log-file=$loge \
        --backup-dir=$deleted \
        --suffix="_$HOSTNAME'_'$timestampe" \
        --include-from=$INCLUDES \
        --exclude-from=$EXCLUDES \
        "$HOME/$folder/" "$BACKUP_DESTINATION/$folder/"


  echo "$HOME/$folder/ ------> $BACKUP_DESTINATION/$folder/"
  read -p "confirm backup? " yn


  case $yn in
      [Yy]* )
        rsync -r -o -g -v --progress \
              -u -H -i -s \
              --log-file=$loge \
              --backup-dir=$deleted \
              --suffix="_$HOSTNAME'_'$timestampe" \
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

main () {

  for folder in ${folders[@]}; do

      timestampe=$(date +%Y%m%d%H%M)

      deleted="_deleted"
      #mkdir -pv $deleted

      loge="/tmp/rsync-log-$timestampe"
      #touch $loge

      case "$1" in
        "backup" )
          backup
          ;;
        "sync" )
          sync
          ;;
        "sync then backup" )
          sync
          backup
          ;;
        "backup then sync" )
          backup
          sync
          ;;

      esac

  done
}

case $action in
  "backup" )
    main backup
    echo "backup complete"
    sleep 1
    ;;
  "sync" )
    main sync
    echo "sync complete"
    sleep 1
    ;;
  "sync and backup" )
    main "sync then backup"
    echo "sync and backup complete"
    sleep 1
    ;;
  "backup and sync" )
    main "backup then sync"
    echo "sync and backup complete"
    sleep 1
    ;;
  "backup and reboot" )
    backup
    echo "backup complete"
    echo "rebooting"
    sleep 1
    sudo shutdown -r now
    ;;
  "backup shutdown" )
    backup
    echo "backup complete"
    echo "shutdown"
    sleep 1
    sudo shutdown -h now
    ;;
esac
