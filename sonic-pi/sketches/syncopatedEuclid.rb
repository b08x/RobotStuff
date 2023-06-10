set_volume! 0.66
set_mixer_control! hpf: 21
use_sched_ahead_time 1
#use_real_time

use_bpm :link
set_link_bpm! 60

use_midi_defaults port: "midi_through_midi_through_port-0_14_0"

# # syncronize to bar or beat
# live_loop :met do
#   puts "current bpm " + current_bpm.to_s
#   4.times do |bar|
#     puts "bar no: " + (bar + 1).to_s
#     cue :bar
#     4.times do |beat|
#       puts "beat no: " + (beat + 1).to_s
#       cue :beat
#       sleep 1
#     end
#   end
# end
#
# # First live_loop
# live_loop :euclid_beat do
#   use_bpm 60
#   use_synth :beep
#   notes = [:c3, :c4, :e4, :g4]
#   (16.times).each do |i|
#     print i
#     play notes[i / 4], amp: (i % 5 == 0 ? 2 : 0.5)
#     sleep 0.25
#   end
# end
#
# # Second live_loop
# live_loop :syncopated_accent, sync: :euclid_beat do
#   use_bpm 60
#   use_synth :beep
#   (16.times).each do |i|
#     play :c3, amp: (i % 7 == 0 ? 2 : 0.5)
#     sleep 0.25
#   end
# end

# Metronome live_loop
live_loop :met do
  puts "current bpm " + current_bpm.to_s
  4.times do |bar|
    puts "bar no: " + (bar + 1).to_s
    cue :bar
    4.times do |beat|
      puts "beat no: " + (beat + 1).to_s
      cue :beat
      sleep 1
    end
  end
end

# First live_loop
live_loop :euclid_beat, sync: :beat do
  use_bpm 60
  use_synth :mod_sine
  notes = [:c2, :c4, :e4, :g4]
  (16.times).each do |i|
    play notes[i / 4], amp: (i % 5 == 0 ? 1.25 : 0.5), release: 0.175
    sleep 0.25
  end
end

# Second live_loop
live_loop :syncopated_accent do
  use_bpm 60
  use_synth :beep
  (16.times).each do |i|
    play :c3, amp: (i % 7 == 0 ? 2 : 0.5)
    sleep 0.25
  end
end

# Third live_loop for percussion
live_loop :creative_drums, sync: :beat do
  sample :drum_heavy_kick
  sleep 0.5
  sample :drum_snare_soft
  sleep 0.5
  sample :drum_tom_hi_soft
  sleep 0.25
  sample :drum_tom_mid_soft
  sleep 0.25
end
