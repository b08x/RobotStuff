set_mixer_control! hpf: 21

#for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
#the way it is now, dont fuck with it. (guitarix isn't necessary for this)
with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 42, low_q: 0.8,
             mid: 0, mid_note: 70, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 1 do



              #
              #  with_fx :echo, phase: 0.65, decay: 6, pre_mix: 0.9 do
              #  with_fx :reverb, room: 0.8, res: 0.6, damp: 0.4 do
              #
              #
              #
              #     with_fx :level, amp: 1 do
              #       live_audio :yoshu, stereo: true, input: 5
              #     end
              #
              #   end
              #   end
              #
              #
              #
              #   with_fx :echo, phase: 0.125, decay: 8, pre_mix: 0.9 do
              #   with_fx :reverb, room: 0.8, res: 0.6, damp: 0.4 do
              #   with_fx :level, amp: 1 do
              #     live_audio :qsamp, stereo: true, input: 1
              #   end
              #   end
              # end

              with_fx :level, amp: 1 do
                 live_audio :git01, stereo: false, input: 1
               end

               with_fx :level, amp: 1 do
                  live_audio :mics01, stereo: false, input: 2
                end

                with_fx :level, amp: 1 do
                   live_audio :yoshimi, stereo: true, input: 5
                 end

                with_fx :level, amp: 1 do
                   live_audio :qsamp, stereo: true, input: 7
                 end

                    # with_fx :level, amp: 0.5 do
                    #   sample SAMPLES, "888888-BitifulBlueExtasy", lpf: 110, hpf: 30
                    # end



end #end of eq fx

#use with /home/b08x/studio/sessions/newest_favorite.carxp

#this was setup using headphones connected to hw:PCH
#it should have more volume when played back over hw:PCH,1 (stero speakers)
