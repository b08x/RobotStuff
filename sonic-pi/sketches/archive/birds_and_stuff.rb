set_volume! 0.86
set_mixer_control! hpf: 21

# use_random_seed Time.new.usec # Change the sequence of random numbers in milliseconds
# live_loop :realbirds do
#   f1 = hz_to_midi (rrand(4000, 5000)) # Give the range of the treble side frequency of the song in Hz and use it as the midi number.
#   f2 = hz_to_midi (rrand(1000, 3000)) # Gives the bass frequency range of the twitter in Hz to the midi number
#   s = play f1, attack: 0.02, sustain: 0.2, release: 0,
#     note_slide: 0.1, pan_slide: 0.1, amp: rrand(0.1,2), amp_slide: 0.1 # Sound the treble side
#   sleep 0.05 / 1.0125 # Stretch very short
#   control s, note: f2 / 1.12, pan: rrand(-1,1), amp: rrand(0.1,2) # Sound the bass side
#   sleep 0.05 / 1.0125 # Stretch very short
#   control s, note: f1 / 1.1 , pan: rrand(-1,1), amp: rrand(0.1,2) # Sound the treble side
#   sleep rrand(0.1,1)# Make the twitter time interval a little longer
# end

live_loop :iwato do
  use_random_seed 23241

  notes = scale :e3, :iwato

      with_fx :reverb, room: 0.1, damp: 0.2 do
        4.times do
          use_synth :piano
          play notes.choose, sustain: 0.5, amp: 1.5

          sleep 0.45

        end

        2.times do
          use_synth :pluck
          play notes.tick, release: 1, amp: 1.5
          sleep 0.125
        end

      end
    end
