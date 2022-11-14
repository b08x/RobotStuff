use_midi_defaults velocity: 100

live_loop :nb_bass do
  cue :nb_bass
  midi_cc 70, 2
  use_random_seed 64647
  notes = scale(:d2, :aeolian).reverse

  4.times do
    midi notes.tick, channel: 7
    if one_in(2)
      sleep 0.5
    else
      sleep 0.25
    end
  end
end

at bar(12) do
  live_loop :nb_guitar do
    midi_cc 70, 2
    # stop
    use_bpm 30
    notes = scale(:d3, :aeolian).reverse

    puts 'this bar'
    2.times do
      4.times do
        midi (octs :a2, 2).tick, channel: 2
        sleep 0.125
      end
    end
    puts 'next bar'
    4.times do
      midi notes.tick, channel: 3, sustain: 0.1
      sleep 0.25
    end
  end

  live_loop :beat01 do
    2.times do
      sample :bd_haus, attack: 0.125, release: 0.5, amp: 1.8
      sleep 4
    end
  end
end
