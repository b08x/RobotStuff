
  #with_fx :record, buffer: buffer[:vocal,32] do

    with_fx :eq, low_shelf: -3, low_shelf_note: 35, low_shelf_slope: 1, low: 1, low_note: 42, low_q: 0.8,
                 mid: 0, mid_note: 70, mid_q: 0.8,
                 high: 0, high_note: 105, high_q: 0.6,
                 high_shelf: -3, high_shelf_note: 117, high_shelf_slope: 1, pre_amp: 3 do



                     live_audio :mic, input: 9, stereo: true



    end
