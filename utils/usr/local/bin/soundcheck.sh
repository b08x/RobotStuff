#!/usr/bin/env bash
#set -evx # Quit script on error

focus() {
  i3-msg "[class="soundcheck"], move position center, focus";sleep 0.125
}

send_command() {
  window_id=$1
  command=$2
  kittysock="$KITTY_LISTEN_ON"

  kitty @ --to $kittysock send-text --match id:$window_id $command
}

refresh_patchage() {
  xdotool search --onlyvisible --name "Patchage" key ctrl+r
  sleep 0.25
  xdotool search --onlyvisible --name "Patchage" key ctrl+g
  sleep 0.25
  xdotool search --onlyvisible --name "Patchage" key ctrl+f
}

connect_pulse() {
  jack_connect "PulseAudio JACK Sink:front-left" "zita-mu1:in_1.L"
  jack_connect "PulseAudio JACK Sink:front-right" "zita-mu1:in_1.R"

  jack_connect "zita-mu1:mon_out1.L" "system:playback_1"
  jack_connect "zita-mu1:mon_out1.R" "system:playback_2"
}

disconnect_pulse() {
  jack_disconnect "PulseAudio JACK Sink:front-left" system:playback_1
  jack_disconnect "PulseAudio JACK Sink:front-right" system:playback_2

  jack_disconnect "PulseAudio JACK Source:front-left" system:capture_1
  jack_disconnect "PulseAudio JACK Source:front-right" system:capture_2
}

soundcheck() {
  amixer -D hw:0 set Master unmute

  #TODO: a visual
  send_command 2 "play -V -r 48000 -n synth 3 sin 440 vol -20dB\n"
  sleep 4

  send_command 2 "exit\n"
  sleep 0.5

  focus

  dialog \
    --title "Question." \
    --yesno "Hear anything?" \
    0 0
  res=$?

  #TODO: option to play soundcheck again

  if [ $res = 0 ]; then
    echo "gooood"
  else
    echo "soundcheck was not run, checklog"

    if ! pgrep -x "patchage" > /dev/null; then
      i3-msg "exec --no-startup-id patchage"
      sleep 0.25
    fi

    sudo journalctl -b -o json | lnav -f ~/.config/lnav/checklog.lnav
    #exit
  fi

}

menu() {
  kittysock="$KITTY_LISTEN_ON"

  kitty @ --to $kittysock send-text --match id:1 'action=$(dialog --clear \
              --menu "What do you want to do?" 20 45 5 \
              "soundcheck" "make sure sound is working" \
              "backup" "backup" \
              "reboot" "backup and reboot" \
              "shutdown" "backup and shutdown" 2>&1 >/dev/tty) && /usr/local/bin/soundcheck.sh $action\n'
              res=$?


  # action="$(kitty @ --to unix:/tmp/kittySoundcheck get-text \
  #                   --match id:1 --extent last_non_empty_output | tail | xargs)"



  # action="$(dialog --clear \
  #           --menu "What do you want to do?" 20 45 5 \
  #           "soundcheck" "make sure sound is working" \
  #           "backup" "backup" \
  #           "reboot" "backup and reboot" \
  #           "shutdown" "backup and shutdown" 2>&1 >/dev/tty)"
}

focus

# mute the main soundcard
send_command 3 "amixer -D hw:0 set Master mute\n"
sleep 0.125
# wait for jack to be running if it already isn't
send_command 4 "jack_wait -w\n"

# check if pulse is connected to sysem ports
pulse_connections=$(jack_lsp -cp | awk '/system/{print previous_line}{previous_line=$0}' | grep 'Pulse')

# if som disconnec pulse from system ports
if [[ -z "$pulse_connections" ]];
then
  systemd-cat -t "soundcheck" echo "Pulse is not connected to any jack ports"
else
  disconnect_pulse
fi

# launch these
if ! pgrep -x "zita-mu1" > /dev/null; then
  i3-msg "exec --no-startup-id zita-mu1"
  sleep 0.25
  connect_pulse
fi

# if ! pgrep -x "pavucontrol" > /dev/null; then
#   i3-msg "exec --no-startup-id pavucontrol"
#   sleep 0.125
# fi

# if ! pgrep -x "alsamixer" > /dev/null; then
#   send_command 1 "alsamixer -c 0\n"
# fi
#
# if ! pgrep -x "pulsemixer" > /dev/null; then
#   send_command 3 "pulsemixer\n"
# fi

# if an argument is passed to the script
# then assign the action variable to that argument
# if nothing is passed then load the menu
if [ "${1-nothing}" = "nothing" ]; then
  focus
  menu
else
  action="$1"
fi

# if there is no argument passed or the menu is cancelled
# then polietly exit
if [[ -z "$action" ]]; then
  echo "nevermind then"
  sleep 1
  exit
fi

case $action in
  soundcheck )
    echo "running soundcheck..."
    soundcheck
    ;;
  backup )
    send_command 3 "$HOME/backup.sh\n"
    ;;
esac

sleep 0.25

# arrange the windows
if [ $? = 0 ]; then

  if pgrep -x "patchage" > /dev/null; then
    i3-msg "[class="^Patchage$"], floating enable, resize set 1252 780, move position 1478px 1160";sleep 0.25
  fi

  # i3-msg "[class="^Pavucontrol$"], resize set 1103 535, move position 2829px 1328";sleep 0.25

  # i3-msg "[class="alsamixer"], floating enable, resize set 1319 479, move position 2616px 585";sleep 0.25

  i3-msg "[class="Zita-mu1"], scratchpad show, move position 2197px 2388";sleep 0.25

  focus

  refresh_patchage

  amixer -D hw:0 set Master unmute

  clear

  ranger
else
  i3-msg "exec --no-startup-id uxterm -class 'dialog' -e dialog \
        --msgbox 'Something terrible has happened...\n\ncheck $loge\n\nlook behind you' \
        10 40"
  sleep 1
  exit
fi
