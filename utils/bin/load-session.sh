#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#
# keyboard_id=$(xinput list | grep 'Dell KB216 Wired Keyboard' | awk -F ' ' '{ print $6 }' | grep "id" | awk -F '=' '{ print $2 }')
#
# if [[ -z "$keyboard_id" ]];
# then
#   systemd-cat -t "lsmi" echo "this keyboard is not connected"
# else
#   zenity --question \
#   	--title="Prepare load" \
#   	--text="use lsmi keyboard?" \
#   	--ok-label="Yes" \
#     --cancel-label="No"
#
#   if [ $? = 0 ]; then
#     if ! pgrep -x "lsmi-keyhack" > /dev/null
#     then
#       keyboard_event=$(xinput --list-props $keyboard_id | grep "event" | awk -F " " '{ print $4 }')
#
#       i3-msg "exec --no-startup-id /usr/local/bin/lsmi-keyhack \
#         -k $HOME/Library/configs/lsmi/keydb_01 -d $keyboard_event &!"
#     fi
#   fi
# fi
#
# zenity --question \
# 	--title="Prepare load" \
# 	--text="use sonic-pi?" \
# 	--ok-label="Yes" \
#   --cancel-label="No"
#
# if [ $? = 0 ]; then
#   if ! pgrep -x "sonic-pi" > /dev/null
#   then
#     i3-msg "exec --no-startup-id /opt/sonic-pi/bin/sonic-pi"
#     sleep 6
#     i3-msg '[class="Sonic\ Pi"]', move to workspace 5
#   fi
# fi

zenity --question \
	--title="Prepare load" \
	--text="use reaper?" \
	--ok-label="Yes" \
  --cancel-label="No"

if [ $? = 0 ]; then
  cd $HOME/Studio/projects

  project=$(zenity --width 800 --height 600 --list --title="reaper projects" \
    --text="select reaper project to open" --column="project" $(fd -a -e .rpp))

  if ! pgrep -x "reaper" > /dev/null
  then
    if [ -z $project ];then
      i3-msg "exec --no-startup-id reaper -nosplash";sleep 2
    else
      i3-msg "exec --no-startup-id reaper -nosplash $project";sleep 2
    fi

    i3-msg "[class="^REAPER$"], move to workspace 2"

    sleep 0.5

  fi
fi

if [ $? = 0 ]; then
  if pgrep -x "patchage" > /dev/null
  then
    xdotool search --onlyvisible --name "Patchage" key ctrl+r
    sleep 0.25
    xdotool search --onlyvisible --name "Patchage" key ctrl+g
    sleep 0.25
    xdotool search --onlyvisible --name "Patchage" key ctrl+f
  fi
fi
