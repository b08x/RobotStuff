
with_fx :level, amp: 0.10 do |lv|

    with_fx :reverb, room: 0.6, damp: 0.4, pre_mix: 0.9 do
      # load_sample SAMPLES, "SCSS-Mystery-Word"

      sample EFFECTS, "SCSS-Mystery-Word", start: 0, finish: 0.4
      sleep 4
      8.times do |x|

        if x.to_i.odd?
          ptrpan = 0.8
        else
          ptrpan = -0.8
        end
        with_fx :echo, decay: 0.125, phase: 0.125, pre_mix: 0.5 do
          # load_sample SAMPLES, "SMA-englishEdition"
          sample EFFECTS, "SMA-englishEdition",
            rate: 1.25, slice: x, num_slices: 18, pan: ptrpan,
            attack: 0.25, release: 0.25
        end
        sleep sample_duration EFFECTS, "SMA-englishEdition", rate: 0.75, slice: x, num_slices: 36, pan: ptrpan, attack: 0.25, release: 0.25
        control lv, amp: 0, amp_slide: 2 if x == 6
      end
      control lv, amp: 0.10, amp_slide: 0.25
      # ding! something....
      play :a5, pan: -0.8, attack: 0.015
      play :a5, pan: 0.8, attack: 0.015
      sleep 0.5
      sample EFFECTS, "SCSS-Correct", attack: 0.125, release: 0.125
    end

    cue :hooray
  end
