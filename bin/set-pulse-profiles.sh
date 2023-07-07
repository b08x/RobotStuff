#!/usr/bin/env bash

# set pulseaudio card profiles to off

cards=($(pacmd list-cards | grep "name:" |
                            awk '{ print $2 }' |
                            sed 's/>//g' |
                            sed 's/<//g'))

for i in "${cards[@]}"
do
  pactl set-card-profile $i "off"
done
