#!/usr/bin/env bash

# jmeters -t vu -n vurack -r -6 -c 2 \
# zitasel01 zita-mu1:sel_out.L \
# zitasel02 zita-mu1:sel_out.R \
# zitamu01 zita-mu1:mon_out1.L \
# zitamu02 zita-mu1:mon_out1.R \
# luf01 Luftikus:lv2_audio_out_1 \
# luf02 Luftikus:lv2_audio_out_2 \
# system01 system:monitor_1 \
# system02 system:monitor_2

jmeters -t vu -c 2 -n 'lsampler' \
'ngrand' LinuxSampler:0 'ngrand' LinuxSampler:1 \
'contrabass' LinuxSampler:2 'contrabass' LinuxSampler:3 \
'jazzbass' LinuxSampler:4 \
'violin' LinuxSampler:5 \
'pizz' LinuxSampler:6 'pizz' LinuxSampler:7 \
'kay_banjo' LinuxSampler:8 \
'banjo_uke' LinuxSampler:9 'banjo_uke' LinuxSampler:10

# jack_mixer "jack_mixer_2:Monitor L" jack_mixer "jack_mixer_2:Monitor R" \
# luf01 Luftikus:lv2_audio_out_1 luf02 Luftikus:lv2_audio_out_2 \
# system01 system:monitor_1 system02 system:monitor_2 \
