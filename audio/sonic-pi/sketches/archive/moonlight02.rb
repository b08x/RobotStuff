# Welcome to Sonic Pi v2.10

set_mixer_control! hpf: 21

use_bpm 60
use_debug true


#cs harmonic minor

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

uncomment do
  comment do
    with_fx :pan, pan: 0.3 do
      live_audio :banjo, input: 1, stereo: false
    end
  end



  with_fx :pan, pan: -0.3 do
    live_audio :zsynth, input: 2, stereo: false
  end


  with_fx :pan, pan: -0.6 do
    live_audio :qsampler, input: 3, stereo: false
  end

  with_fx :pan, pan: 0.1 do
    live_audio :hydrogen, input: 4, stereo: false
  end


end

#use_bpm 80

comment do

  hodr1 = range(-0.8,-0.2,step: 0.25, inclusive: true).tick
  hodr2 = range(0.8,0.2,step: 0.25, inclusive: true).tick

  with_fx :mono, pan: hodr1, pan_slide: 8 do |p|
    control p, pan: hodr2
    with_fx :echo, phase: 0.65, decay: 4, pre_mix: 0.25 do
      with_fx :reverb, room: 0.8, damp: 0.6, res: 0.6 do
        live_audio :banjo, stereo: false, input: 1, amp: 1.5
      end
    end
  end

end

@olthymeamp = 1
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

sleep 8

use_bpm 90



#use_bpm 110
#use_bpm 140
