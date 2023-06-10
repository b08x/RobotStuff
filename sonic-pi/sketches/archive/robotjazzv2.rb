######
#
######
run_file "/home/b08/workspace/seshmon/sessions/robotjazz/introduction.rb"

use_debug true


set_mixer_control! hpf: 21
set_volume! 2
use_bpm 60

in_thread do
  loop do
    cue :tick
    sleep 0.5
  end
end




with_fx :lpf, cutoff: 110 do
  #with_fx :tremolo, phase: 0.25, wave: 3 do
    with_fx :reverb, room: 0.8, damp: 0.3 do
      live_audio :qsamp, input: 5, stereo: true, amp: 0.6
    end
  #end
end


at 0 do

  @olthymeamp = 0.3
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

end

#1 computer noises
at 4 do

  8.times do |x|
    sample SAMPLES, "puter", slice: x, num_slices: 8, pan: rrand(-0.4,-0.8), pan_slide: 0.5 do |p|
      control p, pan: rrand(0.4,0.8)
    end
    sleep sample_duration SAMPLES, "puter", slice: x, num_slices: 8
  end

end


at 8 do
    #46.95
    in_thread do

        #sample SAMPLES, "bfleck_djaryjam", slice: 0, num_slices: 8, amp: 0.2
        8.times do |x|

          if x == 7
            rls = 1
          else
            rls = 0.125
          end

          hodr = range(-1,1,step: 0.125, inclusive: true).tick

          with_fx :bpf, centre: 90, res: 0.8 do
            with_fx :mono, pan: hodr, pan_slide: 1 do |p|

              sample SAMPLES, "bfleck_djaryjam", slice: x, num_slices: 64, amp: 0.45, release: rls, pitch_dis: 0.001
              sleep sample_duration SAMPLES, "bfleck_djaryjam", slice: x, num_slices: 64, amp: 0.8, release: rls, pitch_dis: 0.001

            end
          end

        end

    end

    #5.9 x 9 =54
    sleepypants = sample_duration SAMPLES, "wedrankthewater", start: 0.825, finish: 0.97, attack: 2, release: 0.3, rate: 0.5

    with_fx :level, amp: 0, amp_slide: 6 do |a|
      control a, amp: 0.42
      9.times do |x|
        if x == 8
          control a, amp: 0, amp_slide: 0.28
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

end#end of at8


at 12 do

  @laughamp = 0.3
    with_fx :level, amp: 0, amp_slide: 0.125 do |x|
    loop do
      control x, amp: @laughamp
      sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 0.5, release: 0.5, rate: 1
      sleep sample_duration SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 0.5, release: 0.5
    end
  end

end

at 32 do
    with_fx :reverb, room: 0.8, damp: 0.3 do
      # # "but we drank the water"
      sample SAMPLES, "wedrankthewater", start: 0.28, finish: 0.35, amp: 0.3, attack: 0.45

      sleep 8

      # # "yeah"
      with_fx :panslicer, smooth: 1 do
      with_fx :echo, phase: 2, decay: 0.25 do
        sample SAMPLES, "wedrankthewater", start: 0.44, finish: 0.5, amp: 0.5
      end
end

    end

      @laughamp = 0.6
    end
end


######################

at 48 do

  with_fx :reverb, room: 0.8, damp: 0.4 do

    #ampr = 1
    #with_fx :level, amp: 0, amp_slide: 1 do |a|
      #control a, amp: ampr
      #whatcha realizing jerk
      # with_fx :bpf, res: 0.6, pre_mix: 0.4 do
      #       with_fx :mono, amp: 0.8, pan: -0.8 do
      #         sample SAMPLES, "whatcharealizing", start: 0, finish: 0.27
      #       end
      #
      #       with_fx :mono, amp: 0.8, pan: 0.8 do
      #         sample SAMPLES, "whatcharealizing", start: 0, finish: 0.27
      #       end
      # end


      in_thread do
        sleep 4
        eggs01
      end

      in_thread do
        sleep 4
        with_fx :mono, pan: 0.8 do
          sample SAMPLES, "bfleck_spiritsong", start: 0.0164, finish: 0.0285
        end
      end

      in_thread do

        sleep 8
        with_fx :level, amp: 0, amp_slide: 4 do |a|
          control a, amp: 1
          with_fx :mono, pan: -0.8 do
            sample SAMPLES, "trillo", amp: 1, attack: 1, release: 2
          end

          with_fx :mono, pan: 0.8 do
            sample SAMPLES, "trillo", amp: 1, attack: 1, release: 2
          end
        end

      end

      with_fx :band_eq, freq: 69, res: 0.3, db: -15 do

          #sample SAMPLES, "we_are_floating", attack: 2, amp: 0.75, pitch_dis: 0.001, time_dis: 0.1
          sample SAMPLES, "we_are_floating", attack: 2, amp: 0.75, cutoff: 110
          sleep sample_duration SAMPLES, "we_are_floating", attack: 2
          #5 just a second before this cuts out
      end
    #end

  end

  cue :ee_kick1
end #end at48 - measure 12 assuming we are operating in 4/4


##################################



# at 60 do

#   @bdamp = 0.6
#   with_fx :rlpf, cutoff: 30, res: 0.6 do
#     with_fx :rhpf, cutoff: 35, res: 0.6 do
#       with_fx :level, amp: 0, amp_slide: 1 do |a|

#         with_fx :reverb, room: 0.8, damp: 0.2 do
#           with_fx :band_eq, freq: 37, db: -5, res: 0.6 do
#             @ee_kick = in_thread do
#               loop do
#               control a, amp: @bdamp
#                cue :bassdruum
#                use_bpm 45
#                 with_fx :mono, pan: 0 do
#                   sample SAMPLES, "EE_Kick_Hard_1" if (spread 4, 8).tick
#                   sleep sample_duration SAMPLES, "EE_Kick_Hard_1"
#                 end
#               end
#             end
#           end
#         end
#       end
#     end #end rhpf
#   end

#   @hatsamp = 0.6
#   with_fx :level, amp: 0, amp_slide: 1 do |a|
#     @hats = in_thread do
#       loop do
#         control a, amp: @hatsamp
#         use_bpm 45
#         sync :bassdruum
#           #note = ring(:b1,:d2).tick
#           if (spread 5, 8).look then
#             # (spread 3, 8) produces this pattern: * _ _ * _ _ * _
#             with_fx :hpf, cutoff: 46 do
#               with_fx :rlpf, cutoff: 80, res: 0.5 do
#                 with_synth :mod_beep do
#                   play :b1, amp: @hatsamp,
#                     attack: 0.1, decay: 0.08, release: 0.1
#                 end
#               end
#             end
#           end
#           sleep 0.25
#       end
#     end
#   end

# end

at 68 do
  eggs02
end

at 76 do
  @bdamp = 0
end

at 78 do

  with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, invert_wave: 0, wave: 3, pre_mix: 0.4, smooth: 0.25, phase: 0.25 do
    with_fx :reverb, room: 0.6, damp: 0.2 do
      with_fx :level, amp: 1 do
        with_fx :mono do
          sample SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503, time_dis: 97, pitch_dis: 0.001
          pq = sample_duration SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503
          sleep pq

        end
      end
    end
  end

  cue :headgames

end

at 82 do

  with_fx :mono, pan: -0.9, pan_slide: 1.75 do |x|
    control x, pan: 0.9
    sample SAMPLES, "mahnamahna", start: 0.0670, finish: 0.078, attack: 0.25, release: 0.25
    sleep sample_duration SAMPLES, "mahnamahna", start: 0.0670, finish: 0.078, attack: 0.25, release: 0.25
  end

  cue :derp

end

# at 86 do
# #seeing stars
#   @woodpeckeramp = 0.8
#   with_fx :level, amp: 0, amp_slide: 4 do |a|
#     @woodpecker = in_thread do
#       loop do
#         control a, amp: @woodpeckeramp
#         with_fx :ixi_techno, cutoff_min: 110, cutoff_max: 120, phase: 4, res: 0.4, pre_mix: 0.5 do
#           with_fx :mono, pan: 0, pan_slide: 2 do |p|
#             sample SAMPLES, "radiohead_givingupghost.wav", start: 0.002, finish: 0.012, attack: 0.5, rate: 1
#           end
#         end
#         sleep 2
#         play :a1, amp: 0.5
#         sleep 0.5
#       end
#     end
#   end
#
# end

at 94 do

  cue :pianojam

end
#
# at 102 do
#
#   @woodpeckeramp = 0
#   sleep 2
#   @woodpeck.kill
#
# end

at 104 do

  with_fx :reverb, room: 0.8, damp: 0.3 do
    with_fx :ixi_techno, cutoff_min: 40, cutoff_max: 60, phase: 0.125, res: 0.3, pre_mix: 0.8 do
      sample SAMPLES, "goingupelevator", start: 0.095, finish: 0.95, amp: 1.75, rate: 1.25, pitch: -12, attack: 0.5, release: 1, pan: -0.8, pan_slide: 8, rpitch: (scale 1, :major).tick do |x|
        control x, pan: 0.8
        wait 8
        control x, pan: -0.8
        wait 8
        control x, pan: 0
      end
    end
  end

end

at 126 do

  with_fx :lpf, cutoff: 90 do
    with_fx :reverb, room: 0.6, damp: 0.3 do
      #morty - what the  hell, woah
      sample SAMPLES, "roy", amp: 0.23, attack: 1, attack_level: 0.5, start: 0.625, finish: 0.638, rate: 1, pan: -0.8, pan_slide: 1.5 do |p|
        control p, pan: 0.8
      end
    end
  end

end

at 128 do
  @bdamp = 0.3
end

at 130 do
  with_fx :panslicer, pan_max: 0.8, pan_min: -0.8, phase: 2, smooth: 0.25 do |x|
   with_fx :rlpf, cutoff: 95, res: 0.4 do
     with_fx :reverb, room: 0.6, damp: 0.3 do
       with_fx :mono do
         sample SAMPLES, "kronos_tense", attack: 0.5, amp: 0.7
         wait 8
         control x, pan_max: 0, pan_min: 0
       end
     end
   end
 end
end

at 136 do

  @hatsamp = 0.4
  with_fx :level, amp: 0, amp_slide: 1 do |a|
    @hats = in_thread do
      loop do
        control a, amp: @hatsamp
        use_bpm 45
        sync :bassdruum
          #note = ring(:b1,:d2).tick
          if (spread 5, 8).look then
            # (spread 3, 8) produces this pattern: * _ _ * _ _ * _
            with_fx :hpf, cutoff: 46 do
              with_fx :rlpf, cutoff: 80, res: 0.5 do
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
  end

end

at 140 do

  in_thread do
    @bdamp = 0.3
    @hatsamp = 0.3
  end


  with_fx :reverb, room: 0.7, damp: 0.2 do
    with_fx :level, amp: 0.6 do
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
      sleep sample_duration SAMPLES, "itsgood", start: 0.11, finish: 0.25
    end
  end

  cue :crazypants

end

at 150 do

  with_fx :ring_mod, freq: 60, pre_mix: 0 do |f|
    with_fx :bitcrusher, cutoff: 72, pre_mix: 0.8 do |b|
      with_fx :echo, phase: 0.4, decay: 12, pre_mix: 0 do |x|
        with_fx :rlpf, cutoff: 100, res: 0.6 do
          #cos, what is reality?
          with_fx :mono, pan: -0.2, amp: 0.9, pan_slide: 0.5 do |p|
            control p, pan: -1
            sample SAMPLES, "robin_williams_fullgooseboozo_whatisreality", attack: 0.25, start: 0.85, finish: 1
          end

          #cos, what is reality?
          with_fx :mono, pan: 0.2, amp: 0.9, pan_slide: 0.5 do |q|
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

  cue :bozo

end

at 154 do
  @bdamp = 0
  @hatsamp = 0
end

###########################
### end introduction act 1
###########################


####
# intermission
###

at 178 do

  with_fx :reverb, room: 0.6, damp: 0.3 do
    with_fx :mono, pan: 0.2 do
      sample SAMPLES, "isthiswhathappenswhenyoudie", attack: 0.25
    end
  end

 end
#
 at 180 do

  with_fx :reverb, room: 0.8, damp: 0.3 do
    # water no get enemy
    with_fx :level, amp: 0, amp_slide: 8 do |a|
      control a, amp: 0.7

      s = sample_duration SAMPLES, "feli_kuti_water_no_get_enemy", start: 0.665, finish: 0.683, attack: 1, release: 1

      t = sample_duration SAMPLES, "feli_kuti_water_no_get_enemy", start: 0.685, finish: 0.7, attack: 1, release: 1

      with_fx :bpf, centre: 85, res: 0.8 do
        with_fx :mono, pan: -0.5 do
          sample SAMPLES, "feli_kuti_water_no_get_enemy", start: 0.665, finish: 0.683, attack: 1, release: 1
        end
        with_fx :mono, pan: -0.5 do
          sample SAMPLES, "feli_kuti_water_no_get_enemy", start: 0.665, finish: 0.683, attack: 1, release: 1
        end
      end

      sleep s.round(2)

#sample SAMPLES, "feli_kuti_water_no_get_enemy", amp: 0.75

      with_fx :level, amp: 1, amp_slide: 0.5 do |n|
        with_fx :echo, phase: 0.25, decay: 16, pre_mix: 0 do |e|
          with_fx :bpf, centre: 80, res: 0.8 do
            with_fx :mono, pan: -0.2 do
              sample SAMPLES, "thisiswhathappenswhenyooudie.wav", attack: 0.25, amp: 10
              wait 1.25
              control e, pre_mix: 1
              wait 0.25
              control n, amp: 0
            end
          end
        end
      end



      with_fx :bpf, centre: 85, res: 0.8 do

        control a, amp: 0.25

        with_fx :mono, pan: 0.5 do
          sample SAMPLES, "feli_kuti_water_no_get_enemy", start: 0.685, finish: 0.7, attack: 2, release: 1
        end

        with_fx :mono, pan: 0.5 do
          sample SAMPLES, "feli_kuti_water_no_get_enemy", start: 0.685, finish: 0.7, attack: 2, release: 1
        end
      end

      sleep t.round(2) - 1

      control a, amp: 0

    end

  end #end of reverb

end

####
# end intermission
####


###
# begin act 2
###

at 208 do
   hellofriend02
end

at 210 do
  2.times do |x|
    with_fx :band_eq, freq: 112, db: 6, res: 0.6 do
      with_fx :level, amp: 1.5 do
        with_fx :bitcrusher, cutoff: 40, pre_mix: 0.5 do
          with_fx :lpf, cutoff: 60 do
            sample SAMPLES, "209RoundMidnight", hpf: 45, start: 0.25, finish: 0.2791, attack: 2, release: 1, rate: range(1, -1, step: 2, inclusive: true).tick
          end
        end
      end
    end
    sleep 8
  end
end


at 218 do
  with_fx :rhpf, cutoff: 80 do
    with_fx :level, amp: 0.45 do
      with_fx :reverb, mix: 0.2, room: 1 do
        sample SAMPLES, "we_are_dreaming", attack: 1, slice: 0, num_slices: 2, pan: -1, pan_slide: 2 do |p|
          control p, pan: 1
        end
      end
    end
  end
end

at 230 do
  with_fx :level, amp: 1.5 do
    weallare
  end
end

at 234 do
  @bdamp = 0.3
  @hatsamp = 0.1
end

at 246 do

  with_fx :level, amp: 1 do
    with_fx :eq,
    low_shelf: -0.5, low_shelf_note: 41, low_shelf_slope: 0.5,
    low: -1, low_note: 62, low_q: 0.9,
    mid: -0.125, mid_note: 74, mid_q: 0.7,
    high: 0, high_note: 72, high_q: 0.6,
    high_shelf: 0.25, high_shelf_note: 103, high_shelf_slope: 0.2 do

          with_fx :reverb, room: 0.8, pre_mix: 1, damp: 0.3 do
            in_thread do
              sync :bassdruum
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

    end#end eq high shelf
  end

  #cue :moreghosts

end

at 254 do
  @fish = in_thread do
    #load_sample SAMPLES, "403982_klankbeeld_ped_nl"
    sample SAMPLES, "403982_klankbeeld_ped_nl", amp: 0.6, attack: 8, release: 8, start: 0.08, finish: 0.56, pan: -1, pan_slide: 16 do |p|
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

at 350 do

  @hatsamp = 0
  @bdamp = 0.2

end
