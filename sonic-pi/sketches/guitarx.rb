set_mixer_control! hpf: 21

def bassline01
  use_synth :fm

    with_fx :band_eq, freq: 35, db: -0.1, res: 0.5 do

      2.times do
        with_fx :rlpf, cutoff: 70 do
          play_pattern_timed [:e2, :g2, :e2, :b1], [1], attack: 0.75, release: 0.25
        end

        with_fx :rlpf, cutoff: 70 do
          play_pattern_timed [:e2, :g2, :fs2], [1, 1, 2], attack: 0.75, release: 0.25
        end

        with_fx :rlpf, cutoff: 70 do
          play_pattern_timed [:e2, :g2, :fs2, :b1], [1], attack: 0.75, release: 0.25
        end
      end

    end
end


with_fx :eq, low_shelf: -0.8, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 28, low_q: 0.8,
             mid: 0, mid_note: 84, mid_q: 0.8,
             high: 0, high_note: 106, high_q: 0.5,
             high_shelf: -1, high_shelf_note: 112, high_shelf_slope: 1, pre_amp: 1 do



with_fx :echo, max_phase: 6, phase: 0.125, decay: 0.25, pre_mix: 0.2 do

with_fx :panslicer, smooth_up: 0.8, smooth_down: 0.8, wave: 1, probability: 0.8, prob_pos: 0.5, pulse_width: 0.8, pan_min: -0.1, pan_max: 0.1 do

with_fx :wobble, cutoff_min: 40, cutoff_max: 50, phase: 3, res: 0.65, wave: 1, invert_wave: 0, pulse_width: 0.75, smooth_up: 0.8, smooth_down: 0.8, mix: 0.60, amp: 0.85 do




with_fx :mono do

  live_loop :firstpart do

    4.times do
      play_pattern_timed [:gs2, :cs3, :e3], [0.5], attack: 0.25, release: 0.25
    end

    2.times do
      play_pattern_timed [:a2, :cs3, :e3], [0.5], attack: 0.25, release: 0.25
    end


    bassline01


    2.times do
      play_pattern_timed [:a2, :d3, :fs3], [0.5], attack: 0.25, release: 0.25
    end


   2.times do
      play_pattern_timed [:gs2, :c3, :fs3], [0.5], attack: 0.25, release: 0.25
    end
  end




end #mono

end #wobble

end #panslicer

end #echo

end #end of eq fx
