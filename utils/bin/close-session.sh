#!/bin/bash

if pgrep -x "lsmi-keyhack" > /dev/null
then
  i3-msg "exec --no-startup-id pkill -9 lsmi-keyhack";sleep 1
fi

# https://unix.stackexchange.com/a/74186
lsampler_pid=$(ps aux | grep "[l]inuxsampler" | awk '{print $2}')

if ! [ -x $lsampler_pid ] > /dev/null
then
  i3-msg "exec --no-startup-id kill -15 $lsampler_pid";sleep 2
fi

if pgrep -x "sonic-pi" > /dev/null
then
  log="$HOME/.sonic-pi/log/daemon.log"

  daemon_port=$(grep -P '"daemon"=>\d+' $log | awk -F "," '{print $11}'|cut -d ">" -f 2)

  token=$(grep -P "Token:" $log| cut -d " " -f7)

  i3-msg "exec --no-startup-id oscsend localhost $daemon_port /daemon/exit i $token && pkill -9 sonic-pi";sleep 2

  i3-msg "exec --no-startup-id /opt/sonic-pi/app/server/ruby/bin/clear-logs.rb"
fi

if pgrep -x "zita-lrx" > /dev/null
then
  i3-msg "exec --no-startup-id pkill -9 zita-lrx";sleep 2
fi

if pgrep -x "x42-meter" > /dev/null
then
  i3-msg "exec --no-startup-id pkill -9 x42-meter"
fi

if pgrep -x "patchage" > /dev/null
then
  i3-msg "exec --no-startup-id pkill -9 patchage";sleep 2
fi
