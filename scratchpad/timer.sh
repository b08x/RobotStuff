#!/usr/bin/env sh

rofi -dmenu | xargs xterm -class timer -e termdown -f doom --exec-cmd "if [ '{0}' < '7' ]; then notify-send 'Timer Complete'; espeak-ng -g 10 -ven-gb-scotland 'dingk dingk, dingk dingk, dingk dingk' ; fi"
