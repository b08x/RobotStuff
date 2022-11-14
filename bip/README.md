# bipscripts

[bipscript]("https://bipscript.org") as an LV2 host, controllable by midi or osc

requires jack

to use:

```bash
# run in the background
bipscript <filename>.bip &!

# or to view print output
bipscript <filename>.bip

```


## mic controller

Passes mono input through high and low pass filters. Outputs a stero signal.

Control gain/mute with osc

```bash
oscsend localhost 9033 /mute/0
oscsend localhost 9033 /mute/1
```

## lsampler

Route linuxsampler --> AMS 8 chanel Stereo Mixer

## fad

Passes mono input through a series of effects

OSC control:

```bash

# set the delay time to 2.3 seconds
oscsend localhost 9034 /fad/delay f 2.3

# set the feedback level
oscsend localhost 9034 /fad/feedback f -40.0

```

## dragonfly reverb
