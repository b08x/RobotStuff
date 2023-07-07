#!/usr/bin/env bash

declare -rx archive=REAPER-$(date +%Y%m%d%H).tar.gz
declare -rx destination="$HOME/Library/reaper/"

if [[ -d $destination ]]; then
	if [[ -f $destination/$archive ]]; then
  	echo "already backed up for the hour, hit o to overwrite"
	else
  	cd ~/.config/
  	tar -czvf $archive REAPER/

  	if [ $? = 0 ]; then
    	mv $archive ~/Library/reaper/
  	else
    	echo "archive did not complete"
  	fi
	fi
else
	echo "library not on this host, skipping task"
fi
