#!/usr/bin/env bash
#

connectmixer(){
  jack_connect \
  "a2j:Midi Through [14] (capture): Midi Through Port-0" "jack_mixer_2:midi in"

  return 0
}

mute(){
  sendmidi dev 'Midi Through Port-0' cc 32 127
}

unmute(){
  sendmidi dev 'Midi Through Port-0' cc 32 1
}

if ! [[ $(jack_lsp | grep jack_mixer |grep midi) ]]; then
  echo "jack mixer is not running"
  exit
fi

#if ! [[ $(jack_lsp -c | grep "  jack_mixer_2:midi in" -B1) ]];then
  connectmixer
#fi

action=$1

if [[ $action == 'mute' ]];then
  mute
elif [[ $action == 'unmute' ]];then
  unmute
fi
