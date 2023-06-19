#!/usr/bin/env ruby
#  learning how to use emacs with sonic-pi
live_loop :timer do
  use_bpm 60
  cue :timer
  sleep 1
  puts beat
end
#
#
with_fx :sound_out, output: 1, amp: 0 do
  live_loop :intro do
  #use_random_seed 3248
  with_fx :hpf, cutoff: 30 do

  #with_fx :mono do
    3.times do
      play [51,42,48,48.75].choose
      sleep 0.5
    end
    sleep 0.25
    2.times do
      with_transpose 2 do
        play [51,42,48,48.75].choose, release: 0.0125
        sleep 0.127
      end
    end
  #end
 end
end
end

class NewClass
  def initialize (param)
  end
end

with_fx :sound_out, output: 3, amp: 0 do
  live_loop :beat do
    sync :timer

  sample :elec_hollow_kick, amp: 0.5

  #sleep 0.25
  end
end

with_fx :sound_out, output: 4, amp: 0 do
  live_loop :beat01 do
  sync :timer
  use_random_seed 6124
  density 2 do

  4.times do
    sample "tabla_ghe", pick, amp: 0.5
    sleep [0.25,0.75].choose
  end
  end
  end
end

#live_loop :beat04 do
#  use_synth :pulse
#
#  2.times do
#    play [28,29,30,31,32].pick, amp: 1
#    sleep 0.25
#  end
#end
