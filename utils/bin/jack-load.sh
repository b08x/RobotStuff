#!/usr/bin/env bash
set -vx

PREAMP_IN="$(arecord -l | grep "USB AUDIO  CODEC" | awk '{print $2}' | sed s/://g)"
PREAMP_OUT="$(aplay -l | grep "USB AUDIO  CODEC" | awk '{print $2}' | sed s/://g)"

PRODUCER="$(arecord -l | grep Producer | awk '{print $2}' | sed s/://g)"

if [[ -z $PREAMP_IN ]];
then
  systemd-cat -t "jack_load_preamp_in" echo "card not detected"
else
  jack_load preamp_in zalsa_in -i "-d hw:$PREAMP_IN",0 &
fi

if [[ -z $PREAMP_OUT ]];
then
  systemd-cat -t "jack_load_preamp_in" echo "card not detected"
else
  jack_load preamp_out zalsa_out -i "-d hw:$PREAMP_OUT",0 &
fi

if [[ -z $PRODUCER ]];
then
  systemd-cat -t "jack_load_producer_in" echo "card not detected"
else
  jack_load producer_in zalsa_in -i "-d hw:$PRODUCER",0 &
fi
