#!/usr/bin/env bash

TIMESTAMPE=$(date +%Y%m%d%H%M)

TOPIC=$(gum input --placeholder='Topic' | sed 's/ /_/g')

NOTESFOLDER="$HOME/Workspace/obsidian/notes"

if [[ ! -d $NOTESFOLDER ]]; then
  mkdir -pv "$NOTESFOLDER"
fi

clear

gum write --width=50 --height=38 --char-limit=0 --header.margin="1 1" --placeholder "Words" --value="# " >> "$NOTESFOLDER"/"$TOPIC"_"$TIMESTAMPE".md
