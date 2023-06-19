set_mixer_control! hpf: 21


use_bpm 90

# with_fx :level, amp: 0.8 do
#
#   live_loop :drumloop do
#     #stop
#
#     with_fx :band_eq, freq: 59, res: 0.4, db: 6 do
#
#
#     with_fx :reverb, room: 0.5, damp: 0.75, mix: 0.5 do
#
#       with_fx :wobble, pre_mix: 0.8, phase: 0.75, wave: 3, filter: 0, smooth_up: 0.8, smooth_down: 0.8 do
#         with_fx :pitch_shift, pitch: -2 do
#           sample :loop_industrial, beat_stretch: 4, start: 0, finish: 0.125
#           sleep 0.5
#         end
#       end
#
#       sample :loop_breakbeat, beat_stretch: 4, start: 0, finish: 0.125
#       sleep 0.5
#
#
#       with_fx :rlpf, cutoff: 70, res: 0.3, pre_mix: 0.75 do
#         sample :loop_breakbeat, beat_stretch: 4, start: 0.5, finish: 0.75
#       end
#
#       sleep 1
#
#
#       with_fx :pan, pan: -1, pan_slide: 0.25 do |x|
#         control x, pan: 1
#         sample :loop_industrial, beat_stretch: 4, start: 0.25, finish: 0.5
#       end
#       sleep 1
#
#
#
#       if one_in(12)
#         with_fx :echo, pre_mix: 0.8, decay: 0.75, phase: 0.5 do
#           sample :loop_compus, beat_stretch: 4, rate: 0.5, start: 0.75, finish: 0.875, pan: -0.8, pan_slide: 0.25, amp: 0.45 do |p|
#             control p, pan: 0.8
#             sleep 0.5
#           end
#         end
#       end
#
#       sample :loop_breakbeat, beat_stretch: 4, start: 0.75, finish: 0.875
#       sleep 0.5
#
#       with_fx :ixi_techno, cutoff_max: 80, cutoff_min: 40, phase: 0.25, res: 0.8, pre_mix: 0.8 do
#         sample :loop_industrial, beat_stretch: 4, start: 0.25, finish: 0.375
#         sleep 0.5
#       end
#
#
#     end
#
#   end
#
#
# end
#
#
#
# end #end of level fx
#
#
#
#
#




with_fx :level, amp: 0.6 do

  live_loop :basshit do
    use_random_seed 6010
    #sync :drumloop
    4.times do
      sample PERCS, "kick", pick, attack: 0.005
      sleep Q
    end

    2.times do
      sample PERCS, "kick", pick, attack: 0.005
      sleep S
    end

  end


    live_loop :slicedrop do

      sync :basshit

      with_fx :pan, pan: rrand(-1,1) do


        with_fx :slicer, probability: 0.8, smooth_down: 0.2 do

          play :a4, attack: 2, sustain: 1, release: 4, pitch: 0, slide: 4 do |x|

            control x, pitch: -36, note: :a4
          end

        end

      end

      sleep 8

    end

  end
