set_mixer_control! hpf: 21
#set_volume! 1

run_file "/home/b08/workspace/seshmon/sessions/robotjazz/introduction.rb"
#run_file "/home/b08x/workspace/projects/seshmon/lib/drums/euclid_distrib_defs.rb"
#run_file  "/home/b08x/workspace/projects/seshmon/lib/io/inputs.rb"


use_bpm 75

use_debug true

in_thread do
  loop do
    cue :tick
    sleep 0.5
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

  with_fx :level, amp: 0, amp_slide: 2 do |a|
    control a, amp: ampr

    loop do
      hiss
    end

  end
end

sleep 4

#1 computer noises

in_thread do
  sleepypants = sample_duration SAMPLES, "wedrankthewater", start: 0.825, finish: 0.97, attack: 2, release: 0.3, rate: 0.5

  with_fx :level, amp: 0, amp_slide: 6 do |a|
    control a, amp: 3
    6.times do |x|
      if x == 5
        control a, amp: 0.25, amp_slide: 0.25
      end

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



#### laughtr soundscape
live_loop :laughter do
@laughamp = 0.6
  with_fx :level, amp: 0, amp_slide: 4 do |x|
    control x, amp: @laughamp
    sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5, rate: 1
    sleep sample_duration SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5
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


@laughamp = 0.2
with_fx :reverb, room: 0.8, damp: 0.5 do
  ampr = 1
  with_fx :level, amp: 0, amp_slide: 1 do |a|
    control a, amp: ampr
    #whatcha realizing jerk
    sample SAMPLES, "whatcharealizing", start: 0, finish: 0.27,  amp: 1, attack: 0.125, rate: 1.05

    in_thread do
      sleep 4
      eggs01
    end

    sample SAMPLES, "we_are_floating", attack: 2, amp: 0.75

    sleep sample_duration SAMPLES, "we_are_floating", attack: 2
    #5 just a second before this cuts out
  end




  with_fx :level, amp: 0.5, amp_slide: 4 do |a|
    with_fx :reverb, room: 0.8, damp: 0.4 do
      with_fx :band_eq, freq: 41, db: 9, res: 0.6 do
       live_loop(:bd) do
         cue :bassdruum
         use_bpm 45
         @bdamp = 1
          with_fx :mono, pan: 0, amp: @bdamp, amp_slide: 0.25 do
            sample SAMPLES, "EE_Kick_Hard_1" if (spread 4, 8).tick
            sleep sample_duration SAMPLES, "EE_Kick_Hard_1"
          end
        end
      end
    end
  end

end

live_loop :spacewind do
  sync :spacewind
  16.times do
    tick

    with_fx :level, amp: 0, amp_slide: 8 do |a|
      if look < 7
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

@laughamp = 0

eggs02

live_audio :qsamp, input: 5, stereo: true

puts "heyo"

# in_thread do
#   x = sample_duration SAMPLES, "roy", attack: 2, attack_level: 0.3, start: 0.25, finish: 0.312, rate: 1
#
#   sample SAMPLES, "roy", attack: 2, attack_level: 0.3, amp: 0.35, start: 0.25, finish: 0.312, rate: 1, pan: -0.8, pan_slide: x do |p|
#     control p, pan: 0.8
#   end
# end

#d1 piano

at 16 do

  # load_sample SAMPLES, "revolver_fearme"
  # load_sample SAMPLES, "revolver_roofgolf"

  #wait 6
  @bdamp = 0.3



  with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, invert_wave: 1, wave: 3, pre_mix: 0.4 do
    with_fx :reverb, mix: 0.4, room: 0.9 do
      with_fx :level, amp: 2 do
        with_fx :mono do
          sample SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503
          pq = sample_duration SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503
          sleep pq
        end
      end
    end
  end

  with_fx :echo, phase: 0.75, decay: 8, pre_mix: 0 do |x|
    with_fx :reverb, room: 0.9, damp: 0.6, res: 0.6 do
      #sleep 2
      sample SAMPLES, "goingupelevator", attack: 0.125, start: 0.001, finish: 0.10, rate: 1.5, amp: 0.2
      wait 2
      control x, pre_mix: 0.8
    end
  end





  # play :d3, amp: 0.8, attack: 0.125, sustain: 2, release: 2, pitch: 0, slide: 2 do |x|
  #   control x, pitch: -12, note: :a2
  # end
  # sleep 4


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


  # with_fx :echo, room: 0.8, decay: 8, phase: 0.5, mix: 0.4 do
  #   #if i say you're scared, you're scared
  #   sample SAMPLES, "revolver_fearme", amp: 0.6, start: 0.315, finish: 0.320, rate: 0.9, pan: 1, pan_slide: 2.5 do |x|
  #     control x, pan: -1
  #   end
  # end

  sleep narf + 4

  with_fx :level, amp: 0.040 do

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

  with_fx :level, amp: 2.2 do
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


@hatsamp = 0.6

  live_loop :hats do

    use_bpm 45
    sync :bassdruum

      if (spread 5, 8).tick then
        # (spread 3, 8) produces this pattern: * _ _ * _ _ * _
        with_fx :hpf, cutoff: 36 do
          with_fx :rlpf, cutoff: 100, res: 0.5 do
            with_synth :mod_beep do
              play :b1, amp: @hatsamp,
                attack: 0.1, decay: 0.08, release: 0.1
            end
          end
        end
      end
      sleep 0.25
  end
end



  # in_thread do
  #   sync :spiral
  #   with_fx :echo, phase: 0.8, decay: 5, amp_slide: 1 do |e|
  #     control e, amp: 0.75
  #     q = sample_duration SAMPLES, "roy", start: 0.305, finish: 0.3125, rate: 1
  #     sample SAMPLES, "roy", lpf: 80, start: 0.305, finish: 0.3125, rate: 1, pan: -0.8, pan_slide: q.round(2) do |p|
  #       control p, pan: 0.8
  #     end
  #   end
  # end
  #


  load_sample SAMPLES, "wrongrules"
  in_thread do
    sleep 8
    sample SAMPLES, "110FollowtheLine",
    slice: 4, num_slices: 10, attack: 0.5, release: 0.5, pan: -0.2, pan_slide: 4 do |p|
      control p, pan: 0.2
    end

    sample SAMPLES, "110FollowtheLine", slice: 5, num_slices: 10, attack: 0.5, release: 1, rate: -1, pan: -1, amp: 0.25

    sample SAMPLES, "110FollowtheLine", start: 0.6, finish: 0.72, attack: 2, release: 2.5, rate: -1, pan: 1, amp: 0.25

  end

  sleep 20
  #cue :spiral

end


at 60 do
  @bdamp = 0.2
  @hatsamp = 0.2

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
      sleep 2

      @bdamp = 0.1

      live_loop(:bd) do
        stop
      end

      live_loop(:hats) do
        stop
      end

      with_fx :ring_mod, freq: 60, pre_mix: 0 do |f|
        with_fx :bitcrusher, cutoff: 72, pre_mix: 0.8 do |b|
          with_fx :echo, phase: 0.4, decay: 12, pre_mix: 0 do |x|
            with_fx :rlpf, cutoff: 100, res: 0.6 do
              #cos, what is reality?
              with_fx :mono, pan: -0.2, amp: 0.8, pan_slide: 0.5 do |p|
                control p, pan: -1
                sample SAMPLES, "robin_williams_fullgooseboozo_whatisreality", attack: 0.25, start: 0.85, finish: 1
              end

              #cos, what is reality?
              with_fx :mono, pan: 0.2, amp: 0.8, pan_slide: 0.5 do |q|
                control q, pan: 1
                sample SAMPLES, "robin_williams_fullgooseboozo_whatisreality", attack: 0.25, start: 0.85, finish: 1
              end
              wait 1
              control f, freq: 92, pre_mix: 0.8
              control x, pre_mix: 0.8
            end
          end
        end
      end

    end



  end #end thread


end #end at 60




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
    stop
  end

end

at 84 do
  #cue :spacewind
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

  with_fx :level, amp: 2.5 do
    weallare
  end



end

at 104 do
    @drumzamp = 1


  live_loop :drumz do
      cue :kickdrum
      use_bpm 45

      #               1 &  2 &  3 &  4 &
      cymbals = bools(0,0, 0,0, 0,0, 0,0)
      hard    = bools(1,0, 0,0, 1,0, 0,0)
      soft    = bools(0,0, 1,0, 0,0, 1,0)
      kick    = bools(0,0, 0,0, 0,0, 0,0)


      with_fx :level, amp: @drumzamp, amp_slide: 2 do |x|

      with_fx :reverb, room: 0.8, damp: 0.3 do
        tick_reset
        12.times do

          tick

          with_fx :lpf, cutoff: 110 do
            if cymbals.look then
              if one_in(8) then
                sample SAMPLES, "EE_Hat_Op_Dirty", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, pan: rrand(-0.9,0.9)
              else
                sample SAMPLES, "EE_Hat_Op_Dirty", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, rate: -1, pan: rrand(-0.9,0.9)
              end
            else
              #sample SAMPLES, "EE_Hat_Cl_Dirty", amp: 0.5
            end
          end


          with_fx :band_eq, freq: 38, db: 1.5, res: 0.3 do
            sample SAMPLES, "sim_k02-0_1", pan: 0, amp: 0.50, on: hard.look

            sample SAMPLES, "sim_k02-0", pan: 0, amp: 0.50, on: soft.look

            sample SAMPLES, "VP Kick 2", lpf: 85, pan: 0, amp: 0.55, on: kick.look
          end

          sleep 0.375
        end



        sleep 4
        #sleep 1.625
        #sleep 0.8125
      end

      end #end levelfx
    end# end of drumzloop


end #end 104



at 108 do

  with_fx :level, amp: 1 do
    with_fx :band_eq, freq: 66, res: 0.6, db: 9 do
      with_fx :reverb, room: 0.8, pre_mix: 0.9, damp: 0.4 do
        in_thread do
          sync :kickdrum
          s = sample_duration SAMPLES, "000248ghostsofthingstcome", amp: 0.75


          with_fx :mono, pan: 0.9 do
            sample SAMPLES, "000248ghostsofthingstcome", amp: 0.35
          end

          with_fx :mono, pan: -0.9 do
            sample SAMPLES, "000248ghostsofthingstcome", amp: 0.35
          end

          sleep s

        end
      end
    end
  end

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

at 242 do

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

      play :a5, pan: -0.8, attack: 0.015

      play :a5, pan: 0.8, attack: 0.015

      sleep 0.5

      sample SAMPLES, "SCSS-Correct", attack: 0.125, release: 0.125


    end

  end

  @fish.kill
  #### end of part one.

  sleep 16

  #### transition #####
  with_fx :level, amp: 0, amp_slide: 8 do |a|
    control a, amp: 0.5
    live_loop :oldtree do
      stop
      lakeofdreams
    end

    # sleep 4
    # live_loop :drumz do
    #   stop
    # end
    sleep 2
    with_fx :level, amp: 3 do
      hellofriend01
    end
  end
end


#######################

#######################
##### begin part ii
######################

live_loop :derpydo do
  sync :derp
  sample SAMPLES, "mahnamahna", start: 0.035, finish: 0.062, attack: 0.8, release: 0.5
  sleep sample_duration SAMPLES, "mahnamahna", start: 0.035, finish: 0.062, attack: 0.8, release: 0.5
end
