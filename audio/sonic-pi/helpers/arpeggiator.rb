def midiarpeggiate(progressions, tonic, mode=:major, pattern=[0, 1, 2, 3], repititions=2, vel)
  scale_notes = scale(tonic, mode, num_octaves: 4)
  progressions.each do |deg|
    puts "prog", progressions
    repititions.times do
      h = scale_notes[deg-1] - 12
      puts "note1: #{h}"
      midi h, sustain: 0.9, velocity: vel
      t = 1.0 / pattern.length
      pattern.each do |i|
        n = scale_notes[deg - 1 + 2*i + (i+1) / 4]
        puts "note2: #{n}"
        midi n, sustain: 1.5 * t, velocity: vel
        sleep t
      end
    end
  end
end

def arpeggiate(prog, tonic, mode=:major, pattern=[0, 1, 2, 3], reps=2)
  sc = scale(tonic, mode, num_octaves: 4)
  prog.each do |deg|
    puts "prog", prog
    reps.times do
      with_synth :beep do
        play sc[deg-1] - 12, sustain: 0.9, amp: 1.0
      end
      t = 1.0 / pattern.length
      pattern.each do |i|
        n = sc[deg - 1 + 2*i + (i+1) / 4]
        #puts "n", n
        with_synth :fm do
          play n, sustain: 1.5 * t, amp: 0.8
          sleep t
        end
      end
    end
  end
end
