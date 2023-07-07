#!/usr/bin/env ruby
# frozen_string_literal: true

# LUFS is a measurement of perceived loudness, whereas dBFS is a precise measurement of amplitude peaks in a digital signal.
#
# dBFS is solely a measurement of electrical level, without human perceptual filters.

# dBFS is a peak measurement and LUFS is a loudness measurement.

# dBFS is the unit of measurement for the amplitude levels or peaks, and the maximum value is defined as 0 dBFS.

# Ideal peak levels are believed to be between -6dBFS and -3dBFS.

# +----+-----+------+------+-----+
# | Vel| Dyn.|   dB |rev.dB|   % |
# +----+-----+------+------+-----+
# | 127| fff |   0.0| 57.6 | 100 |
# | 112| ff  |  -2.2| 55.4 |  86 |
# |  96| f   |  -4.9| 52.7 |  71 |
# |  80| mf  |  -8.0| 49.6 |  57 |
# |  64| mp  | -11.9| 45.7 |  44 |
# |  48| p   | -16.9| 40.7 |  31 |
# |  32| pp  | -23.9| 33.7 |  19 |
# |  16| ppp | -36.0| 21.6 |   8 |
# |   0|-off-| -57.6|    0 |   0 |
# +----+-----+------+------+-----+
