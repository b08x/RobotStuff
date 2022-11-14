set_mixer_control! hpf: 21
use_sched_ahead_time 1

set :tempo, 60

live_loop :timer do
  cue :clock
  use_bpm get[:tempo]
  sleep bt(1)
end

# Sync 2-bar patterns
live_loop :half, autocue: false do
  sync :clock
  cue :halfnote
  sleep bt(0.5)
end

# Synch 4-bar patterns
live_loop :quarter, autocue: false do
  sync :clock
  cue :quarternote
  sleep bt(0.25)
end

def partone
  2.times do
    play (note_range :d3, :d4, pitches: (chord :f, :M7)).tick, pan: -0.5, pitch: 0
    sleep 0.25
  end
end

def parttwo
  2.times do
    play (note_range :d3, :d4, pitches: (chord :f, :M7)).tick, pan: 0.5, pitch: 12
    sleep 0.25
  end

end
with_fx :echo, phase: 4, decay: 1, pre_mix: 0.4 do
  live_audio :jack_mixer, input: 1, stereo: true
end

notes = (ring :A3, :C4, :E4, :G4, :A2, :C3, :E3, :G3, :D4)


live_loop :prog01, sync: :clock do
  #stop
  use_octave -1
  8.times do
    midi notes.tick - 12, pan: -0.8, pitch: 0, channel: 1, velocity: 80, velocity_f: 72, on: 0
    sleep 0.5
  end

end

live_loop :prog02, sync: :clock do
  #stop
  8.times do
    midi notes.tick - 24, pan: 0.8, pitch: 0, channel: 1, velocity: 80, velocity_f: 72
    sleep 0.5
  end
end

live_loop :intro, sync: :quarternote do
  stop
  notes = (note_range :a3, :a5, pitches: (chord :a, :m7)).mirror


  midi notes.tick, pan: -0.8, pitch: 0, channel: 1, velocity: 70, velocity_f: 72
  sleep 1

end

live_loop :intro1, sync: :clock do
  stop
  notes = (note_range :a3, :a5, pitches: (chord :a, :minor7)).mirror
  2.times do
    midi notes.tick, pan: 0.8, pitch: [6,0].tick, channel: 4, velocity: 75, velocity_f: 72
    sleep 0.5
  end

end

live_loop :intro2, sync: :quarternote do
  #use_random_seed 8882332
  stop
  notes = (note_range :C3, :C5, pitches: (chord :C, :M))
  density 2 do
    6.times do
      midi notes.tick, pan: 0.8, pitch: [0,-12,0].tick, channel: 4, velocity: 70, velocity_f: 72
      sleep 0.5
    end
  end
end

live_loop :intro4, sync: :clock do
  stop
  # notes = (note_range :e3, :e5, pitches: (chord :e, '7sus4'))
  notes = (note_range :a2, :a4, pitches: (chord :a, :m))
  4.times do
    midi notes.tick, pan: -0.8, pitch: [0,12,0].tick, channel: 1, velocity: 50, velocity_f: 72
    sleep 0.25
  end
end

live_loop :intro4b, sync: :clock do
  stop
  #notes = (note_range :c3, :c5, pitches: (chord :e, '7sus4'))
  notes = (note_range :a3, :a5, pitches: (chord :a, :min))

  6.times do
    midi notes.tick, pan: -0.8, pitch: [0,12,0].tick, channel: 3, velocity: 60, velocity_f: 72
    sleep [0.25,0.5].choose
  end
end


live_loop :intro5, sync: :clock do
  stop
  #notes = (note_range :c3, :c4, pitches: (chord :a, :sus2))
  notes = (scale :a3, :minor_pentatonic, num_octaves: 2).take(5)
  density 2 do
    5.times do
      midi notes.tick, pan: 0.8, pitch: [0,12,0].tick, channel: 4, velocity: 60, velocity_f: 72
      sleep [0.5,0.125,0.75].tick
    end
  end
  sleep 4
end


live_loop :intro6, sync: :clock do
  stop
  notes = (scale :a3, :minor_pentatonic, num_octaves: 2).take(6).mirror

  12.times do
    midi notes.tick, pan: rrand( -1, 1 ), pitch: 24, channel: 5, vel: 50, sustain: 1
    sleep 0.125
  end
  sleep 0.5
end

live_loop :intro7, sync: :quarternote do
  stop
  notes = (scale :a1, :minor_pentatonic, num_octaves: 1).reverse

  3.times do
    midi notes.tick, pan: 0.2, pitch: 0, channel: 6, vel: 70, sustain: 1, release: 1
    sleep 2
  end


  sleep 2

end

#TODO:
# hi hats

live_loop :otherpart do
  stop
  sync :clock
  use_synth :piano
  partone
end

live_loop :anotherpart do
  stop
  sync :every_four_bars
  parttwo
end
