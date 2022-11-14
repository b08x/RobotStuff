# with_fx :sound_out_stereo, output: 3, amp: 0 do
#
#
#   with_fx :band_eq, freq: 38, db: -6, res: 0.4 do
#     with_fx :rlpf, cutoff: 112, res: 0.3 do
#       with_fx :rhpf, cutoff: 52, res: 0.1 do
#         with_fx :echo, mix: 0.2, phase: 0.5, decay: 4 do
#           with_fx :flanger, delay: 1 do
#             with_fx :distortion, mix: 0.5, distort: 0.6, pre_amp: 0.5 do
#               live_audio :guitar01, input: 1
#             end
#           end
#         end
#       end
#     end
#   end
#
#
#
# end

set_mixer_control! hpf: 39

#set_recording_bit_depth! 32

#alsa master 72 capture 42

with_fx :eq, low_shelf: -0.7, low_shelf_note: 38, low_shelf_slope: 0.6, low: 0.5, low_note: 57, low_q: 0.7,
             mid: -0.5, mid_note: 68, mid_q: 0.6,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: -0.2, high_shelf_note: 124, high_shelf_slope: 0.5, pre_amp: 6 do

  with_fx :reverb, mix: 0.5, damp: 0.4, room: 0.6 do |reverb|

            with_fx :pan, pan: -0.8, pan_slide: 20 do |pan|
              control pan, pan: -0.8
              with_fx :panslicer, pan_min: -1, pan_max: -0.1, smooth_up: 0.8, smooth_down: 0.8 do
                live_audio :freq_l, stereo: false, input: 1
              end

            end

            with_fx :pan, pan: 0.8 , pan_slide: 20 do |pan|
                control pan, pan: 0.8

              with_fx :echo, phase: 4, decay: 6, phase_slide: 4 do |e|
                  control e, phase: 0.50


                  #with_fx :ring_mod, mix: 0.4, freq: 72, freq_slide: 0.5, mod_amp_slide: 8 do |ring|
                    #control ring, freq: 48, mod_amp: 0.4
                    with_fx :wobble, mix: 0.4, cutoff_min: 40, cutoff_max: 50, smooth_up: 0.4, smooth_down: 0.4, wave: 1, pulse_width: 0.8 do
                      live_audio :freq_r, stereo: false, input: 2
                    end
                  #end

              end

            end

  end


end
