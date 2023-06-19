#introduction



#for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
#the way it is now, dont fuck with it. (guitarix isn't necessary for this)
with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 42, low_q: 0.8,
  mid: 0, mid_note: 70, mid_q: 0.8,
  high: 0, high_note: 105, high_q: 0.6,
high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 1 do

  use_bpm 60
  use_debug true
  #set_sched_ahead_time! 0
  #set_volume! 2

  #########################################
  # Metronome Helper Functions for synching
  #########################################

  # Count every beat
  live_loop :bar do
    cue :tick
    sleep 1
  end

  # Sync 2-bar patterns
  live_loop :two_bars, autocue: false do
    sync :tick
    cue :every_two_bars
    sample :elec_blip, amp: 0.001, rate: 1
    sleep 8
  end

  # Synch 4-bar patterns
  live_loop :four_bars, autocue: false do
    sync :tick
    cue :every_four_bars
    sample :elec_blip, amp: 0.001, rate: 2.0
    sleep 16
  end

  comment do
    live_audio :gitar, input: 1, stereo: true
    live_audio :whysynth, input: 3, stereo: true
    live_audio :qsynth, input: 5, stereo: true
    live_audio :hydrogen, input: 7, stereo: true
  end



  uncomment do

    hodr1 = range(-0.8,-0.2,step: 0.25, inclusive: true).tick
    hodr2 = range(0.8,0.2,step: 0.25, inclusive: true).tick

    with_fx :mono, pan: hodr1, pan_slide: 8 do |p|
      control p, pan: hodr2
      with_fx :echo, phase: 0.65, decay: 4, pre_mix: 0.25 do
        with_fx :reverb, room: 0.8, damp: 0.6, res: 0.6 do
          live_audio :banjo, stereo: true, input: 1, amp: 1.5
        end
      end
    end

  end

  @olthymeamp = 1
  with_fx :level, amp: 0, amp_slide: 4 do |a|
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

  sleep 8

  uncomment do

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

    with_fx :reverb, room: 0.8, damp: 0.3 do
      # # "but we drank the water"
      sample SAMPLES, "wedrankthewater", start: 0.28, finish: 0.35, amp: 0.55, attack: 0.3

      sleep 8
      # # "yeah"
      sample SAMPLES, "wedrankthewater", start: 0.44, finish: 0.5, amp: 0.55
      @laughamp = 0.6
    end
  end

sleep 4


  uncomment do
    notes = (scale :d2, :blues_minor, num_octaves: 32)
    with_fx :level, amp: 0.300 do
      with_fx :reverb, room: 0.8, damp: 0.4 do
        live_loop :repeating_melody do
          #stop
          sync :every_two_bars
          use_synth :mod_pulse
          use_random_seed 780
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

  end



  comment do
    live_loop :simbeats do

      sync :bar

      # Add cue here to trigger at...

      with_fx :rlpf, cutoff: 65, res: 0.4 do
        with_fx :level, amp: 1 do
          #sample :bass_hit_c, amp: 0.20 if spread(4,7).look
          sample DRUM_KITS, "EE_Kick_Hard_2", amp: 0.20 if spread(4,7).look
          #sample DRUM_KITS, "EE_Kick_Hard_2", pick, amp: 0.4, pan: 0.1 if spread(3,5).look

          sample DRUM_KITS, "35bass_2", pick, amp: 0.5 if spread(1,4).tick

          sleep 0.25
        end
      end

    end

  end



  uncomment do
    with_fx :hpf, cutoff: 55 do
      live_loop :slicedrop do
        #stop
        sync :four_bars
        with_fx :pan, pan: rrand(-1,1) do
          with_fx :echo, decay: 4, phase: 1 do
            with_fx :slicer, probability: 0.85, smooth_down: 0.5 do

              play :d2, amp: 0.55, attack: 0.45, sustain: 0.50, release: 0.25, pitch: 0, slide: 16 do |x|

                control x, pitch: -36, note: :a3
              end

            end
          end


        end

        #sleep 8

      end
    end

  end




  uncomment do

    with_fx :level, amp: 0.2, amp_slide: 8 do |a|

      live_loop :spacewind do
        control a, amp: 0.5
        16.times do
          tick
          with_fx :ixi_techno, cutoff_min: 24, cutoff_max: 42, res: 0.8, phase: 0.25 do
            with_fx :band_eq, freq: 41, db: 8, res: 0.25 do
              sample SAMPLES, "we_are_floating", amp: 0.5, start: 0.56, finish: 1, beat_strech: 4, attack: 0.25, sustain: 4, release: 0.25, pan: 0, pan_slide: 4 do |p|
                control p, pan: rrand(-0.8,0.8)
              end
            end
          end
          sleep 4
        end
      end

    end


  end


  # fade out spacewind, ease in to this then fade out gently into hello friend, i hope
  # you're enjoying the moonlight.

  with_fx :level, amp: 0.8 do
    with_fx :reverb, room: 0.8, pre_mix: 0.8, damp: 0.4 do


      #live_loop :ghostface do
        # load_sample SAMPLES, "000248ghostsofthingstcome"
        #sync :heartbeatx

        8.times do |x|

          if x.to_i.odd?
            pmin = -0.3
            pmax = -0.1
          else
            pmin = 0.3
            pmax = 0.1
          end

          with_fx :panslicer, wave: 1, pan_min: pmin, pan_max: pmax do
            s = sample_duration SAMPLES, "000248ghostsofthingstcome", slice: x, num_slices: 8


            sample SAMPLES, "000248ghostsofthingstcome", amp: 0.25, slice: x, num_slices: 8, attack: 0.005, release: 0.05



            sleep s
          end

        end
        # stop
      #end

    end
  end



  @fish = in_thread do
    #load_sample SAMPLES, "403982_klankbeeld_ped_nl"
    sample SAMPLES, "403982_klankbeeld_ped_nl", attack: 8, release: 8, start: 0.08, finish: 0.56, pan: -1, pan_slide: 16 do |p|
      2.times do
        control p, pan: 1
        sleep 16
        control p, pan: -1
        sleep 16
        control p, pan: 0
        sleep 8
      end
    end


  end

  sleep 8

  3.times do

    #panner = range(-0.8,0.8, step: 0.125, inclusive: true)
    #load_sample SAMPLES, "SCSS-Sequence-08"
    with_fx :panslicer, amp_min: 0.1, amp_max: 0.4, pan_min: -0.8, pan_max: 0.8,
    smooth_up: 1.5, smooth_down: 1.5 do
      with_fx :mono do
        sample SAMPLES, "SCSS-Sequence-08", attack: 2, release: 0.25, pre_amp: 0.05
      end
    end

    sleep sample_duration SAMPLES, "SCSS-Sequence-08", attack: 2, release: 0.25
    sleep 4

  end




end # end of main eq
