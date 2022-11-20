#!/usr/bin/env bash

# disable cards from being used by pulseaudio

cards=($(pacmd list-cards | grep "name:" | awk '{ print $2 }' | sed 's/>//g' | sed 's/<//g'))

for i in "${cards[@]}"
do
  pactl set-card-profile $i "off"
done
