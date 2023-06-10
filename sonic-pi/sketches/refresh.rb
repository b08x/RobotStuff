# Welcome to Sonic Pi

set_volume! 0.66
set_mixer_control! hpf: 21
use_sched_ahead_time 1
#use_real_time

use_bpm :link
set_link_bpm! 60

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

#notes = (ring :A3, :C4, :E4, :G4, :A2, :C3, :E3, :G3, :D4)


live_loop :bassline_piano, sync: :bar do
  stop
  notes = (ring :a1, :c2, :e2, :g2, :g1, :d2, :c2, :a1)
  use_octave 0
  notes.each do |note|
    midi note, channel: 2, velocity: 80, velocity_f: 72, sustain: 1.0
    sleep 1
  end
end


at bar(4) do
  live_loop :bassline_bass, sync: :bassline_piano do
    stop
    notes = (ring :a2, :c3, :e3, :g3, :g2, :d3, :c3, :a2)
    use_octave 0
    notes.each do |note|
      midi note, channel: 3, velocity: 80, velocity_f: 72, sustain: 1.0
      sleep 1
    end
  end
end

at bar(6) do
  live_loop :piano01, sync: :beat do
    stop
    #notes = (ring :a1, :c2, :e2, :g2, :g1, :d2, :c2, :a1).mirror
    notes = (note_range :a3, :a5, pitches: (chord :a, :m7)).mirror
    use_octave 0
    notes.each do |note|
      midi note, channel: 2, velocity: 80, velocity_f: 72, sustain: 1.0
      sleep 1
    end
  end
end

at bar(8) do
  live_loop :banjo01, sync: :bar do
    stop
    use_random_seed 4808
    notes = (note_range :C4, :C6, pitches: (chord :C, :maj11)).repeat.reflect.stretch(3)
    durations = (ring 0.25,0.125,0.25,0.125,0.25,0.5,0.5,0.5)
    notes.each do |note|
      midi notes.tick, channel: 4, velocity: 60, velocity_f: 72, sustain: 0.25
      sleep durations.look
    end
  end
  
end

at bar(10) do
  live_loop :piano02, sync: :beat do
    stop
    notes = (note_range :a3, :a5, pitches: (chord :a, :m7)).reflect.take(4).reverse
    durations = (ring 0.5,0.25,0.5,0.25,0.5,0.5,0.5,0.5)
    use_octave 1
    notes.each do |note|
      midi note, channel: 2, velocity: 45, velocity_f: 45, sustain: 1.0
      sleep durations.look
    end
  end
end
