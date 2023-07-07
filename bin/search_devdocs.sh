#!/bin/bash
# A quick documentation finder based on rofi and devdocs
# Requires: rofi, devdocs, i3-sensible-terminal, qutebrowser nerdfonts
files=~/.cache/search_devdocs_history

dir="$HOME/.config/rofi/launchers/type-1"
theme="style-10"

## Run
rofi=$()

append_new_term() {
	# Delete term. Append on the first line.
	sed -i "/$input/d" $files
	sed -i "1i $input" "$files"
	# Max cache limited to 20 entries: https://github.com/Zeioth/rofi-devdocs/issues/3
	sed -i 20d "$files"
}


if [ -e $files ]; then
	# If file list exist, use it
	input=$(cat $files | rofi -dmenu -theme ${dir}/${theme}.rasi -p "query:> ")
	else

	# There is no file list, create it and show menu only after that
	touch $files
	input=$(cat $files | rofi -dmenu -theme ${dir}/${theme}.rasi -p "query:> ")

	#	The file if empty, initialize it, so we can insert on the top later
  if [ ! -s "$_file" ]
  then
    echo " " > "$files"
  fi
fi

# docs=("Ansible" "Bash" "Bootstrap" "CSS" "Docker" "HTML" "i3" "JavaScript" "Jekyll" "Jinja" "Ruby" "Sass" "Web APIs")
# doc="$(echo $input | cut -d " " -f -1|xargs -0)"
# query="$(echo $input | cut -d " " -f 2-)"

append_new_term

# exec devdocs-desktop "$(echo ${doc})" "$(echo ${query})" &> /dev/null &

exec devdocs-desktop "$(echo -e ${input})" &> /dev/null &
