#!/usr/bin/env bash

declare -rx BACKGROUNDS="/usr/share/backgrounds/syncopated"

if [ -x "$(command -v autorandr)" ]; then
  profile=$(autorandr --detected)
  autorandr -l "$profile"
else
  echo "autorandr not found"
fi

sleep 1

#note: tilda does not expand in quotes
if [ -f ~/.fehbg ]; then
  ~/.fehbg
else
  #feh --no-fehbg --bg-scale $BACKGROUNDS/crescendo_01.png $BACKGROUNDS/str_01_03_bw_01.png
  feh --recursive --bg-fill --randomize $BACKGROUNDS/*
fi
