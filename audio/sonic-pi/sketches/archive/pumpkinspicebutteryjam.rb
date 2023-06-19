# pumpkin spice butterfly jam

set_mixer_control! hpf: 21
#set_volume! 1

use_debug true



use_bpm 113



#midi_cc 100, 1
#midi 37





uncomment do
  sample SAMPLES, "Moeda caindo longe", amp: 1
  with_fx :reverb, room: 0.6, damp: 0.4 do

    sample SAMPLES, "goingupelevator", attack: 0.5, release: 0.5, start: 0, finish: 0.10
    sleep 1
    sample SAMPLES, "fastenyourseatbelts", start: 0.10, finish: 1
    sleep sample_duration SAMPLES, "fastenyourseatbelts", start: 0.10, finish: 1 - 0.125


    with_fx :pan, pan: 0, pan_slide: 24 do |x|


      with_fx :echo, decay: 8, phase: 0.25, pre_mix: 0, pre_mix_slide: 0.025 do |y|
        sample SAMPLES, "goingupelevator", attack: 4, release: 0.125, start: 0.15, finish: 0.825
        wait 2
        control x, pan: 0.6, pan_slide: 12
        wait 12
        control x, pan: -0.6, pan_slide: 12
        wait 10
        control x, pan: 0, pan_slide: 1
        wait 0.75
        control y, pre_mix: 0.8, amp: 0.5, amp_slide: 0.125
      end

    end


    sleep 4

  end
end

#use c3 with doomydoom when playing ladopecowball pattern



#before we dissolve
uncomment do
  #sample SAMPLES, "wrongrules", amp: 1

  in_thread do
    #on the high end of things, might tone down between 630 - 2000Hz to reduce sharp sibilance
    with_fx :band_eq, freq: 88, res: 0.6, db: -16 do

      with_fx :band_eq, freq: 96, res: 0.4, db: -16 do
        with_fx :band_eq, freq: 75, res: 0.2, db: -16 do
          sample SAMPLES, "beforewedissolve", start: 0.10, finish: 0.50
          sleep sample_duration SAMPLES, "beforewedissolve", start: 0.10, finish: 0.50



          sample SAMPLES, "beforewedissolve", start: 0.525, finish: 0.940
          sleep sample_duration SAMPLES, "beforewedissolve", start: 0.525, finish: 0.940

        end
      end

    end
  end

end

uncomment do
  in_thread do
    with_fx :pan, pan: 1, pan_slide: 2 do |p|
      control p, pan: -1
      with_fx :reverb, mix: 0.2, room: 1 do
        with_fx :echo, mix: 0.1, phase: 0.55, decay: 6 do | fx_echo |
          sample SAMPLES, "hellofriend", start: 0.155, finish: 0.25, amp: 0.5
        end
      end
    end
  end
end
