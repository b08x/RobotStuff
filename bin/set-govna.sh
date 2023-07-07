#!/usr/bin/env bash

set_govna () {
  local governor=$1
  # sudo cpupower frequency-set -r -g "$1"
  echo "${governor}" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
}


if [ "${1-nothing}" = "nothing" ]; then
  action=$(whiptail --title "Menu example" --menu "Choose an option" 15 42 5 \
  "performance" "Select performance profile" \
  "powersave" "Select powersave profile" 3>&1 1>&2 2>&3)
else
  set_govna $1
fi

sleep 0.5

exit
