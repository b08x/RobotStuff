#!/usr/bin/env ruby
# frozen_string_literal: true

# Check stereo WAV-file for identical channels,
# detecting faux-stereo files generated by some audio-editing software and DAWs.
#
# Outputs a true-mono WAV file on detection of faux-stereo.
#
# Takes left channel of the input file, writes in the same location with -MONO suffix in file name.


# USAGE:
#     zrtstr [FLAGS] [OPTIONS] [INPUT]
#
# FLAGS:
#     -n, --nowrite    Disable saving converted mono files. Analyze pass only.
#     -h, --help       Prints help information
#     -l, --license    Display the license information.
#     -p, --protect    Disable overwriting when saving converted mono files.
#     -V, --version    Prints version information
#
# OPTIONS:
#     -d, --dither <THRESHOLD>
#             Set threshold for sample level difference to process dithered audio.
#             Positive number (amplitude delta). [default: 10]
#
# ARGS:
#     <INPUT>    Path to the input file to process. If no input given, process all WAV files in current directory.
