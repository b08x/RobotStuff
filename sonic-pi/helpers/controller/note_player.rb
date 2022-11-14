live_loop :seq1 do
  16.times do
    tick
    print get[:seq1].ring.look
    play 48, on: get[:seq1].ring.look
    #play 48, on: @seq2.ring.look
    sleep 0.25
  end
end

live_loop :seq2 do
  sync :seq1
  16.times do
    tick
    play 60, on: get[:seq4].ring.look
    #play 48, on: @seq2.ring.look
    sleep 0.25
  end
end


live_loop :sequence_number_1 do

  use_real_time
  # this will be either 1 or 0

  seq, index, var, value = sync "/osc*/*/*"

  print seq
  print index
  print var
  print value

end
