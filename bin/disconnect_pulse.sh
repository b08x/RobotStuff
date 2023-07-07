#!/usr/bin/env bash

disconnect_pulse() {
  jack_disconnect "PulseAudio JACK Sink:front-left" system:playback_1
  jack_disconnect "PulseAudio JACK Sink:front-right" system:playback_2
  jack_disconnect "PulseAudio JACK Source:front-left" system:capture_1
  jack_disconnect "PulseAudio JACK Source:front-right" system:capture_2

  return 0
}

disconnect_pulse
