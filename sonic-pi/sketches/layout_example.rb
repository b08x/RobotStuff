use_bpm 52
#use_debug false
use_synth :piano
in_thread do #:CCpiano
  12.times do
    use_synth_defaults sustain: 0.75
    8.times do
      play :A3
      sleep 0.25
      play :E4
      sleep 0.25
    end
    8.times do
      play :Gs3
      sleep 0.25
      play :E4
      sleep 0.25
    end
    8.times do
      play :Fs3
      sleep 0.25
      play :D4
      sleep 0.25
    end
    8.times do
      play :A3
      sleep 0.25
      play :E4
      sleep 0.25
    end
    puts 'has done:', tick + 1, 'progressions'
  end
end



in_thread do
  define :basschords do
    use_synth :sine
    detune = 0.05
    use_synth_defaults sustain: 2, attack: 0.1, release: 0.1, amp: 0.3
    2.times do
      #A major chord
      play :A2
      play :A2 + detune
      play :E3
      play :E3 + detune
      sleep 2
    end
    2.times do
      #E major chord
      play :Gs2
      play :Gs2 + detune
      play :E3
      play :E3 + detune
      sleep 2
    end
    2.times do
      #D major chord
      play :Fs2
      play :Fs2 + detune
      play :D3
      play :D3 + detune
      sleep 2
    end
    2.times do
      #A major chord
      play :A2
      play :A2 + detune
      play :E3
      play :E3 + detune
      sleep 2
    end
  end
  sleep 1
  sleep 1
  basschords
  sleep 1
  sleep 1
  basschords
  basschords
  sleep 1
  basschords
  basschords
  basschords
  sleep 1
end


in_thread do
  define :violinchords do
    use_synth :blade
    detune = 0.05
    use_synth_defaults sustain: 1, attack: 0.25, release: 0.75, amp: 0.15
    2.times do
      #A major chord
      play :A4
      play :A4 + detune
      play :E5
      play :E5 + detune
      sleep 2
    end
    2.times do
      #E major chord
      play :Gs4
      play :Gs4 + detune
      play :E5
      play :E5 + detune
      sleep 2
    end
    2.times do
      #D major chord
      play :Fs4
      play :Fs4 + detune
      play :D5
      play :D5 + detune
      sleep 2
    end
    2.times do
      #A major chord
      play :A4
      play :A4 + detune
      play :E5
      play :E5 + detune
      sleep 2
    end
  end
  sleep 16
  sleep 16
  violinchords
  sleep 16
  sleep 16
  violinchords
  violinchords
  sleep 16
  violinchords
  violinchords
  violinchords
  sleep 16
end
