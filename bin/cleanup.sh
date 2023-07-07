#!/usr/bin/env bash

if [[ ! "${EUID}" -eq 0 ]]; then
  echo "please run as root. exiting"
  exit
fi

declare -rx timestampe=$(date +%Y%m%d%H%M)

if [ "${1-0}" = "0" ]; then
  days="0days"
else
  days="${1}days"
fi

if [ $(command -v fd) ];then

  if [ -d /tmp/removed ]; then
    mv /tmp/removed "/tmp/removed_${timestampe}"
  fi

  mkdir -pv /tmp/removed

  fd --change-older-than ${days} -u --show-errors -E "proc/*" -E "sys/*" -E "*cache*" -E "lost+found/" -E "tmp/*" -E "*.gnupg" -E "pubring" -E "run/*" -E "mnt/*" -H "@\d+:\d+:\d+~$"  --full-path "/" -X mv -v '{}' /tmp/removed/

  echo "the ansible backup files moved to /tmp/removed and will be removed upon next reboot"

else
  echo "fd is not installed. "
fi
