


  with_fx :band_eq, freq: 38, db: -6, res: 0.4 do
    with_fx :rlpf, cutoff: 112, res: 0.3 do
      with_fx :rhpf, cutoff: 52, res: 0.1 do
        with_fx :echo, mix: 0.2, phase: 0.5, decay: 4 do
          with_fx :flanger, delay: 1 do
            with_fx :distortion, mix: 0.5, distort: 0.6, pre_amp: 0.5 do
              live_audio :guitar01, input: 1
            end
          end
        end
      end
    end
  end





#set_mixer_control! hpf: 39
#set_volume! 1


#set_recording_bit_depth! 32

#alsa master 72 capture 42



#with_fx :eq, low_shelf: 0, low_shelf_note: 38, low_shelf_slope: 0.6, low: 0, low_note: 57, low_q: 0.7,
#             mid: 0, mid_note: 68, mid_q: 0.6,
#             high: 0, high_note: 105, high_q: 0.6,
#             high_shelf: 0, high_shelf_note: 124, high_shelf_slope: 0.5, pre_amp: 4 do




# with_fx :echo, max_phase: 8, phase_slide: 4, decay: 2 do |e|
#   control e, phase: 6



  # with_fx :rlpf, cutoff: 107 do
  #
  #   with_fx :flanger, delay: 3, depth: 5, wave: 3 do|ixi|
  #     control ixi, feedback: 0.5, feedback_slide: 4
  #
  #     with_fx :panslicer, smooth_up: 0.2, smooth_down: 0.2, pan_min: -0.5, pan_max: 0.5, wave: 1, pulse_width_slide: 8 do |p|
  #
  #
  #         with_fx :tremolo, phase: 3, res: 0.4 do
  #           with_fx :mono, pan: 0 do
  #             live_audio :freq_l, stereo: true, input: 1
  #           end
  #        end
  #
  #     end
  #
  #   end
  # end
#end



#end #end of eq
