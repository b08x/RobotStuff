use_synth :dpulse

with_fx :sound_out, output: 3, amp: 0 do
  
  live_loop :pnoize do
    use_random_seed 3450
    tick
    
    note = (chord :d2, :minor).pick
    puts note
    #notes = (octs note, 3)
  play note, attack: 0.25, sustain: 0.5, decay: 0.5, res: 0.4, detune1: 8, detune2: 24, room: 20, ring: 0.3, noise: 1, amp: 0.5
  sleep 1
end

end

