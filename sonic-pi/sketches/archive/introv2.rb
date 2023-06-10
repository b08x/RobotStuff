live_loop :clock do
  cue :clock

  use_bpm 90
  play :c1, attack: 0.5, release: 0.5, amp: 0
  sleep 1

end

#low 0 - 250Hz | c0(12) - c4(60)
with_fx :sound_out_stereo, output: 1, amp: 0 do

#load_samples RIB_JAZZ_SAMPS, "Classic-808"

  live_loop :beat01, delay: 24 do
    sync :clock

    2.times do
      sample DRUM_KITS, "Classic-808_Kick_long", attack: 0.5, decay: 0.25, sustain: 0.75, release: 0.5
      sleep 2
    end

    sleep 4

  end #end of loop beat01

  live_loop :heartbeat, delay: 34 do

    sync :clock


    with_fx :band_eq, freq: 44, res: 0.1, db: 2 do
      sample :bd_808, pre_amp: 2, lpf: 40, rate: 1.1 if spread(1,4).tick
      with_fx :ring_mod, freq: 34, freq_slide: 2 do |f|
        control f, freq: 32
        sample :bd_808, pre_amp: 2, lpf: 40, rate: 1.1 if spread(2,7).look
      end

    end

    sleep 3.75

  end #end of loop heartbeat



end #end of sound out 1

#mid_low 250Hz - 1000Hz | c4(60) - c6(84)
with_fx :sound_out_stereo, output: 3, amp: 0 do



  # HISS


  sleep 16

  with_fx :panslicer, smooth_up: 0.8, smooth_down: 0.8 do

    with_fx :rhpf, cutoff: 80 do
      with_fx :level, amp: 0.5 do
        with_fx :reverb, mix: 0.2, room: 1 do
            sample SAMPLES, "01hellofriend", start: 0, finish: 0.125, rate: 0.95
        end
      end
    end

  ##################

    live_loop :hello do
      #sync :clock
      12.times do
        with_fx :level, amp: 0.5 do
            with_fx :pitch_shift, pitch: 0 do |pitch|
                control pitch, pitch_slide: 0.5, pitch: rrand(12,-12)

                with_fx :rlpf, cutoff: 60 do
                  with_fx :echo, decay: 1.5, phase: 0.50 do
                    with_fx :ring_mod, freq: 48 do |ring|
                      control ring, freq_slide: 0.25, freq: rrand(30,36)
                      sample :ambi_glass_hum, attack: 1, decay: 0.5, release: 1.5, rate: -1, amp: 0.25
                      sleep 2
                    end
                  end
                end
            end
        end
      end
    #stop
    end

    sleep 8

    with_fx :reverb, mix: 0.2, room: 1 do
      with_fx :echo, mix: 0.6, phase: 0.55, decay: 6 do | fx_echo |
        sample SAMPLES, "01hellofriend", start: 0.155, finish: 0.25, amp: 0.5
      end
    end

  end #end of panslicer fx

reset
sample_free_all

end #end of sound_out 3


#mid_high 1000Hz - 4186Hz | c6(84) - c8(108)
with_fx :sound_out_stereo, output: 5, amp: 0 do

  live_loop :overture do
    #sync :clock
    2.times do
      with_fx :pan, pan: -0.8, pan_slide: 10 do |p|
        control p, pan: 0.8
        sample SAMPLES, "0001SummerOverturekronos", start: 0, finish: 0.052, attack: 2.5, release: 1, amp: 0.5, hpf: 84, hpf_attack: 2
      end
      sleep 8
    end


  end #end of loop overture


end #end of soundout 5

#high 4186Hz - 1250Hz |c8(108) - g9(127)
with_fx :sound_out_stereo, output: 7, amp: 0 do
end #end of sound_out 7
