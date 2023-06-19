use_debug true
use_random_seed Time.new.usec
#use_synth :pluck

live_loop :freq do
  play 78.10, sustain: 30, pan: rrand(-1,1)
  sleep 1
end

i = 0
live_loop :circle01 do
  use_synth :piano
 2.times do
   print (chord 48 + i % 12,:major)
   print i
   play_pattern_timed (chord 48 + i % 12,:major), 0.01, sustain: 0.5, release: 0.5
   puts i / 7, note_info(48 + i % 12)
   sleep 1
 end
 i = i + (rrand_i(0,2) -1) * 7
end
