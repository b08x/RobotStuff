# Welcome to Sonic Pi
# Count every beat
live_loop :bar do
  cue :tick
  sleep 1
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tick
  cue :every_two_bars
  sample :elec_blip, amp: 0.5, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.5, rate: 2.0
  sleep 16
end

define :arpeggiate do |prog, tonic, mode=:major, pattern=[0, 1, 2, 3], reps=2|
  sc = scale(tonic, mode, num_octaves: 4)
  prog.each do |deg|
    puts "prog", prog
    reps.times do
      with_synth :pluck do
        play sc[deg-1] - 12, sustain: 0.9, amp: 2
      end
      t = 1.0 / pattern.length
      pattern.each do |i|
        n = sc[deg - 1 + 2*i + (i+1) / 4]
        #puts "n", n
        play n, sustain: 1.5 * t, amp: 0.8
        sleep t
      end
    end
  end
end


live_loop :bassline do
  # stop
  # sync :tick
  with_fx :band_eq, amp: 3 do
    #with_fx :lpf, cutoff: 47 do
    play_pattern_timed [:c2, :e2, :f2, :g2, :f2, :e2, :f2, :g2, :f2, :f2], [0.25, 0.25, 0.25, 1.5, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25], attack: 0, release: 0.2
    #end
  end

  sleep 4
end

comment do
  live_loop :melod01 do
    #sync :two_bars
    2.times { arpeggiate [4,2,4,4,2,1,6], :c3, :ionian}
  end
end



live_loop :melod02 do
  # sync :tick
  use_synth :piano
  arpeggiate [2,4,1], :d3, :major
  #sleep 1
end

live_loop :tab do
  # sync :tick
  use_random_seed 4568
  16.times do
    sample "tabla_", pick, amp: 1.8
    sleep 0.5
  end
end
