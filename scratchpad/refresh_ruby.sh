#!/usr/bin/env ruby

rubies=$(paru -Q | grep ruby | awk '{print $1}')

for gem in ${rubies[@]}; do paru -Rdd --noconfirm "$gem"; done
