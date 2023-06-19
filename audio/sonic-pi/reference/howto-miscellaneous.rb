# Little snippets and solutions for various things
# howto-miscellaneous.rb

# Off-Beat pattens with hihat: spread + rotate

live_loop :hat do
  if spread(2, 4).rotate(1).tick
    sample :drum_cymbal_closed, finish: 0.125
  end
  sleep 0.5
end

# Modulo for regular events

# syncoping with kick
# solution 1
live_loop :kick1 do
  cnt = tick % 4 # count 0..3
  puts "#{cnt}"
  sample :bd_ada, amp: 1.5, attack_level: 3
  at (ring 0.75) do # a syncope every fourth beat
    sample :bd_ada, amp: 1.5, attack_level: 3 if cnt == 3
  end
  sleep 1
end

# solution 2
live_loop :kick2 do
  #stop
  at (ring 0,1,2,3) do
    sample :bd_ada, amp: 1.5
  end
  at (ring 0.75, 2.50) do
    2.times do
      sample :bd_ada, amp: 1.5
      sleep [0.125,0.25].tick
    end
  end
  sleep 4
end

# change note
live_loop :bass do
  use_synth :fm
  use_synth_defaults release: 0.5, depth: 1, divisor: 1
  cnt = tick % 8
  if cnt < 1
    puts "#{cnt}"
    n = :e2
  elsif cnt < 2
    puts "#{cnt}"
    n = :a2
  elsif cnt < 3
    puts "#{cnt}"
    n = :e3
  end
  play n - 12, attack: 0.125/2, sustain: 0.5/2, decay: 0.25/2, release: 0.125/2
  sleep 0.5
end
