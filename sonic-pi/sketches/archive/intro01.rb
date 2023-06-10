
run_file "/home/b08x/workspace/projects/seshmon/lib/drums/euclid_distrib_defs.rb"
# this ended up being a neat effect after practing with fx
live_loop :hh do

    with_fx :eq, low_shelf: -0.8, low_shelf_note: 40, low_shelf_slope: 1, low: -0.8, low_note: 40, low_q: 0.8,
                 mid: 0.2, mid_note: 66, mid_q: 0.8,
                 high_shelf: -0.2, high_shelf_note: 124, high_shelf_slope: 1, high: 0, high_note: 105, high_q: 0.6 do


            with_fx :pan, pan: [-0.8,0.8].choose do
              with_fx :band_eq, freq: 109, db: -1.5 do
                with_fx :hpf, cutoff: 35, res: 0.5 do
                  with_fx :ixi_techno, cutoff_min: 70, cutoff_max: 90 do
                    with_fx :echo, decay: 5, phase: 0.5 do
                      with_fx :panslicer, smooth: 0.1 do
                        with_fx :slicer, wave: 3, smooth: 0.25 do
                          with_fx :reverb, mix: 0.2, room: 1 do
                            with_fx :rlpf, cutoff: 115 do
                                play_hydro_seq(distribute(7, 16), "chh_1")
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
      end



end

################




live_loop :fuckificannameathing do

    with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0.5, low_note: 47, low_q: 0.8, mid: -0.75, mid_note: 80, mid_q: 0.8, high: 0, high_note: 105, high_q: 0.6, high_shelf: 0.5, high_shelf_note: 105, high_shelf_slope: 0.5, pre_amp: 1 do

      panner = range(-0.8,0.8, step: 0.125, inclusive: true)

      with_fx :pan, pan: panner.tick do
        with_fx :ixi_techno, cutoff_min: 50, cutoff_max: 85, pre_mix: 0.9 do
            with_fx :echo, decay: 0.125 do
              with_fx :slicer, wave: 1, pulse_width: 0.125, pre_mix: 0.8 do
                with_fx :lpf, cutoff: 85 do
                  play_hydro_seq(distribute(5, 16).to_a.rotate(4), "S-177 Reggae 4")
                end
              end
            end
        end
      end

  end
end




  #wtih rlpf between 30-45 will produce deep thumps
  #45 and and above and you start to get more rubber bouncy ball like
  #sync :heartbeat

    # 2.times do
    #   sample HYDRO_KITS, "808_Kick_long"
    #   sleep 0.25
    # end



  live_loop :up do

      with_fx :pan, pan: rrand(-0.6,0.6) do
        with_fx :echo, phase: 1.5, decay: 0.25 do
          with_fx :band_eq, freq: 62, db: -20, res: 0.4 do
            with_fx :rhpf, cutoff: 48 do

              with_fx :ixi_techno, cutoff_min: 50, cutoff_max: 78 do
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
