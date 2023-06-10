set_mixer_control! hpf: 21


with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 42, low_q: 0.8,
             mid: 0, mid_note: 70, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 2 do


               with_fx :sound_out_stereo, output: 1, amp: 0 do
                    live_audio :mixxx, stereo: true, input: 7
                  end




end #end of eq fx
