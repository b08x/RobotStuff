#!/usr/bin/env bash
#set -vx

declare OUTPUTS="/tmp/jack_load/outputs"
declare INPUTS="/tmp/jack_load/inputs"

if [[ ! -d /tmp/jack_load ]]; then
  mkdir -pv /tmp/jack_load
fi

function loadInput {

 local name=$1
 local device=$2

 jack_load $name zalsa_in -i "-d hw:$device,0"

}

function loadOutput {

 local name=$1
 local device=$2

 jack_load $name zalsa_out -i "-d hw:$device"

}

echo "Select action for jack_load "
choice=$(gum choose input output unload)

case $choice in
  input)
    arecord -l | grep card >> $INPUTS
    echo "select input device"
    device=$(cat $INPUTS | gum choose | awk '{print $2}' | sed 's/://g')
    echo "give this device an alias(no spaces)"
    name=$(gum input|sed 's/ /_/g')
    echo "${name}" >> $INPUTS
    loadInput $name $device
    ;;
  output)
    aplay -l | grep card >> $OUTPUTS
    echo "select output device"
    device=$(cat $OUTPUTS | gum choose | awk '{print $2}' | sed 's/://g')
    echo "give this device an alieas(no spaces)"
    name=$(gum input|sed 's/ /_/g')
    echo "${name}" >> $OUTPUTS
    loadOutput $name $device
    ;;
  unload)
    echo "unload which device?"
    name=$(cat $OUTPUTS $INPUTS|gum choose)
    #TODO: improve this logic, check against jack_lsp
    # name=$(gum input)
    jack_unload $name
    ;;

esac
