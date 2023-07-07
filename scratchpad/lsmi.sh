#!/usr/bin/env bash

# utilize usb keyboard as a midi controller

lsmi="/usr/local/bin/lsmi-keyhack"
keydb="$HOME/Library/configs/lsmi/keydb_01"

keyboard_id=$(xinput list | grep 'Dell KB216 Wired Keyboard' |
                            awk -F ' ' '{ print $6 }' |
                            grep id |
                            awk -F '=' '{ print $2 }')

if [[ -z "$keyboard_id" ]];
then
  systemd-cat -t "lsmi" echo "this keyboard is not connected"
else
  if ! pgrep -x "lsmi-keyhack" > /dev/null
  then
    keyboard_event=$(xinput --list-props $keyboard_id | grep event |
                                                        awk -F " " '{ print $4 }')

    i3-msg "exec --no-startup-id $lsmi -k $keydb -d $keyboard_event &!"
  fi
fi
