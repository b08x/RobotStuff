set_mixer_control! hpf: 21
set_volume! 2

run_file "/home/b08/workspace/seshmon/sessions/robotjazz/introduction.rb"
#run_file  "/home/b08x/workspace/projects/seshmon/lib/io/inputs.rb"


use_bpm 90

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

  #thats harsh
  # sample SAMPLES, "whatcharealizing", start: 0.45, finish: 0.55

  #i knew i was an adult, the day the judge said i''m trying you as an adult
  #sample SAMPLES, "whatcharealizing", start: 0.55, finish: 1


# fade in to wobbly vinyl hiss
@hissloop = in_thread(name: :hiss_loop) do

  ampr = 0.5

  with_fx :level, amp: 0, amp_slide: 8 do |a|
    control a, amp: ampr

    loop do
      hiss
    end

  end
end

sleep 8




with_fx :reverb, room: 0.8, damp: 0.5 do
  ampr = 0.8
  with_fx :level, amp: 0, amp_slide: 2 do |a|
    control a, amp: ampr
    #whatcha realizing jerk
    sample SAMPLES, "whatcharealizing", start: 0, finish: 0.27,  amp: 0.75, attack: 0.25

    in_thread do
      sleep 4
      eggs01
    end

    sample SAMPLES, "we_are_floating", attack: 2, amp: 0.75

    sleep sample_duration SAMPLES, "we_are_floating", attack: 2
  end
end

live_loop :spacewind do
  cue :spaceywind
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

cue :spaceywind
eggs02


  at 16 do

      # load_sample SAMPLES, "revolver_fearme"
      # load_sample SAMPLES, "revolver_roofgolf"

      with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, invert_wave: 1, wave: 3, pre_mix: 0.4 do
        with_fx :reverb, mix: 0.4, room: 0.9 do
          with_fx :level, amp: 2 do
            with_fx :mono do
              sample SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503
            end
          end
        end
      end

      derpderp = sample_duration SAMPLES, "revolver_roofgolf", start: 0.14, finish: 0.15

      sleep derpderp - 0.20

      play :a2, attack: 2, sustain: 1, release: 2, pitch: 0, slide: 4 do |x|
        control x, pitch: -12, note: :a2
      end
      sleep 4

      in_thread do
        sleep 3
        sample SAMPLES, "kronos_tense"
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

      sleep 12


      ampr = 0.2

      with_fx :level, amp: 0, amp_slide: 4 do |x|
        control x, amp: ampr

        with_fx :reverb, room: 1, damp: 0.2 do

          sample SAMPLES, "roy", start: 0.25, finish: 0.312, rate: 1, pan: -0.8, pan_slide: 2 do |p|
            control p, pan: 0.8
          end

          sample SAMPLES, "roy", slice: 10, num_slices: 16, rate: 1, pan: 0.8, pan_slide: 2 do |p|
            control p, pan: -0.8
          end

          #morty - what the  hell, woah
          sample SAMPLES, "roy", start: 0.625, finish: 0.64, rate: 1, pan: -0.8, pan_slide: 2 do |p|
            control p, pan: 0.8
          end

          sample SAMPLES, "roy", slice: 14, num_slices: 16, rate: 1, pan: 0.8, pan_slide: 2 do |p|
            control p, pan: -0.8
          end

          sample SAMPLES, "roy", start: 0.903, finish: 0.9378, rate: 1, pan: -0.8, pan_slide: 2 do |p|
            control p, pan: 0.8
          end

        end

      end

      in_thread do
        sync :spiral
        with_fx :echo, phase: 0.8, decay: 5, amp_slide: 1 do |e|
          control e, amp: 0.75
          sample SAMPLES, "roy", lpf: 80, start: 0.305, finish: 0.3125, rate: 1, pan: -0.8, pan_slide: 2 do |p|
            control p, pan: 0.8
          end
        end
      end

      in_thread do
        sleep 12
        sample SAMPLES, "110FollowtheLine",
        slice: 4, num_slices: 10, attack: 0.5, release: 0.5, pan: -0.2, pan_slide: 4 do |p|
          control p, pan: 0.2
        end

        sample SAMPLES, "110FollowtheLine", slice: 5, num_slices: 10, attack: 0.5, release: 1, rate: -1, pan: -1, amp: 0.25

        sample SAMPLES, "110FollowtheLine", start: 0.6, finish: 0.72, attack: 2, release: 2.5, rate: -1, pan: 1, amp: 0.25

      end

      sleep 24


    in_thread(name: :hellofriend01) do
      cue :spiral
      sleep 8
      #load_sample SAMPLES, "01hellofriend"
      hellofriend02
    end

  end

  # at 30 do
  #   @agring = in_thread do
  #
  #     loop do
  #       ambi_glass_ring
  #       sleep 2
  #     end
  #   end
  #
  # end


at 60 do
  in_thread do

    with_fx :reverb, room: 0.6, damp: 0.2 do


      with_fx :level, amp: 0.5 do
        #you made it really hard for anyone to see it
        sample SAMPLES, "sawit", start: 0, finish: 0.6
        sleep sample_duration SAMPLES, "sawit", start: 0, finish: 0.6

        sleep 0.5

        #its good,
        sample SAMPLES, "itsgood", start: 0, finish: 0.10
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


# at 68 do
#
#   live_loop :heartbeat do
#       heartbeat
#       sleep 1
#   end
#
# end



at 75 do

  live_loop :jazzy do

    2.times do |x|

      with_fx :band_eq, freq: 112, db: 6, res: 0.6 do
        with_fx :level, amp: 2 do
          with_fx :bitcrusher, cutoff: 40, pre_mix: 0.5 do
            with_fx :lpf, cutoff: 60 do
              sample SAMPLES, "209RoundMidnight", hpf: 45, start: 0.25, finish: 0.2791, attack: 2, release: 0.5, rate: range(1, -1, step: 2, inclusive: true).tick
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

end



at 98 do

  #@agring.kill
  sleep 16
  in_thread do
    use_bpm 60

      weallare

  end


end

live_loop :ahee do

  sample PERCS, "EE_Hat_Op_Dirty" if spread(1,8).tick

  # sample electric_empire, "EE_Hat_Cl_Dirty" if spread(5,11).look
  #
  sample PERCS, "35bass" if spread(3,8).look

  sample PERCS, "35bass" if spread(7,11).look

  sample PERCS, "35bass" if spread(1,4).look

  sleep S

end


# at 104 do
#
#
#   live_loop :bassinyerface do
#     use_bpm 60
#
#     sync :tick
#
#     cue :bassface
#
#     #boost a few db in the 73Hz range
#     #brings out a nice boomy 35bass
#     with_fx :reverb, room: 0.4, damp: 0.6, pre_mix: 0.8 do
#       with_fx :level, amp: 0.10 do
#         with_fx :rhpf, cutoff: 28 do
#           live_loop(:hh) do
#             with_fx :level, amp: 0.30 do
#               cue :heartbeatx
#               #play_hydro_seq(distribute(3, 16), "sim_k02-0")
#               with_fx :pan, pan: -0.8, pan_slide: 1.5 do |balls|
#                 control balls, pan: 0.8
#                 play_hydro_seq(distribute(9, 16), "chh_2")
#               end
#
#
#             end
#           end
#
#           live_loop(:bd) do
#             sync :heartbeatx
#
#             with_fx :band_eq, freq: 38, db: 6, res: 0.6 do
#               play_hydro_seq(distribute(7, 16), "VP 35bass 2")
#             end
#
#           end
#
#           live_loop(:sn) do
#             with_fx :level, amp: 0.8 do
#               cue :heartbeatx
#
#               play_hydro_seq(distribute(2, 16).to_a.rotate(4), "sim_k02-0_1")
#             end
#           end
#         end
#       end
#     end
#
#   end #end bassinyerface
#
# end




at 108 do

with_fx :level, amp: 0.8 do
    with_fx :reverb, room: 0.8, pre_mix: 0.8, damp: 0.4 do
      in_thread do

        live_loop :ghostface do
          # load_sample SAMPLES, "000248ghostsofthingstcome"
          #sync :heartbeatx

          range(1,8,inclusive:true).each do |x|

            if x.to_i.odd?
              pmin = -0.8
              pmax = -0.4
            else
              pmin = 0.8
              pmax = 0.4
            end

            with_fx :panslicer, wave: 1, pan_min: pmin, pan_max: pmax, smooth_up: 0.8, smooth_down: 0.8, pulse_width: 1 do
                s = sample_duration SAMPLES, "000248ghostsofthingstcome", slice: 1, num_slices: 8, attack: 0.5, release: 0.5
                pants = s.round(1)
                puts pants
                sample SAMPLES, "000248ghostsofthingstcome", amp: 0.25, slice: x, num_slices: 8, attack: 0.5, release: 0.5


                sleep s.round(1)
            end

         end
         #stop
        end
      end
    end
  end
end #end at 108


# 185 seconds overall


at 122 do

  in_thread name: :soundscape do
    #load_sample SAMPLES, "403982_klankbeeld_ped_nl"
      sample SAMPLES, "403982_klankbeeld_ped_nl", attack: 2, release: 8, start: 0.08, finish: 0.56, pan: -1, pan_slide: 16 do |p|
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

  live_loop :estatic do

      #panner = range(-0.8,0.8, step: 0.125, inclusive: true)
      #load_sample SAMPLES, "SCSS-Sequence-08"
      with_fx :panslicer, amp_min: 0.1, amp_max: 0.4, pan_min: -0.8, pan_max: 0.8,
      smooth_up: 1.5, smooth_down: 1.5 do
        with_fx :mono do
          sample EFFECTS, "SCSS-Sequence-08", attack: 2, release: 0.25, pre_amp: 0.05
        end
      end

      sleep sample_duration EFFECTS, "SCSS-Sequence-08", attack: 2, release: 0.25
      sleep 4

  end


end

#### end of part one.

#### transition #####


at 240 do

  in_thread do
    ampr = 0.5

    with_fx :level, amp: 0, amp_slide: 4 do |a|
      control a, amp: ampr

      live_loop :oldtree do
        lakeofdreams
      end
      sleep 1
    end
  end

end

at 260 do
  hellofriend01
end


#######################
##### begin part ii
######################
