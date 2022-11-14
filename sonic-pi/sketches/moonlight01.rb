use_bpm 45

comment do
  at bar(0) do
    play 38
  end
  
  at bar(1) do
    play 48
  end
end

use_midi_defaults channel: 1, port: "midi_through_midi_through_port-0_14_0"

define :arp_to_midi do |prog, tonic, mode=:major, pattern=[0, 1, 2, 3], reps=2|
  sc = scale(tonic, mode, num_octaves: 4)
  prog.each do |deg|
    puts "prog", prog
    reps.times do
      
      midi sc[deg-1] - 12, sustain: 0.9
      
      t = 1.0 / pattern.length
      pattern.each do |i|
        n = sc[deg - 1 + 2*i + (i+1) / 4]
        #puts "n", n
        midi n, sustain: 1.5 * t
        
        sleep t
      end
    end
  end
end
live_loop :voice01 do
  use_synth_defaults sub_amp: 2, cutoff: 80, attack: 0.2
  # e.g. arpeggiate [4,2,3], :d3, :major, [0,1,2,3,4], 4
  with_fx :echo, decay: 0.75, phase: 2, mix: 0.3 do
    with_synth :subpulse do
      arpeggiate [1,5,2,1], :cs3, :blues_minor, [1,2], 1
    end
  end
end

live_loop :voice02 do
  
  sync :voice01
  #e.g. arpeggiate [4,2,3], :d3, :major, [0,1,2,3,4], 4
  arpeggiate [1,5,2,1], :b4, :major, [1,2,2], 2
  sleep 4
end

with_fx :sound_out, output: 3, amp: 0 do
  live_loop :boom01 do
    sync :voice01
    with_fx :level, amp: 0.8 do
      with_fx :lpf, cutoff: 50 do
        if one_in(2)
          2.times do
            sample :bd_boom, attack: 0.125, rate: 1, rpitch: 2
            sleep 0.25
          end
        else
          sample :bd_boom, attack: 0.5, rate: 1, rpitch: 2
        end
      end
    end
  end
end