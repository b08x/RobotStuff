

def hiss
  with_fx :slicer, wave: 3, smooth: 0.10 do
    with_fx :tremolo do
      sample :vinyl_hiss, amp: 0.85, amp_slide: 8, rate: 0.5, attack: 3, sustain: 4, sustain_level: 0.8,
                          release: 1, pan: rrand(-0.8, 0.8), pan_slide: 8 do |hiss|
        control hiss, pan: rrand(-0.8, 0.8)
      end
      sleep 8
    end
  end
end

def hellofriend01
  with_fx :rhpf, cutoff: 80 do
    with_fx :level, amp: 1 do
      with_fx :reverb, mix: 0.2, room: 1 do
          sample SAMPLES, "hellofriend", start: 0, finish: 0.125, rate: 0.95, pan: -1, pan_slide: 4 do |p|
            control p, pan: 1
          end
      end
    end
  end
end

def chipnois
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
end
# def onlyinmyhead
#   with_fx :rhpf, cutoff: 60 do
#     with_fx :level, amp: 0.5 do
#       with_fx :reverb, mix: 0.2, room: 1 do
#           sample SAMPLES, "01hellofriend", start: 0.54, finish: 0.686, attack: 0.75, release: 0.125, rate: 1, pan: 0, pan_slide: 0.25 do |p|
#             control p, pan: 0
#           end
#       end
#     end
#   end
# end

# sample SAMPLES, "kronos_winterLux", amp: 0.25, slice: x, num_slices: 20, attack: 0.5, release: 0.5

def slipperyslope

    with_fx :rhpf, cutoff: 40 do
      with_fx :echo, pre_mix: 0.7, phase: 0.125, decay: 0.9, amp_slide: 10 do |e|
        control e, amp: 0.125

        with_fx :level, amp: 0.9 do
          sample SAMPLES, "01hellofriend", start: 0.5, finish: 0.55, attack: 0.125, release: 0.125, rate: 0.98, pan: -0.8, pan_slide: 0.75 do |p|
            control p, pan: 0.8
          end

        end
    end
  end
end



def ambi_glass_ring
    with_fx :level, amp: 0.5 do
        with_fx :pitch_shift, pitch: 0 do |pitch|
            control pitch, pitch_slide: 0.5, pitch: rrand(12,-12)

            with_fx :rlpf, cutoff: 60 do
              with_fx :echo, decay: 1.5, phase: 0.50 do
                with_fx :ring_mod, freq: 48 do |ring|
                  control ring, freq_slide: 0.25, freq: rrand(30,36)
                  sample :ambi_glass_hum, attack: 0.75, decay: 0.75, release: 1.5, rate: -0.5, amp: 0.25
                end
              end
            end
        end
    end
end



def hellofriend02
    with_fx :pan, pan: 1, pan_slide: 2 do |p|
      control p, pan: -1
      with_fx :reverb, mix: 0.2, room: 1 do
        with_fx :echo, mix: 0.1, phase: 0.55, decay: 6 do | fx_echo |
          sample SAMPLES, "01hellofriend", start: 0.155, finish: 0.25, amp: 0.45
        end
      end
    end
end

def heartbeat


    with_fx :pan, pan: 0, amp: 0.75 do
        with_fx :band_eq, freq: 44, res: 0.1, db: 1.5 do

          sample :bd_808, pre_amp: 1.75, lpf: 45, rate: 0.9 if spread(3,8).tick

          with_fx :ring_mod, freq: 38, freq_slide: 1 do |f|
            control f, freq: 32
            sample :bd_808, pre_amp: 1.75, lpf: 40, rate: 1.1 if spread(7,11).look
          end

          if spread(1,4).look
            with_fx :rhpf, cutoff: 25 do
              sample DRUM_KITS, "35bass_2", attack: 0.5, release: 0.5
              sleep sample_duration DRUM_KITS, "35bass_2", attack: 0.5, release: 0.5
            end
          end
        end
    end



end



def eggs01
  with_fx :pan, pan: -0.7 do
    with_fx :reverb, mix: 0.5, damp: 0.2, room: 6 do
      with_fx :echo, phase: 0.8, decay: 8, amp_slide: 10 do |e|
        control e, amp: 0.25
        with_fx :mono do
          sample SAMPLES, "donteattheeggs", start: 0.345, finish: 0.379, attack: 0.25, release: 0.125, amp: 0.8
        end
      end
    end
  end
end

def eggs02
  with_fx :pan, pan: 0.7 do
    with_fx :reverb, mix: 0.5, room: 6 do
      with_fx :level, amp: 2 do
        with_fx :mono do
          sample SAMPLES, "donteattheeggs", start: 0.435, finish: 0.456, attack: 1, rate: 1
        end
      end
    end
  end
end







def weallare
  #we all are

  with_fx :hpf, cutoff: 30 do
    with_fx :band_eq, freq: 92, db: -3, res: 0.3 do

          with_fx :reverb, mix: 0.5, damp: 0.2, room: 4 do
            with_fx :echo, phase: 2, decay: 0.35, amp_slide: 10 do |e|
              control e, amp: 0.125

                sample SAMPLES, "we_are_dreaming",
                attack: 0.25, slice: 1, num_slices: 2, amp: 0.8, pan: -0.7, pan_slide: 1 do |x|
                  control x, pan: 0.7
                end

            end
          end

      end
  end

end

def ambi_piano_sub
  2.times do
    with_fx :level, amp: 0.75 do
      with_fx :rlpf, cutoff: 80 do

        sample :ambi_piano, amp: 0.5, rate: -1, attack: 0.5, release: 0.5, pan: 0.8, pan_slide: 1.5, rpitch: (scale 1, :major).tick do |p|
          control p, pan: -0.8
        end

        sleep sample_duration :ambi_piano, rate: -1, attack: 0.5, release: 0.5
      end
    end
  end
end

def cool_bass_thumpy_sound(rpit)
  #not sure how or why, but when f-ing about, this particular method
  #when listened to with headphones especially,
  #gives the impressions of a semi truck
  #barrelling down the road right next to your house
  #it is definietly more the bass you can "feel" rather than hear.
  # sample :ambi_piano, amp: 1.5, rate: 0.5, pitch: -12, attack: 0.5, release: 0.5, pan: -0.8, pan_slide: 1.75, rpitch: (scale 1, :major).tick do |x|
  #   control x, pan: 0.8
  # end

  sample :ambi_piano, amp: 1.5, rate: 0.5, pitch: -12, attack: 0.5, release: 4, pan: -0.8, pan_slide: 1.75, rpitch: rpit do |x|
    control x, pan: 0.8
  end

  sleep sample_duration :ambi_piano, rate: -1, attack: 0.5, release: 0.5
end



def overture01(ons)
  load_sample SAMPLES, "0001SummerOverturekronos"
  #clamp_time = attack, slope_above needs to be smalller to limit
  #amp above threshold, leave slope_below at one as we dont want
  #to effect anything below the threshold. relax_time = release.
  #lower the threshold to compress as a lower amp
  with_fx :compressor,
            threshold: 0.3,
            clamp_time: 0.01, slope_above: 0.1,
            slope_below: 1, release: 0.01 do
    with_fx :echo,
              max_phase: 6, phase: 0.125,
              decay: 0.25, pre_mix: 0.5 do
      with_fx :panslicer,
                smooth_up: 0.8, smooth_down: 0.8,
                wave: 1, probability: 0.8,
                prob_pos: 0.5, pulse_width: 0.8,
                pan_min: -0.1, pan_max: 0.1 do
          with_fx :wobble,
                    cutoff_min: 40, cutoff_max: 2,
                    phase: 3, res: 0.60, wave: 1, invert_wave: 0,
                    pulse_width: 0.75, smooth_up: 0.8, smooth_down: 0.2,
                    mix: 0.90, amp: 1 do
            with_fx :band_eq,
                      freq: 42, db: 9, res: 0.3 do

                        # sample SAMPLES, "0001SummerOverturekronos",
                        # slice: 0, num_slices: 16, attack: 2, release: 2, amp: 3
                        #
                        # sleep sample_duration SAMPLES, "0001SummerOverturekronos",
                        # slice: 0, num_slices: 16, attack: 2, release: 2
                        sample SAMPLES, "0001SummerOverturekronos", onset: ons

                        sleep sample_duration SAMPLES, "0001SummerOverturekronos", onset: ons
            end
         end
      end
    end
  end
end #end of overture01 func

def overture02

    sample SAMPLES, "0001SummerOverturekronos",
    slice: 1.5, num_slices: 16, attack: 2, release: 2, amp: 1

    sleep sample_duration SAMPLES, "0001SummerOverturekronos",
    slice: 1.5, num_slices: 16, attack: 2, release: 2

end


def regularghosts
      sample SAMPLES, "ghosts", amp: 0.4, slice: 4, num_slices: 10, attack: 1.5, release: 1, pan: 0.8
end



def drums_lead_in

   #               1 &  2 &  3 &  4 &, 5,&
   cymbals = bools(0,0, 0,0, 0,0, 0,0, 0,0)
   hard    = bools(0,0, 1,0, 0,0, 1,0, 0,0)
   soft    = bools(0,1, 0,1, 1,1, 0,1, 0,0)
   kick    = bools(0,0, 1,0, 0,0, 1,0, 0,0)

  with_fx :reverb, room: 0.6 do

       16.times do
         tick
         if cymbals.look then
           if one_in(8) then
             sample DRUM_KITS, "EE_Hat_Op_Dirty", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, pan: rrand(-0.9,0.9)
           else
             sample DRUM_KITS, "EE_Hat_Op_Dirty", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, rate: -1, pan: rrand(-0.9,0.9)
           end
         else
           #sample SAMPLES, "EE_Hat_Cl_Dirty", amp: 0.5
        end

        with_fx :band_eq, freq: 38, db: 1.5, res: 0.3 do
          sample DRUM_KITS, "VP Kick 3", pan: 0.2, amp: 0.6, on: hard.look

          sample DRUM_KITS, "35bass_2", pan: -0.2, amp: 0.6, on: soft.look

          #sample SAMPLES, "Classic-808_Kick_long", lpf: 60, pan: 0, amp: 0.1, on: kick.look
        end

         sleep 0.25
       end

  end

end


def drums_mid01
  electric_empire = "/home/b08x/studio/resources/samples/drums/drumkits/ElectricEmpireKit/"

  load_samples electric_empire

  hip_hop2 = "/home/b08x/studio/resources/samples/drums/drumkits/HipHop-2/"

  load_samples hip_hop2
   #               1 e & a  2 e & a  3 e & a  4 e & a  5 e & a
   cymbals = bools(0,0,0,0, 0,1,0,1, 0,0,0,0, 0,1,1,0, 0,0,0,0)
   hard    = bools(0,0,0,0, 1,0,0,0, 0,0,0,1, 0,0,0,0, 1,0,0,0)
   soft    = bools(0,0,0,1, 0,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
   kick    = bools(0,1,0,0, 0,0,0,0, 1,1,0,0, 0,0,0,0, 0,1,0,0)

  with_fx :reverb, room: 0.6 do

       16.times do
         tick
         if cymbals.look then
           if one_in(8) then
             sample electric_empire, "EE_Hat_Op_Dirty", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, pan: rrand(-0.9,0.9)
           else
             sample electric_empire, "EE_Hat_Op_Dirty", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, rate: -1, pan: rrand(-0.9,0.9)
           end
         else
           #sample electric_empire, "EE_Hat_Cl_Dirty", amp: 0.5
        end

        with_fx :band_eq, freq: 38, db: 1.5, res: 0.3 do
          sample hip_hop2, "kick_2", pan: 0.8, amp: 0.6, on: hard.look

          sample hip_hop2, "kick_3", pan: -0.8, amp: 0.6, on: soft.look

          sample hip_hop2, "kick_4", lpf: 60, pan: 0, amp: 0.5, on: kick.look
        end

         sleep 0.25
       end

  end

end

#####

def spacewind

  with_fx :level, amp: 0.2, amp_slide: 8 do |a|
    @spacewind = in_thread do

      control a, amp: 1.3
      loop do
        16.times do
          tick
            with_fx :ixi_techno, cutoff_min: 24, cutoff_max: 42, res: 0.8, phase: 0.25 do
              with_fx :band_eq, freq: 41, db: 8, res: 0.25 do
                sample SAMPLES, "we_are_floating", start: 0.56, finish: 1, beat_strech: 4, attack: 0.25, sustain: 4, release: 0.25, pan: 0, pan_slide: 4 do |p|
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

#spacewind

#@spacewind.kill

####

def lakeofdreams

  soundly = sample_duration SAMPLES, "10TimeTheOldTreeWithWindingRootsBehindtheLakeofDreamsmix", slice: 1, num_slices: 28,  attack: 0.5, decay: 0.25, release: 0.5

  with_fx :reverb, room: 0.8, damp: 0.5, pre_mix: 0.8 do

    with_fx :pan, pan: 1 do
      sample SAMPLES, "10TimeTheOldTreeWithWindingRootsBehindtheLakeofDreamsmix", slice: 1, num_slices: 28,  attack: 0.5,  decay: 0.25, release: 0.5, amp: 0
    end

    with_fx :pan, pan: -1 do
      sample SAMPLES, "10TimeTheOldTreeWithWindingRootsBehindtheLakeofDreamsmix", slice: 2, num_slices: 28,  attack: 0.5,  decay: 0.25, release: 0.5, rate: -1, amp: 0.75
    end

  end


  sleep soundly

end
