#!/bin/bash
# A quick documentation finder based on rofi and devdocs
# Requires: rofi, devdocs, i3-sensible-terminal, qutebrowser nerdfonts
files=~/.cache/rofi-search_term_list

BROWSER="firefox"
GOOGLE_SEARCH_URL="https://google.com/search?q"
BRAVE_SEARCH_URL="https://search.brave.com/search?q"

append_new_term() {
	# Delete term. Append on the first line.
	sed -i "/$input/d" $files
	sed -i "1i $input" "$files"
	# Max cache limited to 20 entries: https://github.com/Zeioth/rofi-devdocs/issues/3
	sed -i 20d "$files"
}

if [ -e $files ]; then
	# If file list exist, use it
	input=$(cat $files | rofi -dmenu -p "manual")
	else

	# There is no file list, create it and show menu only after that
	touch $files
	input=$(cat $files | rofi -dmenu -p "manual")

	#	The file if empty, initialize it, so we can insert on the top later
  if [ ! -s "$_file" ]
  then
    echo " " > "$files"
  fi
fi

case "$(echo $input | cut -d " " -f 1)" in

	dd)
		# Search dev docs
		append_new_term
		query=$(echo "$input" | cut -c 3- | xargs -0)
	  exec devdocs-desktop "$(echo $query)" &> /dev/null &
	  ;;
	w)
		# Search dictionary
		append_new_term
		query=$(echo "$input" | cut -c 2- | xargs -0)
		echo $query
		if ! [ -z $query ]
		then
			exec $BROWSER "$GOOGLE_SEARCH_URL=Define+$query" &> /dev/null &
		fi
		;;
	*)
	  # Search the web
		append_new_term
	  query=$(echo "$input" | cut -c 1- | xargs -0)
		if ! [[ -z $query ]]
		then
			exec $BROWSER "$GOOGLE_SEARCH_URL=site+stackoverflow.com+$query" &> /dev/null &
			sleep 0.25
			exec $BROWSER "$GOOGLE_SEARCH_URL=site+%22unix.stackexchange.com%22+$query&sort=date-sdate" &> /dev/null &
			sleep 0.25
			exec $BROWSER "$GOOGLE_SEARCH_URL=site+gist.github.com+$query&source=lnt&tbs=qdr:y" &> /dev/null &
			sleep 0.25
			exec $BROWSER "$GOOGLE_SEARCH_URL=$query&source=lnt&tbs=qdr:y" &> /dev/null &
			sleep 0.25
			exec $BROWSER "$BRAVE_SEARCH_URL=$query&tf=py" &> /dev/null &
		fi
	  ;;

esac
