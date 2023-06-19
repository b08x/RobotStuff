set_mixer_control! hpf: 21

#### Featuring:
# Under The Moonlight
# Kabak Kemane: İmamyar Hasanov
# Vocal: Nermine Memmedova
#
# Pretty Lights - Try to Remember
# Bela Fleck - D-Gary Jam,  Kayi\ ni\ Wura,
# Pink Floyd - Bike

# live_loop :devil do
#   stop
#   cue :robotdevil
#   sample SAMPLES, "08betterthedevil", rate: 1, amp: 0.6
#   sleep sample_duration SAMPLES, "08betterthedevil"
# end
#
#
#
#
# live_loop :devilbass do
# sync :robotdevil
# #play :a1, attack: 0.125
# sample SAMPLES, "Classic-808_Kick_long", attack: 0.125
# sleep 0.25
# end


#try out 60 then 75bpm first...

# sample SAMPLES, "bfleck_djaryjam"
#
#
#
# sample SAMPLES, "fleck_wura"
#

# forgetit = sample_duration SAMPLES, "trytoremember"
#
# 32.times do |x|
#
# with_fx :pan, pan:
#   sample SAMPLES, "trytoremember", slice: x, num_slices: 32, attack: 1
#
# end

#
#
#
#
# sample SAMPLES, "bike", slice: 14, num_slices: 16, attack: 8
#
#
#
# #time chimes / # freqtweak thing here

sample SAMPLES, "bike", start: 0.55, finish: 0.878, amp: 0.45, attack: 2, release: 2

#
# #laughing, looping, ducks


bike_slide = (sample_duration SAMPLES, "bike", start: 0.879, finish: 1, amp: 0.75 - 0.0125)

with_fx :mono, pan: -0.9, pan_slide: bike_slide do |x|
  control x, pan: 0.9
  sample SAMPLES, "bike", start: 0.879, finish: 1, amp: 0.2
end


#
with_fx :echo, phase: 0.75, decay: 8, pre_mix: 0 do |x|
  with_fx :reverb, room: 0.9, damp: 0.6, res: 0.6 do
    #sleep 2
    sample SAMPLES, "goingupelevator", attack: 0.125, start: 0.001, finish: 0.10, rate: 1.5
    wait 2
    control x, pre_mix: 0.8
  end
end
#
sample SAMPLES, "110FollowtheLine",
slice: 4, num_slices: 10, attack: 0.5, release: 0.5, pan: -0.2, pan_slide: 4 do |p|
  control p, pan: 0.2
end

sample SAMPLES, "110FollowtheLine", slice: 5, num_slices: 10, attack: 0.5, release: 1, rate: -1, pan: -1, amp: 0.55

sample SAMPLES, "110FollowtheLine", start: 0.6, finish: 0.72, attack: 2, release: 2.5, rate: -1, pan: 1, amp: 0.25
#
#
#
live_loop :undermoonlight do
  stop
  with_fx :ixi_techno, cutoff_min: 45, cutoff_max: 75, phase: 0.5, res: 0.4, pre_mix: 0.4 do
  with_fx :panslicer, pan_max: 0.8, pan_min: -0.8, phase: 2, smooth: 0.25 do |x|
    16.times do |x|
      with_fx :mono, amp: 0, amp_slide: 4 do
      sample SAMPLES, "888888-UnderTheMoonLight", slice: x, num_slices: 16
    end

      sleep sample_duration SAMPLES, "888888-UnderTheMoonLight", slice: x, num_slices: 16
    end
  end
end
end
#

#when attmpting to adjust amp levels in the live_loop, we run into an issue
#where the changes aren't picked up....
#Thread :live_loop_laughter exists: skipping creation
live_loop :kandjo do
  #stop
with_fx :level, amp: 0.4, amp_slide: 4 do
  sample SAMPLES, "fleck_wura", attack: 0.8, amp: 0.4
end
sleep sample SAMPLES, "fleck_wura", attack: 0.8, amp: 0.4
end


sample SAMPLES, "itsgood", start: 0, finish: 0.10, attack: 0.125, release: 0.25
sleep sample_duration SAMPLES, "itsgood", start: 0, finish: 0.10



# add fade in --> sweep pan --> fade out
ampr = 0.25

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


with_fx :level, amp: 0.6 do
live_loop :loop_name do
  sync :home
  sample SAMPLES, "Homecoming", amp: 0.5
end
end

cue :home

with_fx :panslicer, pan_max: 0.8, pan_min: -0.8, phase: 2, smooth: 2 do |x|
 with_fx :bpf, cutoff: 95, res: 0.4 do
   with_fx :reverb, room: 0.6, damp: 0.3 do
     with_fx :mono, amp: 0.75 do
       sample SAMPLES, "888888-Geut", start: 0.25, finish: 0.60, attack: 2, release: 4
       wait 8
       control x, pan_max: 0, pan_min: 0
     end
   end
 end
end



# I will do whatever I can to make this dream come through
# The lifestyle I'm creating now, is like a dream.
sample SAMPLES, "888888-Geut", start: 0.755, finish: 0.85





# in_thread do
#   loop do
#     cue :tick
#     sleep 0.5
#   end
# end
#
#     live_loop :acimom do
#
#
#           64.times do |y|
#             sample SAMPLES, "888888-BitifulBlueExtasy", hpf: 30, lpf: 110, amp: 0.7,
#             sleep sample_duration SAMPLES, "888888-BitifulBlueExtasy", slice: x, num_slices: 64
#           end
#
#
#     end







#### laughtr soundscape
live_loop :laughter do
@laughamp = 0.6
  with_fx :level, amp: 0, amp_slide: 4 do |x|
    control x, amp: @laughamp
    sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5, rate: -1.134
    sleep sample_duration SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5
  end
end
