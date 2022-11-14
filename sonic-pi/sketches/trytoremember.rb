set_mixer_control! hpf: 21

#for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
#the way it is now, dont fuck with it. (guitarix isn't necessary for this)
with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 42, low_q: 0.8,
  mid: 0, mid_note: 70, mid_q: 0.8,
  high: 0, high_note: 105, high_q: 0.6,
high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 1 do







  comment do

    hodr1 = range(-0.8,-0.2,step: 0.25, inclusive: true).tick
    hodr2 = range(0.8,0.2,step: 0.25, inclusive: true).tick

    with_fx :mono, pan: hodr1, pan_slide: 8 do |p|
      control p, pan: hodr2
      with_fx :echo, phase: 0.65, decay: 4, pre_mix: 0.25 do
        with_fx :reverb, room: 0.8, damp: 0.6, res: 0.6 do
          live_audio :freqmics, stereo: true, input: 3, amp: 0.45
        end
      end
    end

  end




end #end of eq fx







with_fx :hpf, cutoff: 55 do
    live_loop :slicedrop do
      #stop
      with_fx :pan, pan: rrand(-1,1) do
        with_fx :slicer, probability: 0.85, smooth_down: 0.5 do

          play :d2, amp: 0.5, attack: 0.25, sustain: 0.50, release: 0.25, pitch: 0, slide: 16 do |x|

            control x, pitch: -36, note: :a3
          end

        end

      end

      sleep 8

    end
end

#forgetit = sample_duration SAMPLES, "trytoremember"

#puts (forgetit/16)
#### laughtr soundscape

comment do

  @laughamp = 0.25
  with_fx :level, amp: 0, amp_slide: 4 do |x|
    live_loop :laughter do
      control x, amp: @laughamp
      sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 0.125, release: 0.125, rate: 1
      sleep (sample_duration SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5 - 0.125)
    end
  end
end


uncomment do
  #stop

  live_loop :undermoonlight do

    with_fx :ixi_techno, cutoff_min: 45, cutoff_max: 75, phase: 0.5, res: 0.4, pre_mix: 0.4 do

      with_fx :panslicer, pan_max: 0.8, pan_min: -0.8, phase: 2, smooth: 0.25 do |x|

        with_fx :level, amp: 0, amp_slide: 4 do |a|
          control a, amp: 0.45

          16.times do |x|

            with_fx :mono do
              sample SAMPLES, "888888-UnderTheMoonLight", slice: x, num_slices: 16
            end

            sleep sample_duration SAMPLES, "888888-UnderTheMoonLight", slice: x, num_slices: 16
          end


        end
      end
    end

  end
end




comment do

  with_fx :level, amp: 0, amp_slide: 4 do |a|
    #46.95
    live_loop :kanjo do
      control a, amp: 0.65
      #sample SAMPLES, "bfleck_djaryjam", slice: 0, num_slices: 8, amp: 0.2
      9.times do |x|
        cue :something
        if x == 8
          rls = 1
          control a, amp: 0.25
        else
          rls = 0.125
        end

        hodr = range(-1,1,step: 0.125, inclusive: true).tick

        with_fx :bpf, centre: 90, res: 0.8 do
          with_fx :mono, pan: hodr, pan_slide: 1 do |p|

            sample SAMPLES, "fleck_kandjo", slice: x, num_slices: 32, amp: 0.5, release: rls, pitch_dis: 0.001
            sleep sample_duration SAMPLES, "fleck_kandjo", slice: x, num_slices: 32, amp: 0.8, release: rls, pitch_dis: 0.001

          end
        end

      end

    end
  end


end

#0.0938 0.125
#sample SAMPLES, "fleck_kandjo", start: 0.0938, finish: 0.125


  live_loop :slicedrop do

    with_fx :pan, pan: rrand(-1,1) do

      with_fx :slicer, probability: 0.4, smooth_down: 0.2 do

        with_fx :rhpf, cutoff: 52, res: 0.4 do

          play :a4, amp: 0.25, attack: 2, sustain: 1, release: 4, pitch: 0, slide: 4 do |x|

            control x, pitch: -36, note: :a4
          end
        end


      end

    end

    sleep 16

  end




comment do
  in_thread do
    #kids, you tried your best
    sample SAMPLES, "nevertry", start: 0.321, finish: 0.55

    #you failed miserably *suck*
    sample SAMPLES, "nevertry", start: 0.565, finish: 0.7

    #the lesson is
    sample SAMPLES, "nevertry", start: 0.7, finish: 0.825, amp: 0.8

    #never try
    sample SAMPLES, "nevertry", start: 0.825, finish: 1
  end
end

comment do
  in_thread do
    with_fx :pan, pan: 1, pan_slide: 2 do |p|
      control p, pan: -1
      with_fx :reverb, mix: 0.2, room: 1 do
        with_fx :echo, mix: 0.1, phase: 0.55, decay: 6 do | fx_echo |
          sample SAMPLES, "01hellofriend", start: 0.155, finish: 0.25, amp: 0.9
        end
      end
    end
  end
end


comment do

  with_fx :level, amp: 0.2, amp_slide: 8 do |a|



    live_loop :spacewind do
      control a, amp: 0.5
      16.times do
        tick
        with_fx :ixi_techno, cutoff_min: 24, cutoff_max: 42, res: 0.8, phase: 0.25 do
          with_fx :band_eq, freq: 41, db: 8, res: 0.25 do
            sample SAMPLES, "we_are_floating", amp: 1, start: 0.56, finish: 1, beat_strech: 4, attack: 0.25, sustain: 4, release: 0.25, pan: 0, pan_slide: 4 do |p|
              control p, pan: rrand(-0.8,0.8)
            end
          end
        end
        sleep 4
      end
    end

  end


end


#leftside = range(-0.8,-0.2,step: 0.5, inclusive: true).tick

#rightside = leftside.abs




  with_fx :level, amp: 0.45 do
    live_loop :coldtoday do



      32.times do |x|

        if x.odd?
          iwav = 0
        else
          iwav = 1
        end


        forever = sample_duration SAMPLES, "trytoremember", slice: x, num_slices: 32

        with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, phase: 1, invert_wave: iwav, smooth: 32, smooth_up: 16, smooth_down: 16 do

          with_fx :ixi_techno, cutoff_min: 42, cutoff_max: 52, phase: 0.5, pre_mix: 0.8 do
            with_fx :mono do
              sample SAMPLES, "trytoremember", amp: 0.45, slice: x, num_slices: 32
            end
          end
        end


        sleep forever

      end

    end


  end
