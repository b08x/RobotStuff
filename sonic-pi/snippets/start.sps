# key: start
# point_line: 0
# point_index: 7
# --
set_mixer_control! hpf: 21

live_loop :timer do
  use_bpm 60

  print current_bpm
  puts beat
  puts bt(1)
  #use_arg_bpm_scaling true
  puts current_beat_duration
  sleep bt(1)
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :timer
  cue :every_two_bars
  sample :elec_blip, amp: 0.001, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :timer
  cue :every_four_bars
  sample :elec_blip, amp: 0.001, rate: 2.0
  sleep 16
end
