#!/bin/sh

vid=$1

ffmpeg -i "$vid" -vn -acodec libvorbis "${vid%.mkv}.ogg"
