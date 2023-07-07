#!/bin/bash

# closh.sh <programme name>

close() {
  local name="$1"

  if pgrep -x "${name}" > /dev/null
  then
    i3-msg "exec --no-startup-id pkill -9 $1";sleep 1
  else
    systemd-cat -t "close_session" echo "$name is not running"
  fi
}
