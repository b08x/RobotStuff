set_mixer_control! hpf: 21

#for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
#the way it is now, dont fuck with it. (guitarix isn't necessary for this)
with_fx :eq, low_shelf: 0.5, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0.5, low_note: 42, low_q: 0.8,
             mid: 0.5, mid_note: 66, mid_q: 0.8,
             high: 0.5, high_note: 105, high_q: 0.6,
             high_shelf: 1, high_shelf_note: 114, high_shelf_slope: 0.5, pre_amp: 1 do



      #with_fx :record, buffer: buffer[:gitbuff,8] do
      #with_fx :pan, pan: rrand(-0.8,0.8) do
         with_fx :echo, decay: 0.8, phase: 0.8, pre_mix: 0.25 do
           with_fx :flanger, phase: 4, feedback: 0.1, decay: 2, wave: 4, depth: 7, pre_mix: 0.5 do
            with_fx :distortion, distort: 0.2, mix: 0.5 do
              with_fx :reverb, room: 1 do
               live_audio :git01, input: 1, stereo: true
              end
            end
          end
         end
       #end
      #end

    # with_fx :hpf, cutoff: 36 do
    #   with_fx :whammy, transpose: -12 do
    #     with_fx :distortion, distort: 0.2 do
    #       with_fx :reverb, room: 1 do
    #         live_audio :gitar01, input: 1
    #       end
    #     end
    #   end
    # end

    # with_fx :rlpf, cutoff: 72, res: 0.3 do
    #   with_fx :octaver, super_amp: 0.7, sub_amp: 0.8, subsub_amp: 0.5, mix: 0.5 do
    #     with_fx :band_eq, freq: 42, db: 6, res: 0.5 do
    #         live_audio :guitar01, input: 1
    #     end
    #   end
    # end

end #end of eq fx

# at 16 do #stop the live audio feed when finished recording
#   live_audio :git01,:stop
# end
# #press stop to finish the program
# at 18 do
#
#   live_loop :gitbuff do
#
#
#
#     sample buffer[:gitbuff,8]
#
#     sleep 8
#
#   end
#
# end
