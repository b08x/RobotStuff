#!/usr/bin/env ruby

#reverbs
#compressors
#high and low pass filters

# havent titled this one yet
# lets make anns head bob (not intially, but pun intended)

#introduction

set_mixer_control! hpf: 21
use_debug true

use_bpm 80

#for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
#the way it is now, dont fuck with it. (guitarix isn't necessary for this)
with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 42, low_q: 0.8,
  mid: 0, mid_note: 70, mid_q: 0.8,
  high: 0, high_note: 105, high_q: 0.6,
high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 1 do


  # Count every beat
  live_loop :bar do
    cue :tick
    sleep 1
  end

  # Sync 2-bar patterns
  live_loop :two_bars, autocue: false do
    sync :tick
    cue :every_two_bars
    sample :elec_blip, amp: 0.001, rate: 1
    sleep 8
  end

  # Synch 4-bar patterns
  live_loop :four_bars, autocue: false do
    sync :tick
    cue :every_four_bars
    sample :elec_blip, amp: 0.001, rate: 2.0
    sleep 16
  end

  #with_fx :reverb do

  @olthymeamp = 0.05
  with_fx :level, amp: 0, amp_slide: 4 do |a|
    @oltimey = in_thread do
      loop do
        control a, amp: @olthymeamp
        with_fx :tremolo do
          sample :vinyl_hiss, rate: 0.5, pan: rrand(-0.5,0.5), pan_slide: 8 do |h|
            control h, pan: rrand(-0.5, 0.5)
          end
          sleep sample_duration :vinyl_hiss, rate: 0.5
        end
      end
    end
  end


  #live_audio :gitar, stereo: false, input: 1

  #live_audio :banjo, stereo: false, input: 2


  #linuxsampler
  live_audio :electrofull, stereo: false, input: 3
  live_audio :classic808, stereo: false, input: 4

  live_audio :speakfx, stereo: false, input: 5

  live_audio :ace_rhy_pluskit, stereo: false, input: 6

  live_audio :drumkit_exceptional, stereo: false, input: 7


  #sounds muddy
  #with_fx :pan, pan: 0.2 do

  with_fx :eq, low_shelf: -0.3, low_shelf_note: 31, low_shelf_slope: 0.9, low: -0.2, low_note: 42, low_q: 0.8,
    mid: -0.3, mid_note: 55, mid_q: 0.8,
    high: 0.3, high_note: 105, high_q: 0.8,
  high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 1 do

    live_audio :grand_piano, stereo: false, input: 8
  end

  #end


  live_audio :anabol, stereo: false, input: 9
  live_audio :acous, stereo: false, input: 10

  live_audio :misc01, stereo: false, input: 11

  #live_audio :cello_alchemy, stereo: false, input: 12


  with_fx :pan, pan: 0.6 do
    with_fx :flanger do
      with_fx :echo do
        live_audio :cello_sforzando, stereo: false, input: 13
      end
    end
  end



  live_audio :petri_foo, stereo: false, input: 15
  live_audio :zynsub, stereo: false, input: 16



  #end #end main reverb
end #end main eq
