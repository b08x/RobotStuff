#!/usr/bin/env bash

function mo_ytdlp_transcript_clean(){
    local url=$1
    yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang en --sub-format ttml --convert-subs srt --output "transcript.%(ext)s" ${url};
    cat ./transcript.en.srt | sed '/^$/d' | grep -v '^[0-9]*$' | grep -v '\-->' | sed 's/<[^>]*>//g' | tr '\n' ' ' > output.txt;
}

mo_ytdlp_transcript_clean $1