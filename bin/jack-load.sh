#!/usr/bin/env bash
#set -vx

declare OUTPUTS="/tmp/outputs.txt"
declare INPUTS="/tmp/inputs.txt"

if [ -f $OUTPUTS ] || [ -f $INPUTS ];then
  rm -rf $OUTPUTS $INPUTS
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

echo "Is this an input or output device? "
choice=$(gum choose input output unload)

case $choice in
  input)
    arecord -l | grep card >> $INPUTS
    echo "select input device"
    device=$(cat $INPUTS | gum choose | awk '{print $2}' | sed 's/://g')
    echo "give this device an alias(no spaces)"
    name=$(gum input|sed 's/ /_/g')
    loadInput $name $device
    ;;
  output)
    aplay -l | grep card >> $OUTPUTS
    echo "select output device"
    device=$(cat $OUTPUTS | gum choose | awk '{print $2}' | sed 's/://g')
    echo "give this device an alieas(no spaces)"
    name=$(gum input|sed 's/ /_/g')
    loadOutput $name $device
    ;;
  unload)
    echo "unload which device?"
    name=$(gum input)
    jack_unload $name
    ;;

esac
