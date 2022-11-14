set_mixer_control! hpf: 21
#set_volume! 1

run_file "/home/b08x/Studio/scripts/sonic-stuff/introduction.rb"
# run_file "/home/b08/workspace/seshmon/lib/drums/euclid_distrib_defs.rb"
#run_file  "/home/b08x/workspace/projects/seshmon/lib/io/inputs.rb"


use_bpm 60

use_debug true

in_thread do
  loop do
    cue :tick
    sleep 1
  end
end

# yoshimi
# linux_sampler
# sudobass
live_audio :yoshimi, input: 3, stereo: true


# load_sample SAMPLES, "wrongrules"
# load_sample SAMPLES, "sawit"
# load_sample SAMPLES, "itsgood"

#sample SAMPLES, "wrongrules"

#that im not a kid anymore
#sample SAMPLES, "whatcharealizing", start: 0.29, finish: 0.451

#that im not a kid anymore
#sample SAMPLES, "whatcharealizing", start: 0.29, finish: 0.451

#thats harsh
# sample SAMPLES, "whatcharealizing", start: 0.45, finish: 0.55

#i knew i was an adult, the day the judge said i''m trying you as an adult
#sample SAMPLES, "whatcharealizing", start: 0.55, finish: 1


# fade in to wobbly vinyl hiss
@hissloop = in_thread(name: :hiss_loop) do

  ampr = 1

  with_fx :level, amp: 0, amp_slide: 8 do |a|
    control a, amp: ampr

    loop do
      hiss
    end

  end
end

sleep 8



in_thread do
  sleepypants = sample_duration SAMPLES, "wedrankthewater", start: 0.825, finish: 0.97, attack: 2, release: 0.3, rate: 0.5
  with_fx :level, amp: 0, amp_slide: 4 do |a|
    control a, amp: 3
    8.times do |x|
      if x == 7
      end
        control a, amp: 0, amp_slide: 2
        with_fx :echo, phase: 0.125, decay: 8, pre_mix: 0.4 do
          with_fx :bpf, centre: 82, res: 0.75, pre_mix: 0.5 do
            sample SAMPLES, "wedrankthewater", start: 0.825, finish: 0.9681, attack: 2, release: 0.3, amp: 1, rate: 0.5, pitch: 6, pan: rrand(0.4,0.2), pan_slide: 6 do |x|
              control x, pan: rrand(-0.4,-0.2)
            end
          end
        end
        sleep sleepypants.round(3)
      end
    end
  end


  with_fx :reverb, room: 0.8, damp: 0.3 do
    # # "but we drank the water"
    sample SAMPLES, "wedrankthewater", start: 0.28, finish: 0.35, amp: 0.8, attack: 0.25
    #

    sleep 8

    # # "yeah"
    sample SAMPLES, "wedrankthewater", start: 0.44, finish: 0.5, amp: 0.8
    #sleep 0.125
    sleep 20
    #

  end



  with_fx :reverb, room: 0.8, damp: 0.5 do
    ampr = 1
    with_fx :level, amp: 0, amp_slide: 2 do |a|
      control a, amp: ampr
      #whatcha realizing jerk
      sample SAMPLES, "whatcharealizing", start: 0, finish: 0.27,  amp: 0.75, attack: 0.25, rate: 1.05

      in_thread do
        sleep 4
        eggs01
      end

      sample SAMPLES, "we_are_floating", attack: 2, amp: 0.75

      sleep sample_duration SAMPLES, "we_are_floating", attack: 2

    end

    in_thread do
      x = sample_duration SAMPLES, "roy", attack: 2, attack_level: 0.3, start: 0.25, finish: 0.312, rate: 1

      sample SAMPLES, "roy", attack: 2, attack_level: 0.3, amp: 0.35, start: 0.25, finish: 0.312, rate: 1, pan: -0.8, pan_slide: x do |p|
        control p, pan: 0.8
      end
    end


  end

  live_loop :spacewind do
    sync :spacewind
    15.times do
      tick

      with_fx :level, amp: 0, amp_slide: 8 do |a|
        if look < 14
          control a, amp: 1.3
        else
          control a, amp: 0
        end
        with_fx :ixi_techno, cutoff_min: 24, cutoff_max: 42, res: 0.8, phase: 0.25 do
          with_fx :band_eq, freq: 41, db: 8, res: 0.25 do
            sample SAMPLES, "we_are_floating", start: 0.56, finish: 1, beat_strech: 4, attack: 0.25, sustain: 4, release: 0.25, pan: 0, pan_slide: 4 do |p|
              control p, pan: rrand(-0.8,0.8)
            end
          end
        end
      end
      sleep 4
    end

  end


  eggs02


  at 16 do

    # load_sample SAMPLES, "revolver_fearme"
    # load_sample SAMPLES, "revolver_roofgolf"

    #wait 6


    with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, invert_wave: 1, wave: 3, pre_mix: 0.4 do
      with_fx :reverb, mix: 0.4, room: 0.9 do
        with_fx :level, amp: 2 do
          with_fx :mono do
            sample SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503
            sleep sample_duration SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503
          end
        end
      end
    end


    play :a2, amp: 0.8, attack: 2, sustain: 1, release: 2, pitch: 0, slide: 4 do |x|
      control x, pitch: -12, note: :a2
    end
    sleep 4

    in_thread do
      sleep 3

      with_fx :panslicer, pan_max: 0.8, pan_min: -0.8, phase: 2, smooth: 0.25 do |x|
  with_fx :rlpf, cutoff: 100, res: 0.8 do
    with_fx :reverb, room: 0.6, damp: 0.4 do
      with_fx :mono do
        sample SAMPLES, "kronos_tense"
        wait 8
        control x, pan_max: 0, pan_min: 0
      end
    end
  end
end

    end

    sample :ambi_piano, amp: 1.5, rate: 0.5, pitch: -12, attack: 0.5, release: 0.5, pan: -0.8, pan_slide: 1.75, rpitch: (scale 1, :major).tick do |x|
      control x, pan: 0.8
    end

    sleep 5

    narf = sample_duration SAMPLES, "revolver_fearme", start: 0.315, finish: 0.320


    with_fx :echo, room: 0.8, decay: 8, phase: 0.5, mix: 0.4 do
      #if i say you're scared, you're scared
      sample SAMPLES, "revolver_fearme", amp: 0.6, start: 0.315, finish: 0.320, rate: 0.9, pan: 1, pan_slide: 2.5 do |x|
        control x, pan: -1
      end
    end

    sleep narf + 4

    with_fx :level, amp: 0.025 do

      with_fx :pitch_shift, pitch: 24 do

        with_fx :whammy, pre_mix: 0.4 do
          with_fx :pan, pan: -0.8 do
            use_synth :chipnoise
            play 60, attack: 4, release: 4
          end

          with_fx :pan, pan: 0.8 do
            use_synth :chipnoise
            play 60, attack: 4, release: 4
          end
        end
      end
    end

    sleep 8

    with_fx :level, amp: 3 do
      with_fx :bpf, centre: 114, res: 0.8 do
        with_fx :hpf, cutoff: 40,pre_amp: 3 do
          with_fx :reverb, room: 0.4, damp: 0.3 do

            h = sample_duration SAMPLES, "05notcrazyenough", attack: 0.25, release: 0.25

            sample SAMPLES, "05notcrazyenough", attack: 0.125, release: 0.125, amp: 2.25, pan: -0.5, pan_slide: h.round(2) do |x|
              control x, pan: 1
            end


            sleep h
          end
        end
      end
    end

    live_loop(:bd) do
      with_fx :level, amp: 0.45, amp_slide: 4 do |a|
        with_fx :reverb, room: 0.6, damp: 0.4 do
          with_fx :band_eq, freq: 38, db: 6, res: 0.6 do
            play_hydro_seq(distribute(7, 16), "VP Kick 2")
          end
        end
      end
    end



    in_thread do
      #sync :spiral
      with_fx :echo, phase: 0.8, decay: 5, amp_slide: 1 do |e|
        control e, amp: 0.75
        q = sample_duration SAMPLES, "roy", start: 0.305, finish: 0.3125, rate: 1
        sample SAMPLES, "roy", lpf: 80, start: 0.305, finish: 0.3125, rate: 1, pan: -0.8, pan_slide: q.round(2) do |p|
          control p, pan: 0.8
        end
      end
    end

    in_thread do
      sleep 8
      sample SAMPLES, "110FollowtheLine",
      slice: 4, num_slices: 10, attack: 0.5, release: 0.5, pan: -0.2, pan_slide: 4 do |p|
        control p, pan: 0.2
      end

      sample SAMPLES, "110FollowtheLine", slice: 5, num_slices: 10, attack: 0.5, release: 1, rate: -1, pan: -1, amp: 0.25

      sample SAMPLES, "110FollowtheLine", start: 0.6, finish: 0.72, attack: 2, release: 2.5, rate: -1, pan: 1, amp: 0.25

    end

    sleep 12
    cue :spiral

  end


  at 60 do
    in_thread do

      with_fx :reverb, room: 0.6, damp: 0.2 do


        with_fx :level, amp: 0.75 do
          #you made it really hard for anyone to see it
          sample SAMPLES, "sawit", start: 0, finish: 0.6, attack: 0.125, release: 0.125
          sleep sample_duration SAMPLES, "sawit", start: 0, finish: 0.6

          sleep 1

          #its good,
          sample SAMPLES, "itsgood", start: 0, finish: 0.10, attack: 0.125, release: 0.25
          sleep sample_duration SAMPLES, "itsgood", start: 0, finish: 0.10

          sleep 2

          in_thread do
            sleep 1
            slipperyslope
          end
          #so good it scratched that part of my mind
          sample SAMPLES, "itsgood", start: 0.11, finish: 0.25


        end
        sleep sample_duration SAMPLES, "itsgood", start: 0.11, finish: 0.25
      end

    end
  end

  at 62 do
    live_loop(:bd) do

      stop
    end

  end


  at 75 do
    in_thread do
      sleep 1
      hellofriend02
    end



    live_loop :jazzy do

      2.times do |x|

        with_fx :band_eq, freq: 112, db: 6, res: 0.6 do
          with_fx :level, amp: 2 do
            with_fx :bitcrusher, cutoff: 40, pre_mix: 0.5 do
              with_fx :lpf, cutoff: 60 do
                sample SAMPLES, "209RoundMidnight", hpf: 45, start: 0.25, finish: 0.2791, attack: 2, release: 1, rate: range(1, -1, step: 2, inclusive: true).tick
              end
            end
          end
        end
        sleep 8
      end
      #stop
    end

  end

  at 84 do
    #am i dreaming
    with_fx :rhpf, cutoff: 80 do
      with_fx :level, amp: 0.46 do
        with_fx :reverb, mix: 0.2, room: 1 do
          sample SAMPLES, "we_are_dreaming", attack: 1, slice: 0, num_slices: 2, pan: -1, pan_slide: 2 do |p|
            control p, pan: 1
          end
        end
      end
    end

    sleep 16

    with_fx :level, amp: 3 do
      weallare
    end



  end



  at 104 do

    live_loop :ahee do
      with_fx :band_eq, freq: 38, db: 6, res: 0.6 do
        with_fx :level, amp: 0.15 do
          with_fx :reverb, room: 0.6, damp: 0.4 do

            sample DRUM_KITS, "EE_Kick_Power" if spread(1,8).tick


            sample DRUM_KITS, "EE_Hat_Cl_Dirty" if spread(2,8).look

            #
            #sample SAMPLES, "sim_k02-0_1" if spread(3,8).look


            sample DRUM_KITS, "EE_Kick_Hard_1" if spread(2,8).look

            sleep 0.5
          end
        end
      end
    end

  end




  at 108 do


  end #end at 108


  # 185 seconds overall


  at 122 do

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


  end

  at 220 do

    with_fx :level, amp: 0.10 do |lv|

      with_fx :reverb, room: 0.6, damp: 0.6, pre_mix: 0.9 do
        # load_sample SAMPLES, "SCSS-Mystery-Word"

        sample SAMPLES, "SCSS-Mystery-Word", start: 0, finish: 0.4

        sleep 4

        8.times do |x|

          if x.to_i.odd?
            ptrpan = 0.8
          else
            ptrpan = -0.8
          end

          with_fx :echo, decay: 0.125, phase: 0.125, pre_mix: 0.5 do
            # load_sample SAMPLES, "SMA-englishEdition"
            sample SAMPLES, "SMA-englishEdition",
              rate: 1.25, slice: x, num_slices: 18, pan: ptrpan,
              attack: 0.25, release: 0.25
          end
          sleep sample_duration SAMPLES, "SMA-englishEdition", rate: 0.75, slice: x, num_slices: 36, pan: ptrpan, attack: 0.25, release: 0.25


          control lv, amp: 0, amp_slide: 2 if x == 6

        end

        control lv, amp: 0.10, amp_slide: 0.25

        # ding! something....

        play :a6, pan: -0.8, attack: 0.015

        play :a6, pan: 0.8, attack: 0.015

        sleep 0.25

        sample SAMPLES, "SCSS-Correct", attack: 0.125, release: 0.125


      end

    end

    @fish.kill
    #### end of part one.

    sleep 8

    #### transition #####
    with_fx :level, amp: 0, amp_slide: 8 do |a|
      control a, amp: 0.5
      live_loop :oldtree do
        lakeofdreams
      end

      sleep 4
      live_loop :ahee do
        stop
      end
      sleep 2
      with_fx :level, amp: 3 do
        hellofriend01
      end
    end
  end
#end

  #######################
