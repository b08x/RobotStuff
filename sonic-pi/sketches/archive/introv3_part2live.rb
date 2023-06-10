sampledir = "/home/b08x/studio/resources/samples/"

# meloncoly nonsense, and i'll crack nouns brother fuck the verb tense
sample SAMPLES, "screen_zoom_mix", start: 0.84885, finish: 0.858, attack: 0.25

sleep sample_duration SAMPLES, "screen_zoom_mix", start: 0.84885, finish: 0.858, attack: 0.25


#####
# /home/b08x/media/audio/Bela Fleck/Throw Down Your Heart, Tales From the Acoustic Planet, Volume 3_ Africa Sessions/06 D'Gary Jam.mp3
#
# /home/b08x/media/audio/Pink Floyd/Relics_ A Bizarre Collection of Antiques & Curios/11 Bike.mp3 @ towards the end


#######



#####



loop do
sample SAMPLES, "25257__suonho__deconstruction-set-thefinalcrash02"
sleep sample_duration SAMPLES, "25257__suonho__deconstruction-set-thefinalcrash02"
end

live_loop :blah do
  sample SAMPLES, "25257__suonho__deconstruction-set-thefinalcrash02", rate: 0.5
  sleep sample_duration SAMPLES, "25257__suonho__deconstruction-set-thefinalcrash02", rate: 0.5
end

with_fx :ring_mod, freq: 40, freq_slide: 4 do |f|
  control f, freq: 80
  sample SAMPLES, "screen_zoom_mix", slice: 15, num_slices: 24
end

sample SAMPLES, "screen_zoom_mix", start: 0.65, finish: 0.7

# hums like a migraine to the brain in the time yet remaining
sample SAMPLES, "screen_zoom_mix", start: 0.84, finish: 0.84853

# meloncoly nonsense, and i'll crack nouns brother fuck the verb tense
sample SAMPLES, "screen_zoom_mix", start: 0.84885, finish: 0.858, attack: 0.25

# you are listening
sample SAMPLES, "screen_zoom_mix", start: 0.5678, finish: 0.58808, attack: 1




loop do
with_fx :bpf, centre: 80, res: 0.4 do
  sample SAMPLES, "zoomzip_intro", start: 0.35, finish: 0.75, attack: 1
end

sleep sample_duration SAMPLES, "zoomzip_intro", start: 0.35, finish: 1, attack: 1

  with_fx :echo, phase: 0.125, decay: 2.5, pre_mix: 0.4 do
    with_fx :reverb, room: 0.6, pre_mix: 0.6, damp: 0.7 do
      with_fx :rhpf, cutoff: 80, res: 0.4 do
        sample SAMPLES, "zoomzip_intro", amp: 0.25, start: 0.8, finish: 0.98, attack: 0.25, pan: rrand(0.6,-0.6)
      end
    end
  end

end


with_fx :bpf, centre: 90, res: 0.9 do
  with_fx :hpf, cutoff: 59 do
    sample SAMPLES, "zoomzip_intro"
  end
end

sample SAMPLES, "someonewhogetshigh", amp: 0.95

# load_sample SAMPLES, "HRS4-PM2"
60.times do |x|
  sample SAMPLES, "HRS4-PM2", onset: x, attack: 0.25, release: 0.5, lpf: 90
  sleep 0.5
end


loop do
20.times do |x|
  sample SAMPLES, "HRS4-PM2", slice: x, num_slices: 135, release: 0.125

end
sleep 2.5
end

x = sample_duration SAMPLES, "roy", attack: 2, attack_level: 0.3, start: 0.25, finish: 0.312, rate: 1

sample SAMPLES, "roy", attack: 2, attack_level: 0.3, amp: 0.35, start: 0.25, finish: 0.312, rate: 1, pan: -0.8, pan_slide: x do |p|
  control p, pan: 0.8
end

#
# load_sample SAMPLES, "SMA-englishEdition"
sample SAMPLES, "SMA-englishEdition", rate: 1.5
#
# load_sample SAMPLES, "SCSS-Mystery-Word"
sample SAMPLES, "SCSS-Mystery-Word", start: 0, finish: 0.4

#
# with_fx :sound_out_stereo, output: 3, amp: 0 do
  load_sample SAMPLES, "nevertry"

  #isn't there something youd like to say
  sample SAMPLES, "nevertry", start: 0, finish: 0.17, amp: 0.75

  #there sure is
  sample SAMPLES, "nevertry", start: 0.18, finish: 0.321, amp: 0.75
#
#
  load_sample SAMPLES, "hailsatan"
  #
  # # "I'm a catholic whore..."
  sample SAMPLES, "hailsatan", start: 0, finish: 0.155, release: 0.125
  sleep 2
  #
  sample SAMPLES, "hailsatan", start: 0.135, finish: 0.355
  sleep 2
  #
  sample SAMPLES, "hailsatan", start: 0.3565, finish: 0.50
  sleep 2
  #
  #sample SAMPLES, "hailsatan", start: 0.78, finish: 0.85
  sample SAMPLES, "hailsatan", start: 0.73, finish: 0.85
   sleep 2
  #
  # # "and Have a lovely afternoon "
  # # or start 0.91 to drop the and
  sample SAMPLES, "hailsatan", start: 0.88, finish: 0.998
  # # sleep 2
#
  load_sample SAMPLES, "iamascientist"
#
#
#
  # # "im a scientist"
  sample SAMPLES, "iamascientist", start: 0.01, finish: 0.184, attack: 0.125
  #
  #
  sample SAMPLES, "iamascientist", start: 0.2129, finish: 0.630
  #
  # # "when i dont like something about the world i change it"
  sample SAMPLES, "iamascientist", start: 0.6855, finish: 1

#
#
  #kids, you tried your best
  sample SAMPLES, "nevertry", start: 0.321, finish: 0.55

  #you failed miserably *suck*
  sample SAMPLES, "nevertry", start: 0.565, finish: 0.7

  #the lesson is
  sample SAMPLES, "nevertry", start: 0.7, finish: 0.825, amp: 0.8

  #never try
  sample SAMPLES, "nevertry", start: 0.825, finish: 1
# end




16.times do |x|
sample SAMPLES, "awatts_karmic_devil", slice: x, num_slices: 16
sleep sample_duration SAMPLES, "awatts_karmic_devil", slice: x, num_slices: 16
end

sample SAMPLES, "awatts_karmic_devil", start: 0.08, finish: 0.09

#mixxx

#

#

#

#

#
  #the part that doesn't allow good to exist without condition
sample SAMPLES, "itsgood", start: 0.25, finish: 0.5
#


15.times do

end

  sample SAMPLES, "itsgood", start: 0.85, finish: 1



#i decided to hack you
sample SAMPLES, "itsgood", start: 0.907, finish: 1




#######################
#### part II ##########
#######################

load_sample SAMPLES, "wedrankthewater"
#
# # "but we drank the water"
sample SAMPLES, "wedrankthewater", start: 0.28, finish: 0.35
#

sleep 8

# # "yeah"
sample SAMPLES, "wedrankthewater", start: 0.44, finish: 0.5
#



with_fx :sound_out_stereo, output: 3, amp: 0 do

# # "laughtr...."
  live_loop :laughtr do

    sleepypants = sample_duration SAMPLES, "wedrankthewater", start: 0.825, finish: 0.97, attack: 2, release: 0.3, rate: 0.5

    with_fx :echo, phase: 0.125, decay: 8, pre_mix: 0.4 do
      with_fx :bpf, centre: 82, res: 0.75, pre_mix: 0.5 do
        sample SAMPLES, "wedrankthewater", start: 0.825, finish: 0.9681, attack: 2, release: 0.3, amp: 0.85, rate: 0.5, pitch: 6, pan: rrand(0.4,0.2), pan_slide: 6 do |x|
          control x, pan: rrand(-0.4,-0.2)
        end
      end
    end

    sleep sleepypants.round(3)

  end

end

puts sample_duration SAMPLES, "homer_chilli_pepper",
attack: 0.5, start: 0.11, finish: 0.183


at 20 do
  with_fx :ixi_techno, cutoff_max: 80, cutoff_min: 70, phase: 4, res: 0.8, pre_mix: 0 do |i|
    with_fx :lpf, cutoff: 95 do
      with_fx :reverb, room: 0.8 do
          sample SAMPLES, "homer_chilli_pepper", attack: 0.5, start: 0.11, finish: 0.183, pan: 0 do |p|
            sleep 3
            control p, pan: 0.9, pan_slide: 1.5
            sleep 1.5
            control p, pan: -0.9, pan_slide: 1.5
            sleep 1.5
            control p, pan: 0, pan_slide: 1
            sleep 0.25
            control i, pre_mix: 0.4
          end
      end
    end
  end
end



#what is reality?
sample SAMPLES, "robin_williams_fullgooseboozo_whatisreality", start: 0.9, finish: 1

#it doesnt mean what you think
sample SAMPLES, "itsjustanobject", start: 0.5, finish: 0.9

with_fx :reverb, room: 0.4, damp: 0.6 do
with_fx :bpf, centre: 120, res: 0.6 do
with_fx :rhpf, cutoff: 50 do
sample SAMPLES, "robin_williams_myonlylovecrazy", pre_amp: 1.5
end
end
end

###intro do do do doo
live_loop :derp do
  sample SAMPLES, "mahnamahna", start: 0.002, finish: 0.031, attack: 0.8, release: 0.5, amp: 0.2

  sleep sample_duration SAMPLES, "mahnamahna", start: 0.002, finish: 0.031, attack: 0.8, release: 0.5
end


####intro snare hit loop
live_loop :derpydo do
  sample SAMPLES, "mahnamahna", start: 0.035, finish: 0.062, attack: 0.8, release: 0.5
  sleep sample_duration SAMPLES, "mahnamahna", start: 0.035, finish: 0.062, attack: 0.8, release: 0.5
end

#####good mahnamahna/do do dodo loop
live_loop :derpyde do

  sample SAMPLES, "mahnamahna", start: 0.061, finish: 0.078, attack: 0.25, release: 0.5
  sleep sample_duration SAMPLES, "mahnamahna", start: 0.061, finish: 0.078, attack: 0.25, release: 0.5
end

sample SAMPLES, "mahnamahna", start: 0.061, finish: 0.0675, attack: 0.25, release: 0.25

sample SAMPLES, "mahnamahna", start: 0.0670, finish: 0.078, attack: 0.25, release: 0.25

#################################################
in_thread do

  8.times do
    sample SAMPLES, "mahnamahna", start: 0.035, finish: 0.062, attack: 0.125, release: 0.125
    sleep 4.58
  end
end

  in_thread do
    with_fx :mono, pan: -0.9, pan_slide: 1.75 do |x|
      control x, pan: 0.9
      sample SAMPLES, "mahnamahna", amp: 0.5, start: 0.061, finish: 0.0675, attack: 0.25, release: 0.25, rate: -1
      sleep sample_duration SAMPLES, "mahnamahna", start: 0.061, finish: 0.0675, attack: 0.25, release: 0.25
    end
  end
#########################################

###########

sleep 8


ampr = 0.2

with_fx :level, amp: 0, amp_slide: 4 do |x|
  control x, amp: ampr

  with_fx :reverb, room: 1, damp: 0.2 do



    sample SAMPLES, "roy", slice: 10, num_slices: 16, rate: 1, pan: 0.8, pan_slide: 2 do |p|
      control p, pan: -0.8
    end



    #morty - what the  hell, woah
    # sample SAMPLES, "roy", amp: 0.25, attack: 1, attack_level: 0.5, start: 0.625, finish: 0.638, rate: 1, pan: -0.8, pan_slide: 1.5 do |p|
    #   control p, pan: 0.8
    # end

    sample SAMPLES, "roy", slice: 14, num_slices: 16, rate: 1, pan: 0.8, pan_slide: 2 do |p|
      control p, pan: -0.8
    end

    sample SAMPLES, "roy", start: 0.903, finish: 0.9378, rate: 1, pan: -0.8, pan_slide: 2 do |p|
      control p, pan: 0.8
    end

  end

end




loop do
  sync :moonpie
  play :d2

end
