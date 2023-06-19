set_volume! 0.66
set_mixer_control! hpf: 21
use_sched_ahead_time 1
#use_real_time

use_bpm :link
set_link_bpm! 45

# syncronize to bar or beat
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

use_midi_defaults port: "midi_through_midi_through_port-0_14_0"

# Euclidean rhythm of 5 beats over 8 steps
euclid_beats = (ring 1, 0, 1, 0, 1, 0, 1, 1)

# Accent beat for syncopated rhythm
accent_beats = (ring 0, 1, 0, 1, 0, 1, 0, 1)

# Piano melody
piano_notes = (ring :C4, :E4, :G4, :B4, :C5, :B4, :G4, :E4)

# Chord progression
chords = (ring chord(:C4, :major), chord(:F4, :major), chord(:G4, :major))

live_loop :euclid do
  tick
  sample :bd_haus if euclid_beats.look == 1
  sleep 0.25
end

live_loop :accent, sync: :euclid do
  tick
  sample :drum_cymbal_closed if accent_beats.look == 1
  sleep 0.25
end

live_loop :melody, sync: :euclid do
  tick
  use_synth :piano
  play piano_notes.look, release: 0.25
  sleep 0.25
end

live_loop :chords, sync: :euclid do
  tick
  use_synth :piano
  play chords.look, sustain: 1
  sleep 1
end
