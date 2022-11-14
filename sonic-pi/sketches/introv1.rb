use_bpm 90

with_fx :sound_out_stereo, output: 1, amp: 0 do

    # HISS
    live_loop :hiss_loop do
      with_fx :slicer, wave: 3, smooth: 0.10 do
        #with_fx :tanh, krunch: 1 do
          with_fx :tremolo do
            #with_fx :gverb, room: 10, spread: 0.5, release: 3 do
              sample :vinyl_hiss, amp: 0.65, rate: 0.5, attack: 3, sustain: 4, sustain_level: 0.8,
                      release: 1, pan: rrand(-0.8, 0.8)
              #sleep sample_duration :vinyl_hiss
              sleep 8
            #end
          end
        #end
      end
    end


end

#------------------------------------------


def sample_slice(dasample, start, finish)

  sample dasample, start: start, finish: finish

end

sample RIB_JAZZ_SAMPS, "01hellofriend"
# hellofriend = File.join(RIB_JAZZ_SAMPS, "01hellofriend.wav")
#
# load_sample hellofriend
#
# sleep 16
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#
# with_fx :rhpf, cutoff: 100 do
#   with_fx :level, amp: 0.45 do
#     with_fx :reverb, mix: 0.2, room: 1 do
#         #sample_slice(hellofriend, 0, 0.125)
#         sample hellofriend, start: 0, finish: 0.125, rate: 0.95
#     end
#   end
# end
#
# end
#
#
# sleep 8
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#
#   with_fx :panslicer, pan_min: -0.92, pan_max: 0.92 do
#     with_fx :rhpf, cutoff: 30 do
#       with_fx :level, amp: 0.25 do
#         with_fx :echo, mix: 0.4, phase: 0.55, decay: 6 do
#           #with_fx :reverb, mix: 0.4, room: 1 do
#               sample_slice(hellofriend, 0.155, 0.25)
#           #end
#         end
#       end
#     end
#   end
#
# end








sleep 16


live_loop :heartbeat do
  cue :heartbeat

  with_fx :sound_out_stereo, output: 7, amp: 0 do

  with_fx :reverb, mix: 0.4, room: 1 do
    2.times do
      with_fx :band_eq, freq: 44, res: 0.1, db: 2 do
        sample :bd_808, pre_amp: 0.45, lpf: 40, rate: 1.1
      end
      sleep 0.5
    end
  end

  end

  sleep 7.5

end





# eggs = File.join(RIB_JAZZ_SAMPS, "donteattheeggs.wav")
#
# load_sample eggs
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#   with_fx :echo, phase: 1, decay: 6 do
#     with_fx :reverb, mix: 0.2, room: 1 do
#       with_fx :level, amp: 0.125 do
#         #sample_slice(eggs, 0.31, 0.40)
#         sample eggs, start: 0.31, finish: 0.40, attack: 1
#       end
#     end
#   end
# end
#
# sleep 2
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#   with_fx :echo, phase: 1, decay: 6 do
#     with_fx :reverb, mix: 0.2, room: 1 do
#       with_fx :level, amp: 0.125 do
#         sample_slice(eggs, 0.435, 0.456)
#       end
#     end
#   end
# end





round_midnight = File.join(SAMPLES, "209RoundMidnight.wav")

load_sample SAMPLES, "209RoundMidnight"

live_loop :midnight do

  with_fx :band_eq, freq: 112, db: 6, res: 0.6 do
    with_fx :level, amp: 3 do
      #sample round_midnight, start: 0.25, finish: 0.268, attack: 2, rate: 1
      with_fx :bitcrusher, cutoff: 40, pre_mix: 0.5 do
        with_fx :lpf, cutoff: 60 do
          sample SAMPLES, "209RoundMidnight", hpf: 45, start: 0.25, finish: 0.2791, attack: 2, release: 0.25, rate: -1
        end
      end
    end
  end

  sleep 8

end

# summer_overture = File.join(RIB_JAZZ_SAMPS, "0001SummerOverturekronos.wav")
#
# load_sample summer_overture
#
# live_loop :overture do
#
#   with_fx :sound_out_stereo, output: 3, amp: 0 do
#     sample summer_overture, start: 0.0, finish: 0.05, attack: 2, amp: 0.5, rate: -1
#     sleep 12
#   end
#
#
# end





# satan = File.join(RIB_JAZZ_SAMPS, "hailsatan.wav")
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#   with_fx :echo, phase: 1, decay: 6 do
#     with_fx :reverb, mix: 0.2, room: 1 do
#         sample_slice(satan, 0, 0.125)
#     end
#   end
# end
#
# sleep 2
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#   #with_fx :echo, phase: 1, decay: 6 do
#     with_fx :reverb, mix: 0.2, room: 1 do
#         sample_slice(satan, 0.135, 0.355)
#     end
#   #end
# end
#
# sleep 2
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#   #with_fx :echo, phase: 1, decay: 6 do
#     with_fx :reverb, mix: 0.2, room: 1 do
#         sample_slice(satan, 0.365, 0.5)
#     end
#   #end
# end
#
# sleep 2
#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
#   #with_fx :echo, phase: 1, decay: 6 do
#     with_fx :reverb, mix: 0.2, room: 1 do
#         sample_slice(satan, 0.88, 0.99)
#     end
#   #end
# end





# live_loop :pulse do
#
#   sync :heartbeat
#
#   with_fx :sound_out_stereo, output: 7, amp: 0 do
#     with_fx :level, amp: 0.75 do
#       with_fx :lpf, cutoff: 40 do
#         play_sample_for_sequence(distribute(9,16), :bd_haus)
#       end
#     end
#   end
#
# end


# live_loop :smario do
#   use_synth :chipbass
#   sync :heartbeat
#
#   with_fx :sound_out_stereo, output: 5, amp: 0 do
#
#     with_fx :slicer, wave: 1, smooth: 0.25 do
#       with_fx :level, amp: 0.125 do
#         with_fx :rlpf, cutoff: 80 do
#           with_fx :distortion, distort: 0.1 do
#             play_pattern_timed([:c3,nil,nil,:g2,nil,nil,:e3,nil,
#                                 nil,:a3,nil,:b3,nil,:Bb3,:a3,nil], [0.25])
#             sleep 16
#           end
#         end
#       end
#     end
#   end
#
# end



live_loop :heyo do
  stop
  sync :heartbeat

  with_fx :sound_out_stereo, output: 7, amp: 0 do

    # with_fx :slicer, smooth: 0.9 do
    #     with_fx :ring_mod, freq: 38 do |ring|
    #       control ring, freq_slide: 1, freq: rrand(38,34)
    #       #synth :sine, note: :d2, attack: 3, release: 1, amp: 0.125
    #       with_fx :level, amp: 0.5 do
    #         with_fx :hpf, cutoff: 60 do
    #           play_sample_for_sequence(distribute(5,16).to_a.rotate(4), :bd_boom)
    #         end
    #       end
    #     end
    # end

    APP_ROOT = "/home/b08x/workspace/projects/seshmon"

    run_file File.join(APP_ROOT, "/lib/bass/wooble.rb")

    with_fx :band_eq, freq: 30, db: -5, res: 0.5 do
      with_fx :ixi_techno, cutoff_min: 20, cutoff_max: 45, phase: 4 do
        with_fx :wobble, wave: 1, res: 0.4 do
          with_fx :level, amp: 0.125 do
            wob(32, 2, 4)
            sleep 4
          end
        end
      end
    end

  end
end
