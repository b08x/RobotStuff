use_bpm 84
#### laughtr soundscape
comment do

  @laughamp = 0.45
  with_fx :level, amp: 0, amp_slide: 4 do |x|
    live_loop :laughter do
      control x, amp: @laughamp
      stop
      onyerback = sample_duration SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5, rate: -1.39

      sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 0.125, release: 0.125, rate: -1.39
      sleep onyerback - 0.125
    end
  end

end



comment do
  in_thread do
    #isn't there something youd like to say
    sample SAMPLES, "nevertry", start: 0, finish: 0.17, amp: 0.75
    sleep 8
    #there sure is
    sample SAMPLES, "nevertry", start: 0.18, finish: 0.321, amp: 0.75
  end
end

run_file "/home/b08/workspace/seshmon/lib/bass/wooble.rb"


uncomment do

  with_fx :level, amp: 0, amp_slide: 16 do |a|
    control a, amp: 0.25
    live_loop :wubwub do
      use_bpm 45
      with_fx :band_eq, freq: 45, db: -30, res: 0.4 do
        with_fx :lpf, cutoff: 60 do

          with_fx :slicer, probability: 0.5, smooth_down: 1 do
            with_fx :ixi_techno, cutoff_min: 32, cutoff_max: 42, phase: 0.8, res: 0.3 do
              with_fx :ring_mod, freq: rrand(30,34), freq_slide: 5 do |f|
                control f, freq: rrand(30,34)
                wob(34, 8, 16)

                #wob(38, 2, 8)
              end
            end
          end
        end
      end
      #sleep 2

      #wob(36, 2, 2)
      #sleep 2

      #wob(34, 2, 2)
      #sleep 2
      #wob(33, 2, 2)
      #sleep 2
      sleep 16
    end
  end

end

notes = (scale :a1, :hungarian_minor, num_octaves: 32)

uncomment do
  with_fx :reverb, room: 0.8, damp: 0.4 do
    live_loop :repeating_melody do
      
      use_synth :chipbass

      use_random_seed 420


      64.times do |x|
        tick
        p = range(-0.8,0.8, step: 0.0625, inclusive: true).look
        naabra = notes.choose

        next if naabra >= 110 or naabra < 35

        play naabra, release: 0.1, amp: 0.25,
          pan: p, pan_slide: 0.75,
          pitch: range(-24,0, step: 12, inclusive: true).choose

        sleep 0.125


      end
      sleep 1.125

    end
  end
end


comment do
  live_loop :simbeats do
    stop
    with_fx :rlpf, cutoff: 65, res: 0.4 do
      with_fx :level, amp: 0.75 do
        #sample :bass_hit_c, amp: 0.20 if spread(4,7).tick

        #sample SAMPLES, "sim_k02-0_1", pick, amp: 0.5 if spread(3,5).look

        sample SAMPLES, "Classic-808_Kick_long", pick, amp: 0.5 if spread(1,4).tick
        sleep 0.25
      end
    end

  end
end


with_fx :hpf, cutoff: 76 do


  comment do

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




  uncomment do

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

  comment do
    live_loop :slicedrop do

      with_fx :pan, pan: rrand(-1,1) do

        with_fx :slicer, probability: 0.8, smooth_down: 0.2 do

          with_fx :rhpf, cutoff: 52, res: 0.4 do

            play :a4, amp: 0.15, attack: 2, sustain: 1, release: 4, pitch: 0, slide: 4 do |x|

              control x, pitch: -36, note: :a4
            end
          end


        end

      end

      sleep 8

    end

  end

  comment do
    in_thread do
      #isn't there something youd like to say
      sample SAMPLES, "nevertry", start: 0, finish: 0.17, amp: 0.75
      sleep 8
      #there sure is
      sample SAMPLES, "nevertry", start: 0.18, finish: 0.321, amp: 0.75
    end
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
            sample SAMPLES, "01hellofriend", start: 0.155, finish: 0.25, amp: 0.5
          end
        end
      end
    end
  end


  comment do

    with_fx :level, amp: 0, amp_slide: 8 do |a|



      live_loop :spacewind do
        control a, amp: 0.2

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


end
