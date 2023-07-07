#!/bin/bash
# adapted from https://github.com/polybar/polybar/issues/763#issuecomment-450940924
# set screenlayout using xrandr
# use flock to prevent any race condition
# close any and all polybar processes
# set the MONITOR env var and load the bar with the corresponding name.
# use `disown` to release new polybar instance as a child process of this script

screenlayout="~/.screenlayout/`hostname`.sh"

if [ -f $screenlayout ]; then
  eval $screenlayout
  source ~/.zshenv
fi

(

  flock 200

  killall -q polybar

  while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

  monitors=($(xrandr --listmonitors | awk -F "  " '{print $2}' | xargs))

  for m in ${monitors[@]}; do
    export MONITOR=$m
    polybar --config="~/.config/polybar/config.ini" \
        --reload $m </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
    disown
  done

) 200>/var/tmp/polybar-launch.lock
