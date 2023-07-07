#!/usr/bin/env bash
set -vx


i3-msg "exec --no-startup-id reaper"

sleep 1

longvar="$(i3-msg -t get_tree | jq 2>/dev/null | grep -w -P '\s+\"name\":\s+\"REAPER\s+\(initializing\)\"'|xargs)"


while [[ -z "$longvar" ]]; do
  echo "$longvar"
  systemd-cat -t "debug" echo "waiting for reaper window to open"
  sleep 1
done

#i3-msg "[class="^REAPER$"], move to workspace 2"
