set_mixer_control! hpf: 21

run_file "/home/b08x/workspace/projects/seshmon/sessions/robotjazz/introduction.rb"
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



load_sample SAMPLES, "wrongrules"
load_sample SAMPLES, "sawit"
load_sample SAMPLES, "itsgood"

with_fx :sound_out_stereo, output: 3, amp: 0 do



  #that im not a kid anymore
  #sample SAMPLES, "whatcharealizing", start: 0.29, finish: 0.451

  #thats harsh
  # sample SAMPLES, "whatcharealizing", start: 0.45, finish: 0.55

  #i knew i was an adult, the day the judge said i''m trying you as an adult
  #sample SAMPLES, "whatcharealizing", start: 0.55, finish: 1


# fade in to wobbly vinyl hiss
@hissloop = in_thread(name: :hiss_loop) do

  ampr = 0.7

  with_fx :level, amp: 0, amp_slide: 8 do |a|
    control a, amp: ampr

    loop do
      hiss
    end

  end
end

sleep 8

in_thread do
  eggs01
end


with_fx :reverb, room: 0.8, damp: 0.5 do
  ampr = 0.8
  with_fx :level, amp: 0, amp_slide: 2 do |a|
    control a, amp: ampr
    #whatcha realizing jerk
    sample SAMPLES, "whatcharealizing", start: 0, finish: 0.27,  amp: 0.75, attack: 0.25

    sample SAMPLES, "we_are_floating", attack: 2, amp: 0.5

    sleep sample_duration SAMPLES, "we_are_floating", attack: 2
  end
end

eggs02




  at 16 do

    in_thread(name: :hellofriend01) do
      load_sample SAMPLES, "01hellofriend"
      hellofriend01

    end
  end

  at 20 do
    @agring = in_thread do

      loop do
        ambi_glass_ring
        sleep 2
      end
    end

  end


at 36 do
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
        sleep 0.5
        slipperyslope
      end
      #so good it scratched that part of my mind
      sample SAMPLES, "itsgood", start: 0.11, finish: 0.25


    end
    sleep sample_duration SAMPLES, "itsgood", start: 0.11, finish: 0.25
  end

  end
end

end #end of sound_out



at 48 do

  live_loop :heartbeat do
    with_fx :sound_out_stereo, output: 5, amp: 0 do
      heartbeat
    end
    sleep 1
  end

end


at 84 do.

with_fx :sound_out_stereo, output: 3, amp: 0 do
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

end



at 98 do

  @agring.kill
  sleep 16
  in_thread do
    use_bpm 60
    with_fx :sound_out_stereo, output: 3, amp: 0 do
      weallare
    end
  end


end

at 104 do
  live_loop :heartbeat do
    stop
  end
end


at 108 do

  with_fx :sound_out_stereo, output: 3, amp: 0 do
    with_fx :reverb, room: 0.5, pre_mix: 0.5, damp: 0.4 do
      in_thread do
        use_bpm 60
          ghosts01
          #hellofriend02
      end

      # in_thread do
      #   winterghosts
      # end
    end
  end
end #end at 108

# 185 seconds overall
load_sample SAMPLES, "403982_klankbeeld_ped_nl"
load_sample SAMPLES, "SCSS-Sequence-08"


at 122 do

  live_loop :basshit, auto_cue: false do

    sync :tick
    cue :introbass

    with_fx :sound_out_stereo, output: 5, amp: 0 do
      with_fx :rhpf, cutoff: 28 do
        with_fx :level, amp: 0.30 do
          3.times do
            sample DRUM_KITS, "808_Kick_long", attack: 0.005
            sleep 1
          end

          2.times do
            sample DRUM_KITS, "808_Kick_long", attack: 0.005
            sleep 0.5
          end
        end
      end
    end #end sound_out

    sleep 4

  end #end live_loop

  in_thread name: :soundscape do

    with_fx :sound_out_stereo, output: 3, amp: 0 do

      sample SAMPLES, "403982_klankbeeld_ped_nl", attack: 2, release: 2, start: 0.08, finish: 0.60, pan: -1, pan_slide: 16 do |p|
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

  end

  sleep 8

  live_loop :estatic do
    with_fx :sound_out_stereo, output: 3, amp: 0 do
      #panner = range(-0.8,0.8, step: 0.125, inclusive: true)

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


end

#### end of part one.

#### transition #####
at 235 do
  live_loop :basshit do
    stop
  end
end

at 240 do

  with_fx :sound_out_stereo, output: 3, amp: 0 do
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

end
