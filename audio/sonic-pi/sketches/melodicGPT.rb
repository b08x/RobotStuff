set_volume! 0.66
set_mixer_control! hpf: 21
use_sched_ahead_time 1
#use_real_time

use_bpm :link
set_link_bpm! 89

use_midi_defaults port: "midi_through_midi_through_port-0_14_0"


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

# Melody live_loop
live_loop :melody, sync: :beat do
  use_synth :piano
  use_octave 0
  notes = (ring :c4, :d4, :e4, :f4, :g4, :a4, :b4, :c5)
  durations = (ring 0.5, 0.25, 0.75, 0.5, 0.25, 0.75, 0.5, 0.25)
  midi notes.tick, release: durations.look / 2, channel: 1
  sleep durations.look
end

# Harmony live_loop
live_loop :harmony, sync: :melody do
  use_synth :beep
  chords = (ring chord(:c4, :major7), chord(:a3, :minor7), chord(:d3, :minor7), chord(:g3, :dom7))
  print chords
end

# Hip Hop Rhythm live_loop
live_loop :rhythm, sync: :beat do
  sample :bd_808, amp: 2 if spread(1, 4).tick
  sample :sn_dub, amp: 1.5 if spread(1, 4).rotate(2).look
  sample :drum_cymbal_closed, amp: 0.5 if spread(4, 4).rotate(1).look
  sleep 0.5
end
