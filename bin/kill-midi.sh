#!/usr/bin/env bash

# ensure midi through port-0 gets connected to objects that play sound.
# this will ensure the `sendmidi panic` binding functions as it should.


MIDI_IN=("REAPER:MIDI Input 1"
         "LinuxSampler:midi_in_0"
         "Helm:lv2_events_in"
        )

for midi_in in "${MIDI_IN[@]}"; do
  jack_connect "a2j:Midi Through [14] (capture): Midi Through Port-0" "$midi_in" || continue
done
