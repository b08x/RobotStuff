set_mixer_control! hpf: 21

use_bpm 90
use_debug true
set_sched_ahead_time! 0

puts 'An Introduction to Robot Jazz'

#########################################
# Metronome Helper Functions for synching
#########################################

# Count every beat
live_loop :bar do
  cue :tick
  sleep 1
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tick
  cue :every_two_bars
  sample :elec_blip, amp: 0.1, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.1, rate: 2.0
  sleep 16
end


#########################################
# Set up the Sound Material
#########################################

run_file "/home/b08/workspace/seshmon/sessions/robotjazz/introduction.rb"

run_file "/home/b08/workspace/seshmon/lib/drums/euclid_distrib_defs.rb"

#########################################
# Clumsy Mixer
#########################################
# 1 starts, 0 stops the loops

hiss_loop = 1
spacewind = 1
ambi_glass_ring = 1
heartbeat_bass = 1
basshit = 1

#########################################
# Sound Starts Here
#########################################

live_loop :hiss_loop do
  stop if hiss_loop < 0
  with_fx :level, amp: 0, amp_slide: 8 do |a|
    control a, amp: 0.9
    hiss
  end
end


load_sample SAMPLES, "we_are_floating"
load_sample SAMPLES, "whatcharealizing"

live_loop :realize, autocue: false do
  sync :realize

  in_thread do
      sleep 2
      eggs01
  end

  with_fx :reverb, room: 0.8, damp: 0.4 do
    ampr = 0.8
    with_fx :level, amp: 0, amp_slide: 2 do |a|
      control a, amp: ampr

      #whatcha realizing jerk
      sample SAMPLES, "whatcharealizing", start: 0, finish: 0.27, amp: 0.7, attack: 0.25, release: 0.125, rate: 1

      sample SAMPLES, "we_are_floating", attack: 2, release: 0.25, amp: 0.7

      sleep sample_duration SAMPLES, "we_are_floating", attack: 2
    end
  end

  sleep 4

  eggs02

  cue :spacewind
  stop

end

at 10 do
  cue :realize
end

live_loop :spacewind, autocue: false do

  # stop if spacewind == 0

  sync :spacewind


  in_thread do
    sync :every_two_bars
    with_fx :level, amp: 0, amp_slide: 8 do |a|
      control a, amp: 1.5

      with_fx :ixi_techno, cutoff_min: 24, cutoff_max: 42, res: 0.8, phase: 0.25 do
        with_fx :band_eq, freq: 41, db: 8, res: 0.25 do
          sample SAMPLES, "we_are_floating", start: 0.56, finish: 1, beat_strech: 4, attack: 0.25, sustain: 4, release: 0.25, pan: 0, pan_slide: 4 do |p|
            control p, pan: rrand(-0.8,0.8)
          end
        end
      end
    end
  end

end

load_sample SAMPLES, "revolver_fearme"
load_sample SAMPLES, "revolver_roofgolf"


live_loop :heartbeat, autocue: false do
    sync :heartbeat_jam

    #stop if heartbeat_bass == 0

    heartbeat

end


live_loop :fear, autocue: false do
  sync :fear

  #where does it stop mr green, where does this game stop
  sample SAMPLES, "revolver_roofgolf", start: 0.10, finish: 0.12
  sleep sample_duration SAMPLES, "revolver_roofgolf", start: 0.10, finish: 0.12

  sleep 8

  # dont let them play head games with you
  sample SAMPLES, "revolver_roofgolf", start: 0.134, finish: 0.14050, release: 0.45
  sleep sample_duration SAMPLES, "revolver_roofgolf", start: 0.134, finish: 0.14050, release: 0.45

  sleep 8

  # is it me that's playing head games with you?

  with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, invert_wave: 1, wave: 3, pre_mix: 0.4 do
    with_fx :reverb, mix: 0.4, room: 0.9 do
      with_fx :level, amp: 1 do
        with_fx :mono do
          sample SAMPLES, "revolver_roofgolf", start: 0.1416, finish: 0.1503
        end
      end
    end
  end

  #sleep 8

  # 8.times do
  #   sample :ambi_piano, amp: 1.5, rate: 0.5, pitch: -12, attack: 0.5, release: 0.5, pan: -0.8, pan_slide: 1.75, rpitch: (scale 1, :major).tick do |x|
  #     control x, pan: 0.8
  #   end
  # end

  cue :heartbeat_jam

  sleep 8

  #if i say you're scared, you're scared
  sample SAMPLES, "revolver_fearme", start: 0.315, finish: 0.320
  sleep sample_duration SAMPLES, "revolver_fearme", start: 0.315, finish: 0.320


end

at 30 do
  cue :fear
end










# it stops when you start to give me answers
#sample SAMPLES, "revolver_roofgolf", start: 0.12, finish: 0.134




#### soundscape of eggs scene
# sample SAMPLES, "donteattheeggs", start: 0, finish: 0.35, attack: 2, release: 0.5

#### dont eat the eggs
#sample SAMPLES, "donteattheeggs", amp: 0.8, start: 0.345, finish: 0.379, attack: 0.25, release: 0.125


#### what?
# sample SAMPLES, "donteattheeggs", start: 0.418, finish: 0.455, attack: 1

#### laughtr soundscape
# sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5
