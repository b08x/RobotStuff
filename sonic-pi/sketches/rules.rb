use_debug true


set_mixer_control! hpf: 21
set_volume! 2


at 0 do

  @lofamp = 0.5
  with_fx :level, amp: 0, amp_slide: 8 do |a|

    loop do
      control a, amp: @lofamp

      soundly = sample_duration SAMPLES, "10TimeTheOldTreeWithWindingRootsBehindtheLakeofDreamsmix", slice: 1, num_slices: 28,  attack: 0.5, decay: 0.25, release: 0.5

      with_fx :reverb, room: 0.8, damp: 0.5, pre_mix: 0.8 do

        with_fx :pan, pan: 1 do
          sample SAMPLES, "10TimeTheOldTreeWithWindingRootsBehindtheLakeofDreamsmix", slice: 1, num_slices: 28,  attack: 0.5,  decay: 0.25, release: 0.5, amp: 0.5
        end


        with_fx :pan, pan: -1 do
          sample SAMPLES, "10TimeTheOldTreeWithWindingRootsBehindtheLakeofDreamsmix", slice: 2, num_slices: 28,  attack: 0.5,  decay: 0.25, release: 0.5, rate: -1, amp: 0.5
        end

      end


      sleep soundly
    end

  end

end #end at0

at 8 do

  @olthymeamp = 0.3
    with_fx :level, amp: 0, amp_slide: 8 do |a|
    @oltimey = in_thread do
      loop do
        control a, amp: @olthymeamp
        with_fx :tremolo do
          sample :vinyl_hiss, rate: 0.5, pan: rrand(-0.5,0.5), pan_slide: 8 do |h|
            control h, pan: rrand(-0.5, 0.5)
          end
          sleep sample_duration :vinyl_hiss, rate: 0.5
        end
      end
    end
  end
  @lofamp = 0
end #end at8

at 28 do

  with_fx :mono do
    sample SAMPLES, "wrongrules", amp: 0.8, attack: 0.125, release: 0.125
    sleep sample_duration SAMPLES, "wrongrules", amp: 0.8, attack: 0.125, release: 0.125
  end

end

#D F A


#C Ds G



with_fx :pan, pan: -0.3 do
  live_audio :gitar, stereo: true, input: 1
end

with_fx :pan, pan: 0.3 do
  live_audio :gitar_loop01, stereo: false, input: 4
end

with_fx :reverb, room: 0.4 do
live_audio :hydro, stereo: true, input: 3
end



with_fx :pan, pan: 0.4 do
  live_audio :yosh, stereo: false, input: 3
end

with_fx :pan, pan: 0.6 do
  live_audio :qsampler, stereo: false, input: 4
end


## TODO:
#method to control ring mod via osc
