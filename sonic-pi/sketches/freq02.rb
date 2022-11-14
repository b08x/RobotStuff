set_mixer_control! hpf: 21

#for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
#the way it is now, dont fuck with it. (guitarix isn't necessary for this)
with_fx :eq, low_shelf: -1, low_shelf_note: 31, low_shelf_slope: 0.9, low: -0.5, low_note: 42, low_q: 0.8,
             mid: 0, mid_note: 66, mid_q: 0.8,
             high: 0.5, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 114, high_shelf_slope: 0.5, pre_amp: 1 do

               with_fx :compressor, pre_amp: 1, threshold: 0.09, clamp_time: 0.125, slope_above: 0.1 do

                  with_fx :echo, decay: 4, phase: 0.5, pre_mix: 0.125 do


                    with_fx :reverb, room: 0.5 do

                      with_fx :flanger, phase: 4, feedback: 0.1, decay: 2, wave: 4, depth: 7, pre_mix: 0.5 do

                       with_fx :distortion, distort: 0.6, mix: 0.6 do

                         with_fx :tanh, pre_amp: 1, pre_mix: 0.5, krunch: 4 do

                          live_audio :git01, input: 1

                         end

                       end

                     end

                    end

                end
             end
end
