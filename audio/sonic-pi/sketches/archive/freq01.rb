# set_mixer_control! hpf: 21
#
# #for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
# #the way it is now, dont fuck with it. (guitarix isn't necessary for this)
# with_fx :eq, low_shelf: -1, low_shelf_note: 31, low_shelf_slope: 0.9, low: -0.5, low_note: 42, low_q: 0.8,
#              mid: 0.5, mid_note: 70, mid_q: 0.8,
#              high: 0, high_note: 105, high_q: 0.6,
#              high_shelf: 0.5, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 5 do
#
#
#
#                     live_audio :git01, stereo: false, input: 1
#
#
#
#
#       #with_fx :record, buffer: buffer[:gitbuff,8] do
#       #with_fx :pan, pan: rrand(-0.8,0.8) do
#          #with_fx :echo, decay: 0.8, phase: 0.8, pre_mix: 0.20 do
#           #  with_fx :flanger, phase: 4, feedback: 0.1, decay: 2, wave: 4, depth: 7, pre_mix: 0.5 do
#           #   with_fx :distortion, distort: 0.2, mix: 0.5 do
#           #     with_fx :reverb, room: 0.6, mix: 0.8 do
#           #      live_audio :git01, stereo: false, input: 1
#           #     end
#           #   end
#           # end
#          #end
#        #end
#       #end
#
#     # with_fx :hpf, cutoff: 36 do
#     #   with_fx :whammy, transpose: -12 do
#     #     with_fx :distortion, distort: 0.2 do
#     #       with_fx :reverb, room: 1 do
#     #         live_audio :gitar01, input: 1
#     #       end
#     #     end
#     #   end
#     # end
#
#     # with_fx :rlpf, cutoff: 72, res: 0.3 do
#     #   with_fx :octaver, super_amp: 0.7, sub_amp: 0.8, subsub_amp: 0.5, mix: 0.5 do
#     #     with_fx :band_eq, freq: 42, db: 6, res: 0.5 do
#     #         live_audio :guitar01, input: 1
#     #     end
#     #   end
#     # end
#
# end #end of eq fx
#
# # at 8 do #stop the live audio feed when finished recording
# #   live_audio :git01,:stop
# # end
# # #press stop to finish the program
# # at 10 do
# #
# #   live_loop :gitbuff do
# #     if one_in(3)
# #       freq = 84
# #     else
# #       freq = 48
# #     end
# #
# #     with_fx :pan, pan: rrand(-1,1) do
# #       #with_fx :slicer, probability: 0.8, smooth_up: 0.8, smooth_down: 0.8, wave: 1 do
# #
# #       with_fx :echo, phase: 0.5, decay: 1.45 do
# #         with_fx :reverb, room: 1 do
# #           with_fx :ring_mod, freq: freq, freq_slide: 4 do |f|
# #             control f, freq: rrand(68,78)
# #               sample buffer[:gitbuff,8], beat_stretch: 8, cutoff: rrand(80,110)
# #             end
# #           end
# #         end
# #       #end
# #       end
# #
# #
# #     sleep 8
# #
# #   end
# #
# # end



###-----------------
with_fx :sound_out_stereo, output: 9, amp: 1 do

  #stuff that goes out 3,4 is sent to freqtweak which comes in 9,10

  live_audio :gitar, input: 1, stereo: false

end


# at 0 do
#   @freqin = in_thread do
#     with_fx :record, buffer: buffer(:gitbuff,16) do
#
#
#
#       #with_fx :ring_mod, freq: 80, freq_slide: 1 do |f|
#
#       # with_fx :ixi_techno, cutoff_min: 60, cutoff_max: 90, phase: 0.25, res: 0.8 do
#       #  control f, freq: 90
       live_audio :freqt, input: 9, stereo: true
#       #end
#       #end
#
#     end
#   end
# end

# at 8 do #stop the live audio feed when finished recording
# at 16 do
#   live_audio :freqt,:stop
#   live_audio :gitar,:stop
#   @freqin.kill
#   sleep 8
#
#
#
#
#   #load_samples "/home/b08x/.sonic-pi/store/default/cached_samples"
#
#   #then do stuff with the `sample buffer[:gitbuff,8]`
#   live_loop :freqing do
#
#
#     sample buffer(:gitbuff,16), attack: 1, release: 0.5, start: 0.1, finish: 1
#
#
#     sleep 8
#
#
#   end
# end


#live_audio :yosh, input: 3, stereo: true

#live_audio :qlsamp, input: 5, stereo: true

#live_audio :mixxx, input: 7, stereo: true
