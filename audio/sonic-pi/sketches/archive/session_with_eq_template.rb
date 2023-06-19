set_mixer_control! hpf: 21

with_fx :eq, low_shelf: 0, low_shelf_note: 21, low_shelf_slope: 0.1, low: 0, low_note: 28, low_q: 0.8,
             mid: 0, mid_note: 66, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 124, high_shelf_slope: 0.5, pre_amp: 2 do






              live_audio :guitar01, input: 1








end #end of eq fx
