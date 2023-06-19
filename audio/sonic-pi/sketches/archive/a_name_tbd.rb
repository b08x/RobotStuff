#run_file "/home/b08x/NSM Sessions/a_name_to_be_determined_later_01/a_n_tbd_methods.rb"
set_mixer_control! hpf: 21

# beat time at start of bar n
define :bar do |n| return 4 * n end

# print bar(1) = 4,8,12,16,20,24,28,32,
print bar(45)

live_loop :counter do
  use_bpm 60
  cue :tick
  print current_bpm
  puts beat
  puts bt(1)
  #use_arg_bpm_scaling true
  puts current_beat_duration
  sleep bt(1)
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




#
#
#

# at abar(0) do
# live_loop :beat1 do
#   sync :bar
#   sample :bd_808, attack: 0.001, amp: 3
#   sleep 0.5
# end
#
# end
#
# at abar(2) do
# live_loop :beat2 do
#
#   sync :beat1
#   sample :sn_generic, attack: 0.002, amp: 0.5
#   puts bt(1)
#   sleep bt(1)
# end
# end

# live_loop :beat1 do
#   stop
# end

# def intro
#   use_random_seed 2342
#   a = scale(:f2, :minor)
#   #use_tuning :just, :c
#   8.times do
#     play a.pick, attack: 0.1, release: 0.25
#     sleep 0.25
#   end
# end

def loadsound(sample)
  sample SOUNDS, sample
end

at bar(0) do
    a = loadsound("34338_erh_wind")
    control a
end

at bar(4) do
    b = loadsound("34662_erh_nine_lies_the_heart_ed_4")
    control b
end

at bar(8) do
    c = loadsound("38680_erh_gong_30")
    control c
end

at bar(10) do
    d = loadsound("42286_erh_f_eh_angelic_3")
    control d

end

at bar(12) do
    e = loadsound("38544_erh_rhythm_2_2_own_b7_21")
    control e
end

at bar(14) do
  with_fx :mono do
    kick808_09 = loadsound("Kick_Legend_808_09_faded")
    live_loop :sub01 do
      #sync :every_two_bars
      control kick808_09
      sleep 1
    end
  end
end


# at 9 do
#   with_fx :sound_out, output: 5, amp: 0 do
#     with_fx :reverb, room: 0.8, damp: 0.8, mix: 0.6 do
#       with_fx :hpf, cutoff: 21 do
#         with_fx :compressor, clamp_time: 0.1, threshold: 0.8 do
#           sample SOUNDS, "39224_erh_ew_46_rumble", attack: 0.25
#         end
#       end
#     end
#   end
# end
# at 10 do
#   with_fx :sound_out, output: 6, amp: 0 do
#     sample SOUNDS, "38544_erh_rhythm_2_2_own_b7_21"
#   end
# end
#
#
# print "hey"
# def intro
#   use_random_seed 2342
#   a = scale(:f2, :minor)
#   #use_tuning :just, :c
#   use_synth :piano
#   8.times do
#     play a.pick, attack: 0.1, release: 0.25
#     sleep 0.25
#   end
# end
#
#
# #at 180 do
#   with_fx :level, amp: 0, amp_slide: 20 do |lvl|
#     live_loop :odd_scale do
#
#       use_bpm 45
#       intro
#     end
#
#     control lvl, amp: 1
#   end
#   live_loop :crunch_voyager do
#     sync :odd_scale
#
#     with_fx :pan, pan: [-1,-0.3,0.6,0.8].choose do
#       2.times do
#         sample SOUNDS, "Bass_Crunch_Voyager_Livid", amp: 3
#         sleep 0.5
#       end
#     end
#
#     sleep 4
#   end
  live_loop :moog_trigger do
    sync :odd_scale
    use_bpm 45
    #sync :tick
    #/home/b08x/Studio/library/sounds/soundfonts/collections/oh_multi_preset.sf2 harm-min(sting)
    midi (octs :d2, 4).tick, sustain: 0.1, channel: 2, velocity: 60

    sleep 0.125
    #/home/b08x/Studio/library/sounds/soundfonts/collections/proteus3_instruments.sf2 All Perc 3
    midi (scale :e3, :harmonic_minor).tick, sustain: 0.1, channel: 1, velocity: 50
    sleep 0.25
  end
#end
#
#
# #i-iv-vi-VII    in F Hungarian Minor (1 notes out)
#
# # chrd = []
# # [:i, :iv, :vi, :VII].each do |d|
# #   chrd.append (degree d, :F, :hungarian_minor)
# #
# # end
#
#
# def partone
#   use_transpose 0
#   notes1 = chord_degree :vi, :f2, :minor, 5, invert: -2
#   notes2 = chord_degree :i, :f2, :minor, 3 invert: 3
#   use_random_seed 879
#   use_synth :piano
#   density 2 do
#     2.times do
#       play notes1.pick
#       sleep 0.55
#     end
#   end
#   4.times do
#     play notes2.pick
#     sleep 0.25
#   end
# end
#
# # use_transpose -12
# # use_synth :piano
#
# # print a
# # a.each do |x|
# #   play x
# #   sleep 0.125
# # end
# live_loop :partone do
#   sync :odd_scale
# partone
# end
# use_synth :piano
# 2.times { arpeggiate [1,4,5], :f2, :minor, [5,4,6], 1 }
# play chord_degree :iv, :f2, :minor
# sleep 0.25
# play chord_degree :vi, :f2, :minor
# sleep 0.25
# play chord_degree :VII, :f2, :minor
#
#
# #i-iv-v-VII     in F Natural Minor (0 notes out)
