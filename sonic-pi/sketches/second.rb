use_debug true


set_mixer_control! hpf: 21

set_volume! 2
use_real_time


in_thread do
  loop do
    cue :tick
    sleep 0.5
    print beat
  end
end

live_loop :first do
  sync :tick
  use_synth :pluck

  play [64,62,60,67].tick
  sleep [0.5,1].choose
end
