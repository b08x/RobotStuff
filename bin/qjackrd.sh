#!/usr/bin/env bash

qjackrcd -l -26 -r -dir ~/Recordings/audio/dictations \
--pcmd 'sox ${0} ${0%%wav}ogg' \
--jack-cns1 'system:capture_1' \
--jack-cns2 'system:capture_1'
