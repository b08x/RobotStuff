#!/usr/bin/env bash
# shellcheck disable=CODE

function run {
  if pgrep -x -f "$1" ; then
    pkill -9 $@&
    sleep 1
    $@&
  else
    sleep 1
    $@&
  fi
}

run "sxhkd"

sleep 0.5
