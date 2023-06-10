#!/usr/bin/env ruby

set_mixer_control! hpf: 21

with_fx :eq, low_shelf: 0, low_shelf_note: 21, low_shelf_slope: 0.1, low: 0, low_note: 28, low_q: 0.8,
             mid: 0, mid_note: 66, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 124, high_shelf_slope: 0.5, pre_amp: 1 do

use_bpm 103

#at 90bpm a quarter note is about 0.6667 seconds long
#a whole note is 2.6667 seconds long

live_loop :slowsim do
  #with_fx :wobble, cutoff_min: 50, cutoff_max: 75, wave: 1, smooth_up: 0.2, smooth_down: 0.2, pulse_width: 0.25, res: 0.8 do
    with_fx :echo, phase: 0.5, decay: 4 do
      with_fx :pan, pan: -1, pan_slide: 4 do |p|
        control p, pan: 1
          sample DRUM_KITS, "80_scratch",  attack: 1, decay: 0.5,  decay_level: 1.5, sustain: 3, release: 1
          #sample forzee_kit, "China-4",  attack: 1, decay: 0.5,  decay_level: 1.5, sustain: 3, release: 1
      end
    end
  #end
  sleep 6
end



#something = spread(5,8)

# live_loop :heartbeat do
#
#   kick = bools(0,0,0,0, 1,1,0,0, 1,1,1,0)
#
#   4.times do
#     tick
#     sample HYDRO_KITS, "36-Ludwig26Kick-3", on: kick.look
#     sleep 1
#   end
#
# end


live_loop :drums do
  cue :spread
 #               1 e & a  2 e & a  3 e & a  4 e & a  5 e & a
 cymbals = bools(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0)
 hard    = bools(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0)
 soft    = bools(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0)
 kick    = bools(0,0,1,1, 0,0,1,1, 1,0,0,0, 1,1,1,0, 0,0,0,0)


   16.times do
     tick
     if cymbals.look then
       sample SAMPLES, "42-SabianRockHatClosed-5", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3
     else
       #sample pearl_kit, "42-SabianRockHatClosed-3", amp: 0.5
       puts "heyo"
     end
     #sample pearl_kit, "38-PorkpieSnare-3", on: hard.look
     #sample pearl_kit, "38-PorkpieSnareEdge-3", on: soft.look
     sample SAMPLES, "TomMid-4", on: soft.look
     sample SAMPLES, "TomHigh-4", on: hard.look

     sample SAMPLES, "TomLow-4", on: kick.look

     sleep 1
   end
end
#
#
#
#
#
# live_loop :sp do
#   sync :spread
#
#   sample forzee_kit, "TomHigh-4" if spread(3,8).tick
#   #
#   sample forzee_kit, "TomLow-4" if spread(7,11).look
#   #
#   sample forzee_kit, "TomMid-4" if spread(1,4).look
#   #
#   sleep 0.25
#
# end




















end #end of eq fx
