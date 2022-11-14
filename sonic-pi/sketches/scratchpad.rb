# Welcome to Sonic Pi v3.0.1

# e.g. arpeggiate [4,2,3], :d3, :major, [0,1,2,3,4], 4
live_loop :intro3, sync: :clock do
  #stop
  use_midi_defaults channel: 1
  midiarpeggiate [1,4,1], :a2, :minor, [0,1,3], 2
end

live_loop :beat01 do
  #sync :noise
  with_fx :band_eq, freq: 44, res: 0.1, db: 20 do
    with_fx :panslicer, smooth: 0.25, wave: 3 do
      with_fx :reverb, room: 1 do
        sample :bd_808, pre_amp: 1.5, lpf: 40
        sleep 0.25
        sample :bd_808, pre_amp: 1.5, lpf: 40
        sleep 3.75
      end
    end
  end
end

cue :noise

use_synth :mod_fm

live_loop :squelch do
  #sync :beat01
  n = (ring :f1, :g1, :a1).tick
  4.times do
    1.times do
      play n, release: 0.125, cutoff: 100, res: 0.8, wave: 0
    end
    sleep 0.125
    3.times do
      play n, release: 0.125, cutoff: 100, res: 0.8, wave: 0
    end
    sleep 1
  end


  #sleep 0.25
end


#-------------------


# Welcome to Sonic Pi v3.0.1

use_bpm 92

live_loop :noise do
  play 30, amp: 0.01, attack: 0.75, release: 0.25
  sleep 0.75
end

# HISS
live_loop :hiss_loop do
  #with_fx :panslicer, smooth: 0.9 do
  #with_fx :tanh, krunch: 1 do
  with_fx :tremolo do
    #with_fx :gverb, room: 10, spread: 0.5, release: 3 do
    sample :vinyl_hiss, amp: 1, rate: 0.5, attack: 3, sustain: 4, sustain_level: 0.8, release: 1, pan: rrand(-0.8, 0.8)
    #sleep sample_duration :vinyl_hiss
    sleep 8
    #end
  end
  #end
  #end
end

def eightoheight(rate=1)

  with_fx :band_eq, freq: 44, res: 0.1, db: 20 do
    sample :bd_808, pre_amp: 1.5, lpf: 40, rate: rate
  end

end

in_thread do
  live_loop :foo do
    cue :tick
    sleep 8
  end
end

in_thread(name: :heartbeat) do

  live_loop :heartbeat do

    sync :tick
    2.times do
      #with_fx :ring_mod, freq: 48 do
      eightoheight
      #end
      sleep 0.5
    end



  end

end

in_thread(name: :hello) do
  sync :heartbeat
  live_loop :hello do


    2.times do

      #with_fx :ring_mod, freq: 42 do
      eightoheight(-1)
      #end

      sleep 0.25
    end

    sleep 0.5

    eightoheight(-1)

  end

end
# BASSDRUM
define :bassdrum do |note1, duration, note2 = note1|
  use_synth :sine
  with_fx :hpf, cutoff: 100 do
    play note1 + 24, amp: 40, release: 0.01
  end
  with_fx :distortion, distort: 0.1, mix: 0.3 do
    with_fx :lpf, cutoff: 30 do
      with_fx :hpf, cutoff: 55 do
        bass = play note1, amp: 85, release: duration, note_slide: duration
        control bass, note: note2
      end
    end
  end
  sleep duration
end



live_loop :somebeat do

  use_synth :mod_fm
  n = (ring :f1, :g1, :a1).tick

  4.times do
    1.times do
      play n, release: 0.125, cutoff: 100, res: 0.8, wave: 0
    end
    sleep 0.125
    3.times do
      play n, release: 0.125, cutoff: 100, res: 0.8, wave: 0
    end
    sleep 1
  end
end


comment do

  live_loop :kick_drum do

    loop do
      sample :bd_boom, rate: 0.5
      sleep 0.75
      play 32
      sleep 0.75
      sample :drum_tom_lo_soft
      sleep 1
      sample :drum_tom_lo_soft
      sleep 1.5
    end
  end

  live_loop :snare_drum do
    sleep 16
    loop do
      sleep 1
      sample :drum_tom_hi_soft
      sleep 1
    end
  end

end


#----------------------------------


# Welcome to Sonic Pi v3.0.1



live_loop :noise do
  play 30, amp: 0.01, attack: 0.75, release: 0.25
  sleep 0.75
end


def git01

  synth :sound_in, input: 3, release: 4, amp: 0.5

end

def git02

  synth :sound_in, input: 4, release: 4, amp: 0.5

end

# BASSDRUM
define :bassdrum do |note1, duration, note2 = note1|
  use_synth :sine
  with_fx :hpf, cutoff: 100 do
    play note1 + 24, release: 0.01
  end
  with_fx :distortion, distort: 0.1, mix: 0.3 do
    with_fx :lpf, cutoff: 30 do
      with_fx :hpf, cutoff: 55 do
        bass = play note1, release: duration, note_slide: duration
        control bass, note: note2
      end
    end
  end
  sleep duration
end

live_audio :synths, stereo: true, input: 1


live_loop :something do
  sync :noise

  #with_fx :nhpf, cutoff: 35, mix: 0.15, amp: 0.25 do

  with_fx :sound_out, output: 3 do


    #with_fx :whammy, mix: 0.4 do
    with_fx :ixi_techno, cutoff_min: 72, cutoff_max: 76, res: 0.4, phase: 2 do
      #with_fx :lpf, cutoff: 40 do
      with_fx :gverb, room: 10, damp: 0.6 do
        git01
      end
      #end
    end
    #end

  end

  with_fx :sound_out, output: 4 do

    #with_fx :flanger, decay: 2, wave: 3 do
    with_fx :lpf, cutoff: 80 do
      with_fx :echo, decay: 0.5 do
        with_fx :ring_mod, freq: rrand(72, 76) do
          git02
        end
      end
    end
    #end


    #end


  end

end



comment do

  live_loop :drums01 do
    sync :noise
    with_fx :lpf, cutoff: 70 do
      with_fx :band_eq, freq: 44, res: 0.1, db: 25 do
        bassdrum 34, 0.25

        bassdrum 33, 0.75
      end
    end

    sleep 2

  end

end

#-----------------------


# Welcome to Sonic Pi v3.0.1

use_bpm 70

live_loop :noise do
  play 30, amp: 0.01, attack: 0.75, release: 0.25
  sleep 1
end



live_audio :foo, stereo: true, input: 3



live_loop :random_riff do
  use_synth :mod_fm
  use_random_seed 3
  notes = (scale :c2, :minor_pentatonic).shuffle
  2.times do
    play notes.tick, attack: 0.5, sustain: 0.25, decay: 0, release: 0.25, cutoff: 90, amp: 0.3
    sleep 1
  end
  sleep 1
end


live_loop :beat01 do
  #sync :random_riff
  with_fx :band_eq, freq: 44, res: 0.1, db: 25 do
    with_fx :panslicer, smooth: 0.25, wave: 3 do
      with_fx :reverb, room: 1 do
        sample :bd_808, pre_amp: 1.5, lpf: 40
        sleep 0.25
        sample :bd_808, pre_amp: 1.5, lpf: 40
        sleep 3.75
      end
    end
  end
end

#--------------------------



use_bpm 100

# HISS
live_loop :hiss_loop do
  with_fx :pan, pan: -1 do
    with_fx :reverb do
      sample :vinyl_hiss, amp: 0, rate: 1
      sleep sample_duration :vinyl_hiss
    end
  end

end

with_fx :panslicer, mix: 0.1, wave: 3, smooth: 10 do
  with_fx :reverb do
    live_audio :bar, stereo: true, input: 1
  end
end

#with_fx :reverb do
#  with_fx :ixi_techno do
#    with_fx :ring_mod, freq: 42 do
live_audio :foo, stereo: true, input: 3
#    end
#  end
#end

live_loop :bass do
  sample :bd_boom, pre_amp: 0.5, rate: -1, amp: 0.5
  sleep 2

  play 38, amp: 0.5, attack: 2, sustain: 1, decay: 0.5, release: 0.5
  sleep 4
end

#-----------------------



# Welcome to Sonic Pi v3.0.1
# Cloud Beat
#
# Taken from "Beats basteln wie die Großen"
# c't 13/2017
#
# Coded by Pit Noack
# supported by
# Alexander Degraf
# Astrid Hagenguth
# Enrico Mercaldi
# http://www.maschinennah.de/
# mail@pitnoack.de



use_bpm 100

# HISS
live_loop :hiss_loop do
  sample :vinyl_hiss, amp: 0
  sleep sample_duration :vinyl_hiss
end

# SNARE
live_loop :snare_loop do
  sleep ring(2.5, 3)[tick]
  with_fx :lpf, cutoff: 100 do
    sample :tabla_na_s, sustain: 0, release: 0.05, amp: 2
  end
  sleep ring(1.5, 1)[look]
end

use_bpm 120
# BASSDRUM
define :bassdrum do |note1, duration, note2 = note1|
  use_synth :sine
  with_fx :hpf, cutoff: 90 do
    play note1 + 24, amp: 20, release: 0.01
  end
  with_fx :distortion, distort: 0.1, mix: 0.3 do
    with_fx :lpf, cutoff: 30 do
      with_fx :hpf, cutoff: 55 do
        bass = play note1, amp: 85, release: duration, note_slide: duration
        control bass, note: note2
      end
    end
  end
  sleep duration
end

live_loop :bassdrum_schleife do
  bassdrum 36, 1.5
  if bools(0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0)[tick]
    bassdrum 36, 0.5, 40
    bassdrum 38, 1, 10
  else
    bassdrum 36, 1.5
  end
  bassdrum 36, 1.0, ring(10, 10, 10, 40)[look]
end


#----------------------------





live_loop :heyo do
  with_fx :ring_mod, freq: 44 do |ring|
    control ring, freq_slide: 1, freq: 62
    synth :sine, note: :d2, sustain: 4
  end
  sleep 4
end



#------------------------------


def git01

  synth :sound_in, input: 3, release: 1, amp: 1

end

def git02

  synth :sound_in, input: 4, release: 1, amp: 1

end


# live_loop :git01 do
#   with_fx :pan, pan: rrand(-0.6,0.6) do
#     with_fx :hpf, cutoff: 24 do
#       with_fx :gverb, spread: 0.8, damp: 0.2, room: 4 do
#         with_fx :flanger, delay: 2.5, wave: 3 do
#           git
#         end
#         with_fx :lpf, cutoff: rrand(100,120) do
#           with_fx :ring_mod, freq: rrand(46,58) do |ring|
#             control ring, freq_slide: 4, freq: rrand(43,54)
#             git02
#           end
#         end
#       end
#     end
#   end
#   sleep 1
# end

#---------------

# HYDRO_KITS = "/home/b08x/.hydrogen/data/drumkits/"
#
# electric_empire = File.join(HYDRO_KITS, "ElectricEmpireKit")
#
# glob = Dir.glob(electric_empire + "/**/*flac")
#
# glob.each do |x|
#   puts '----------------------'
#   puts x
#
#   puts x.methods
#
#   sleep 1
# end
#
# all_sample_names.sort.each do |samp|
#   2.times do
#     puts '----------------------'
#     puts samp
#
#     sample samp, sustain: 2
#     sleep 2.5
#   end
# end
