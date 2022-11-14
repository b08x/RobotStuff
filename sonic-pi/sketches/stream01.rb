# Count every beat
live_loop :bar do
  use_bpm 89
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
# Sync 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.001, rate: 2.0
  sleep 16
end
# Sync 8-bar patterns
live_loop :eight_bars, autocue: false do
  sync :tick
  cue :every_eight_bars
  sample :elec_blip, amp: 0.001, rate: 2.0
  sleep 32
end

# to mute the arpeggiator;
# midi cc number 120 is standard for 'all sound off'
#midi_cc 120, 127, channel: 1, port: "midi_through_port-0"
#midi_cc 120, 0, channel: 1, port: "midi_through_port-0"

#TODO:
# have this be able to tell jack_transport what tempo to use....


# midi chord ---> midi strum --> (qmidiarp) --> lsampler

with_fx :pan, pan: -0.45 do

  live_audio :piano_l, input: 1, stereo: false

end

with_fx :pan, pan: 0.45 do

  live_audio :piano_r, input: 2, stereo: false

end

with_fx :pan, pan: -0.10 do

  live_audio :oud_l, input: 3, stereo: false

end

with_fx :pan, pan: 0.10 do

  live_audio :oud_r, input: 4, stereo: false

end

comment do
  live_loop :helm do
    sync :every_two_bars
    use_real_time
    midi octs(:c1,3).tick, channel: 16, port:"midi_through_port-0", vel: 100, sustain: 0.8
  end
end



  # live_loop :arpg01 do
  #   sync :tick
  #   use_real_time
  #   stop
  #   #use_random_seed 4841
  #   #midi_note_on :d3, channel: 1, port: "midi_through_port-0", vel: 100, sustain: 0.1
  #   #midi scale(:c2, :major).tick, channel: 1, port: "midi_through_port-0", vel: 100, sustain: 0.8
  #   #midi scale(:c2, :major).tick, channel: 1, port: c
  #   notes = scale(:c4, :bhairav)
  #   midi notes.tick, channel: 2, port: "midi_through_port-0", vel: 80, sustain: 0.8
  #   sleep 0.125
  #   #midi scale(:c2, :major).tick, channel: 2, port: "midi_through_port-0", vel: 100, sustain: 0.8
  # end
  #



live_loop :arpg02 do
  sync :tick
  use_real_time
  #use_random_seed 4841
  #midi_note_on :d3, channel: 1, port: "midi_through_port-0", vel: 100, sustain: 0.1
  #midi scale(:c2, :major).tick, channel: 1, port: "midi_through_port-0", vel: 100, sustain: 0.8
  #midi scale(:c2, :major).tick, channel: 1, port: c
  #notes = scale(:c2, :major_pentatonic)
  notes = scale(:e1, :minor_pentatonic, num_octaves: 2).shuffle

  midi_note_on notes.pick(2), channel: 1, port: "midi_through_port-0", vel: 120
  sleep 0.125
  #midi scale(:c2, :major).tick, channel: 2, port: "midi_through_port-0", vel: 100, sustain: 0.8
end
