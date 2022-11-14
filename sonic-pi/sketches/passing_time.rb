set_mixer_control! hpf: 21

run_file "/home/b08x/workspace/projects/seshmon/lib/bass/wooble.rb"
run_file  "/home/b08x/workspace/projects/seshmon/lib/io/inputs.rb"
# global config
use_bpm 110



# yoshimi
# linux_sampler

load_sample SAMPLES, "110FollowtheLine"


at 8 do

  with_fx :sound_out_stereo, output: 3, amp: 0 do

    ampr = 0.1

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

        sample SAMPLES, "roy", start: 0.903, finish: 0.9376, rate: 1, pan: -0.8, pan_slide: 2 do |p|
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




  end #end of sound_out_stereo

end

at 16 do
  # fade in to the forcefield expanding and contracting

  @intro = in_thread(name: :forcefield) do
    use_bpm 60
    with_fx :sound_out_stereo, output: 1, amp: 0 do
      ampr = 0.35

      with_fx :level, amp: 0, amp_slide: 8 do |a|
        control a, amp: ampr
          with_fx :ixi_techno, cutoff_min: 40, cutoff_max: 50, phase: 0.8, res: 0.3 do
          with_fx :ring_mod, freq: rrand(30,34), freq_slide: 5 do |f|
            control f, freq: rrand(30,34)
              wob(32, 3, 18)
            end
          end

      end
    end

  end

end

with_fx :sound_out_stereo, output: 3, amp: 0 do

#at 20 do

  with_fx :level, amp: 0.075 do

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

  #end



end


at 60 do
  with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, invert_wave: 1, wave: 3, pre_mix: 0.4 do
    with_fx :reverb, mix: 0.4, room: 0.9 do
      with_fx :level, amp: 0.8 do
        with_fx :mono do
          sample SAMPLES, "robin_williams_snuckthruforcefield", attack: 0.25, rate: 1
        end
      end
    end
  end
end

########################

at 88 do

  12.times do |x|
    tick

    if look.to_i.odd?
      pside = -0.8
    else
      pside = 0.8
    end

    with_fx :bpf, centre: 120, res: 0.5 do
      with_fx :reverb, room: 0.6, pre_mix: 0.8 do
        sample SAMPLES, "freq01", attack: 0.5, slice: x, num_slices: 12, pan: 0, pan_slide: 4, amp: 3 do |p|
          control p, pan: pside
        end
      end
    end

    sleep sample_duration SAMPLES, "freq01", attack: 0.5, slice: x, num_slices: 12

  end

end


end #end of sound_out_stereo 3



at 128 do

  with_fx :rhpf, cutoff: 40, res: 0.3 do
    with_fx :band_eq, freq: 45, res: 0.8, db: -1 do
      with_fx :reverb, room: 0.75, damp: 0.4, pre_mix: 0.6 do


      live_loop :kick_drum do

        loop do
          with_fx :sound_out_stereo, output: 5, amp: 0 do
            with_fx :band_eq, freq: 36, db: 2, res: 0.6 do
              sample SAMPLES, "K-015 Dry 1", pan: 0
            end
          end
          sleep 0.75
          with_fx :sound_out_stereo, output: 3, amp: 0 do
            sample SAMPLES, "37-Sidestick2-2"
            sleep 0.75
            sample SAMPLES, "37-Sidestick2-1"
            sleep 1
            sample SAMPLES, "37-Sidestick2-1"
            sleep 1.5
          end
        end
      end

      live_loop :snare_drum do
        sleep 16
        loop do
          sleep 1
          with_fx :sound_out_stereo, output: 3, amp: 0 do
            sample SAMPLES, "Classic-626_Tambourine"
          end
          sleep 1
        end
      end


    end #end reverb
    end # end bandeq
    end #end of rhpf for rhythm section


end #end at 64

#end #end of main eq
