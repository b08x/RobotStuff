#!/bin/sh

vid=$1

ffmpeg -i "$vid" -vn -acodec copy "${vid%.mkv}.wav"
