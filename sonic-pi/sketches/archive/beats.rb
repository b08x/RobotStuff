live_loop :vbd do
  #cue :fuck
  with_fx :level, amp: 0.5 do
      with_fx :reverb, mix: 0.3, room: 1 do
        with_fx :rhpf, cutoff: 33, res: 0.6 do
          with_fx :lpf, cutoff: 75 do
            with_fx :band_eq, freq: 35, db: -0.8, res: 0.8 do
              play_hydro_seq(distribute(9, 16), "EE_Kick_Hard_1")
            end
          end
        end
      end
    end
end

live_loop :up do

    with_fx :pan, pan: rrand(-0.6,0.6) do
      with_fx :echo, phase: 1.5, decay: 0.25 do
        with_fx :band_eq, freq: 62, db: -20, res: 0.4 do
          with_fx :rhpf, cutoff: 48 do

            with_fx :ixi_techno, cutoff_min: 60, cutoff_max: 65 do
              with_fx :ring_mod, freq: 78 do |ring|
                control ring, freq_slide: 2, freq: 32
                with_synth :beep do
                  play_pattern_timed [:e2, :r, :g2, :gs2, :c3, :g2, :fs2, :e2], [0.25], amp: 0.5, release: 0.25
                end
              end
            end
          end
        end

    end
  end

end
