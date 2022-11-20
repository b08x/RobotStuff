#!/usr/bin/env bash

RECORDINGS="$HOME/Notebook/voicenotes"

set_mic_levels()
{
  systemd-cat -t "fmit" amixer -D hw:0 set 'Capture' 78%
  systemd-cat -t "fmit" amixer -D hw:0 set 'Internal Mic Boost' 67%
  return 0
}


if ! [ -d $RECORDINGS ]; then
  mkdir -pv $RECORDINGS
fi

if ! pgrep -x "timemachine" > /dev/null; then
  set_mic_levels
  timemachine -t 10 -c 2 'system:capture_1' 'system:capture_2' -f flac -s -p "$RECORDINGS/tm-" &!
fi
