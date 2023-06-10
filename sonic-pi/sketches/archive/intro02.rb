live_loop :drums do
  use_bpm 120
  #               1 e & a  2 e & a  3 e & a  4 e & a
  cymbals = bools(0,0,0,0, 0,1,0,1, 0,0,0,0, 0,1,0,0)
  hard    = bools(0,1,0,1, 1,0,0,0, 0,1,0,0, 1,0,0,0)
  soft    = bools(0,0,1,0, 0,0,0,1, 0,0,0,1, 0,0,0,1)
  kick    = bools(1,0,1,0, 1,1,1,0, 0,0,1,0, 0,1,0,0)

  with_fx :reverb, room: 0.4, damp: 0.1, amp: 1.5 do
    16.times do
      tick
      if cymbals.look then
        with_fx :sound_out, output: 4, amp: 0 do
          with_fx :ring_mod, freq: 82 do
              sample :drum_cymbal_open, attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3
          end


        end
      else
        with_fx :sound_out, output: 4, amp: 0 do
          sample :drum_cymbal_closed, amp: 0.5
        end
      end
      with_fx :sound_out, output: 2, amp: 0 do
        sample :drum_snare_hard, on: hard.look
        sample :drum_snare_soft, on: soft.look
      end
      with_fx :sound_out, output: 1, amp: 0 do
        sample :drum_heavy_kick, on: kick.look
      end

      sleep 0.25
    end
  end


end
