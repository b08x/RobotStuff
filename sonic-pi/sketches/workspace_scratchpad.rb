### 2020-07-15



# Welcome to Sonic Pi
# Count every beat
live_loop :bar do
  cue :tick
  sleep 1
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tick
  cue :every_two_bars
  sample :elec_blip, amp: 0.5, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.5, rate: 2.0
  sleep 16
end

define :arpeggiate do |prog, tonic, mode=:major, pattern=[0, 1, 2, 3], reps=2|
  sc = scale(tonic, mode, num_octaves: 4)
  prog.each do |deg|
    puts "prog", prog
    reps.times do
      with_synth :pluck do
        play sc[deg-1] - 12, sustain: 0.9, amp: 1.5
      end
      t = 1.0 / pattern.length
      pattern.each do |i|
        n = sc[deg - 1 + 2*i + (i+1) / 4]
        #puts "n", n
        with_fx :lpf, cutoff: 50 do
          with_synth :beep do
            play n, sustain: 1.5 * t, amp: 0.8
          end
        end

        sleep t
      end
    end
  end
end

with_fx :reverb, room: 0.2, damp: 0.6 do

  live_loop :bassline do
    stop
    sync :two_bars
    with_fx :band_eq, amp: 3 do
      #with_fx :lpf, cutoff: 47 do
      play_pattern_timed [:cs2, :e2, :fs2, :g2], [0.5, 0.5, 0.5, 1.5], attack: 0, release: 0.2
      #end
    end

    #sleep 4
  end

  comment do
    live_loop :melod01 do
      sync :two_bars
      2.times { arpeggiate [4,2,4,4,2,1,6], :c3, :ionian}
    end
  end



  live_loop :melod02 do
    #sync :tick
    arpeggiate [2,4,1], :d3, :major
    #sleep 1
  end

  live_loop :tabula do
    sync :tick
    use_random_seed 4987
    4.times do
      with_fx :hpf, cutoff: 50 do
        sample "tabla_", pick, amp: 1.5
      end
      sleep 0.25
    end
  end


  live_loop :tab do
    # stop
    # sync :tick
    use_random_seed 5674
    4.times do
      sample "glitch_perc", pick, amp: 1.5, rate: (rrand(-0.5,1))
      sleep 0.5
    end
  end

  with_fx :sound_out, output: 3 do
    live_loop :mehack do
      #sync :four_bars
      use_random_seed 4587
      4.times do

        with_fx :echo, decay: 8, phase: 0.5 do
          with_fx :pan, pan: 1 do
            sample "mehackit_", pick, amp: 1.0
          end
        end
        sleep 0.75
      end
    end
  end
end

#----------------------------

#midi_cc 20, 0, channel: 1, port: "midi_through_port-0"
#FS_Seagull_Steel_String_Acoustic_Guitar_with_Fender_Reverb/FS_Seagull_Steel_String_Acoustic_Guitar.gig

use_bpm 45
live_loop :moog_trigger do
  #/home/b08x/Studio/library/sounds/soundfonts/collections/oh_multi_preset.sf2 harm-min(sting)
  midi (octs :d2, 4).tick, sustain: 0.1, channel: 2, velocity: 80

  sleep 0.125
  #/home/b08x/Studio/library/sounds/soundfonts/collections/proteus3_instruments.sf2 All Perc 3
  midi (scale :d3, :harmonic_minor).tick, sustain: 0.1, channel: 3, velocity: 50
  sleep 0.25
end

#--------------------

# Welcome to Sonic Pi
define :midiarpeggiate do |prog, tonic, mode=:major, pattern=[0, 1, 2, 3], reps=2|
  sc = scale(tonic, mode, num_octaves: 4)
  prog.each do |deg|
    puts "prog", prog
    reps.times do

      midi sc[deg-1] - 12, sustain: 0.9, amp: 1.5, velocity: 50, channel: 1

      t = 1.0 / pattern.length
      pattern.each do |i|
        n = sc[deg - 1 + 2*i + (i+1) / 4]
        #puts "n", n
        midi n, sustain: 1.5 * t, amp: 0.8, velocity: 50, channel: 1

        sleep t
      end
    end
  end
end

sample :bass_drop_c

define :squirrel do |reps|
  use_bpm 45
  reps.times do
    midi (octs :d3, 4).tick, sustain: 0.1, channel: 1, velocity: 60, port: "midi_through_port-0"
    sleep 0.125
  end
end
16.times do
squirrel(4)
end


use_bpm 45
#use_bpm 60
# Welcome to Sonic Pi
# Count every beat
live_loop :bar do
  cue :tick
  sleep 1
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tick
  cue :every_two_bars
  sample :elec_blip, amp: 0.5, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.5, rate: 2.0
  sleep 16
end

define :start do
  live_loop :start do
    #use_bpm 45
    #sync :tick
    #/home/b08x/Studio/library/sounds/soundfonts/collections/oh_multi_preset.sf2 harm-min(sting)
    3.times do
    midi (octs :d2, 4).tick, attack: 0.25, sustain: 0.1, channel: 2, velocity: 60

    sleep 0.25
  end
    #/home/b08x/Studio/library/sounds/soundfonts/collections/proteus3_instruments.sf2 All Perc 3
    midi (scale :e3, :harmonic_minor).tick, sustain: 0.1, channel: 3, velocity: 50
    sleep 0.25
  end
end


comment do

  at 0 do
    in_thread(name: :one) do
      start
    end
  end

  at 8 do
    live_loop :start do
      stop
    end

    in_thread(name: :two) do
      live_loop :next do
        midi (octs :g2, 4).tick, sustain: 0.1, channel: 1, velocity: 60
        sleep 0.125
        midi (scale :e3, :harmonic_minor).tick, sustain: 0.1, channel: 1, velocity: 50
        sleep 0.25
      end
    end
  end

  at 16 do

    start
  end

end


uncomment do
  live_loop :moog_trigger do
    use_bpm 45
    #sync :tick
    #/home/b08x/Studio/library/sounds/soundfonts/collections/oh_multi_preset.sf2 harm-min(sting)
    midi (octs :d2, 4).tick, sustain: 0.1, channel: 2, velocity: 60

    sleep 0.125
    #/home/b08x/Studio/library/sounds/soundfonts/collections/proteus3_instruments.sf2 All Perc 3
    midi (scale :e3, :harmonic_minor).tick, sustain: 0.1, channel: 5, velocity: 50
    sleep 0.25
  end

  live_loop :arrrrp do
    use_bpm 30
    sync :tick
    2.times { arpeggiate [5,4,2], :e1, :harmonic_minor, [5,4,6], 1 }
  end
end

#----------------------



# Welcome to Sonic Pi
# Welcome to Sonic Pi
# Count every beat
use_bpm 45

live_loop :bar do
  cue :tick
  sleep 1
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tick
  cue :every_two_bars
  sample :elec_blip, amp: 0.5, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.5, rate: 2.0
  sleep 16
end

live_loop :abeat do
  #sync :tick
  use_random_seed 124
  4.times do
    x = SOUNDS, "plagasul", pick
    sample x, attack: 0.0125
    sleep 0.25
    #sleep sample_duration x
  end
end

live_loop :eerp do


  use_random_seed 6067
  x = (ring 110,111,112,113)
  2.times do
    sample SOUNDS, "pizz", pick, attack: 0.0125
    sleep 0.5
    2.times do
      sample SOUNDS, "pizz", pick, attack: 0.0125, release: 0.125
      sleep 0.25
    end
  end

end

live_loop :epi do
  sync :every_four_bars
  sample SOUNDS, "RC_Cut_020"
end

live_loop :beat do
  sync :tick
  use_random_seed 48
  sample SOUNDS, "RC", pick, attack: 0.125, beat_stretch: 1
end

#bflat gflat

#_-----------------------
sample :bass_drop_c, amp: 1

# Welcome to Sonic Pi
# Welcome to Sonic Pi
set_volume! 0.36
set_mixer_control! hpf: 21

def chord_player(root,repeats)
  use_synth :mod_pulse
  repeats.times do
    play chord(root, :minor), release: 0.5
    sleep 0.5
  end
end


define :afunction do |n|
  play n
end

with_fx :gverb, room: 1,damp: 0.1 do

  afunction :c5
end


uncomment do
  with_fx :reverb, room: 1, damp: 0.5 do |r|



    live_loop :test do
      use_random_seed 3657

      #notes = chord :d, :major

      notes = scale :e3, :iwato

      with_fx :mono do
        with_fx :reverb, room: 0.1, damp: 0.2 do
          4.times do
            use_synth :piano
            play notes.choose, sustain: 0.5

            sleep 0.45

          end

          2.times do
            use_synth :pluck
            play notes.tick, release: 1
            sleep 0.125
          end

        end
      end

      #x = dice 6
      print rand_i_look(5)
      control r, room: 0.25
      #if x == 3
      with_fx :reverb, room: 1, damp: 0.5 do
        with_fx :pan, pan: rrand(-1,1) do
          with_fx :echo, decay: 8, phase: 0.25, mix: 0.25 do
            2.times do
              sample :tabla_dhec
              sleep 0.5
            end
          end
        end
      end

    end

    live_loop :drum do
      sync :test
      sample :drum_snare_hard
      sleep 4
    end



  end


end

#---------------------------
  live_loop :kick do
    use_random_seed 23232
    2.times do
      sample DRUMKITS, "PL_Kick",pick, cutoff: 110, attack: 0.0125
      sleep 0.5
    end

  end

comment do
  live_loop :kick do
    use_random_seed 23232
    2.times do
      sample DRUMKITS, "PL_Kick",pick, cutoff: 110, attack: 0.0125
      sleep 0.5
    end

  end
end

#with_fx :ring_mod, mix: 0, freq: 20, freq_slide: 0.25 do |freq|

comment do
  live_loop :beat1 do

    #sample SOUNDS, "PL_127bpm_RollDrums_Drums", pan: [-0.55, -0.35, 0, 0.35, 0.55].choose,
    #amp: 0.8, num_slices: 4, slice: 3, start: 0.1, finish: 0.65
    play (octs :d2, 3).tick, pitch: 0, amp: 0 do |n|
      control n, amp: 0.75
    end


    sleep 0.25

  end
end
comment do
  live_loop :ring_mod do
    a = sync "/osc*/1/*"
    print a
    #control freq, freq: a[0], mix: 0.5

  end
end

#end


live_loop :tester do
  b = sync "/osc*/4/multipush1/*/*"
  if b[0]==1 #pushed
    res= parse_sync_address "/osc*/4/multipush1/*/*"
    puts res #to show what the parse function returns
    puts "The switch pushed was in column ",res[3],"and row ",res[4]
  end
end

#---------------
# Welcome to Sonic Pi
# Before running this file, first run helpers/play_helper.rb to load the pl function

use_bpm 90

# pass it an array with pairs of note+duration:
#pl [:C, 1, :D, 1, :E, 1, :C, 1]

# you can optionally pass sustain and release values as a fraction of total duration:
#pl [:C, 1, :D, 1, :E, 1, :C, 1], 0.2, 0.2

# slur notes by passing the notes and lengths inside arrays:
#pl [[:E, :F, :G], [1, 1, 2]]

# you can also play chords:
define :pl_midi do |notes, sus: 0.5, rel: 0.5|
  rel ||= 1 - sus
  notes.each_slice(2) {|x,y| print y }
  notes.each_slice(2) do |n,d|
    if d.respond_to?(:each) then # slur
      dtot = d.reduce(:+)
      synth = midi n[0], velocity: 50
      sleep d[0]
      d[1..-1].zip(n[1..-1]).each do |dd, nn|
        control synth, note: nn
        sleep dd
      end
    else
      midi n[0], velocity: 50, channel: 1

      sleep d
    end
  end
end
# 4.times do
#   pl_midi [60,0.125]
# end
pl_midi [[:E, :F, :G], [1, 1, 2]]

#-------------------


# Welcome to Sonic Pi
#activate_transport

#set_bpm(89)

#start_transport
use_bpm 140
use_real_time
live_loop :bar do
  cue :tick
  sleep 1
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tick
  cue :every_two_bars
  sample :elec_blip, amp: 0.5, rate: 1.5
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tick
  cue :every_four_bars
  sample :elec_blip, amp: 0.5, rate: 2.0
  sleep 16
end

comment do
  use_synth :piano
  use_midi_defaults channel: 1
  midi_chord (chord_degree :iii, :d3, :major, 3, invert: 1)

  filter = lambda do |candidates|
    [candidates.choose]
  end

  8.times do
    sample SOUNDS, "PL_Perc_", filter
    sleep 0.25
  end
end
live_loop :rim do
  use_random_seed 87874
  #sync :tick
  #sample SOUNDS, /37rim_n/, amp: 0.6, pan: 0.3 if spread(2,8).look
    filter = lambda do |candidates|
      [candidates.choose]
    end
  8.times do
    sample DRUMKITS, /acoustic-/, filter, amp: 0.6, pan: 0.3
    sleep 0.25
  end
end

#sleep 4
with_fx :compressor, threshold: 0.1, slope_above: 0.5, slope_below: 1, clamp_time: 0.01, mix: 0 do
  with_fx :mono, amp: 1 do
    live_loop :beat do
      use_random_seed 23232
      #sync :tick
      filter = lambda do |candidates|
        [candidates.choose]
      end

      with_fx :hpf, cutoff: 40 do
        4.times do
          sample SOUNDS, "JoMox_Kick_69", filter if spread(3,8).tick
          #sample SOUNDS, "JoMoX_Kick_", amp: 0.8 if spread(2,4).look

          sleep 0.125
        end

      end
    end
  end
end
use_bpm 120
with_fx :sound_out_stereo, output: 3, amp: 0 do
  live_loop :smpl do


    filter = lambda do |candidates|
      [candidates.choose]
    end
    sample SOUNDS, "JoMoX_SMPL_01_", filter, amp: 0.5, pan: -0.5 if spread(2,5).tick
    sleep 0.125
    sample SOUNDS, "JoMoX_SMPL_03_", filter, amp: 0.5, pan: -0.1 if spread(4,7).look
    sleep 0.25
  end

end


live_loop :afgit do
  sync :tick
  #use_bpm 45
  stop

  2.times do

    sample SOUNDS, "EM_AfricanEasyDrums_120bpm_02", amp: 3, onset: (range 0,12).tick
    sleep sample_duration SOUNDS, "EM_AfricanEasyDrums_120bpm_02", amp: 3, onset: (range 0,12).tick
  end
end


live_loop :loopy, sync: :every_two_bars do
  stop
  use_random_seed 2321
  4.times do
    sample SOUNDS, "PL_160bpm_DrumLoop01", onset: (range 0,5).tick
    sleep [0.25,0.5].choose
  end

end

live_loop :loopydo, sync: :every_four_bars do

  #2.times do
  #  sample SOUNDS, "PL_160bpm_DrumLoop05", onset: (range 0,4).tick
  #  sleep 0.5
  #end
  #sleep 0.5
  3.times do
    sample SOUNDS, "BP_FX_128bpm_Loop_", pick, onset: (range 0,4).tick
    sleep [0.125,0.25].choose
  end



end

#-----------------------


## Welcome to Sonic Pi

define :parse_sync_address do |address| # used to retrieve data which matched wild card in synced event
  v= get_event(address).to_s.split(",")[6]
  if v != nil
    return v[3..-2].split("/")
  else
    return ["error"]
  end
end

#live_loop :oscin do
# a = sync "/osc*/*/fader2"

#puts a[0].to_i

#end
comment do
  load_synthdefs "/home/b08x/.sonic-pi/synthdefs/compiled"
  live_loop :whoosher do
    with_fx :reverb, mix: 0.5, room: 0.7 do

      synth :whoosh, freq_from: rrand( 20, 1000 ),
        freq_to: rrand( 20, 15000 ),
        time: rrand( 2, 8 ),
        lfo_depth: rrand( 0, 0.4 ), lfo_rate: rrand( 0.3, 15 ),
        pan: rrand( -1, 1 )
    end
    sleep 1
  end

end
comment do
  #with_fx :sound_out_stereo, output: 3, amp: 0 do
  live_loop :fungi do
    4.times do
      #sample SOUNDS, "1-clean-loop-50", onset: (range 0,4 , inclusive: true).tick
      sample SOUNDS, "8-dirty-loop-197", onset: (ring 2,4,6).tick
      x = sample_duration SOUNDS, "1-clean-loop-50"
      sleep 0.75
      6.times do
        sample SOUNDS, "1-clean-loop-50", onset: (range 6,12, inclusive: true).tick
        sleep 0.25
      end
    end
    sleep 1

    #sample SOUNDS, "85bpm_Abmin_BR_SlowFunk_1", onset: (range 8,12).tick
    #sleep 0.5
  end
  #end
end
use_bpm 45
define :arpeggiate do |prog, tonic, mode=:major, pattern=[0, 1, 2, 3], reps=2|
  sc = scale(tonic, mode, num_octaves: 4)
  prog.each do |deg|
    puts "prog", prog
    reps.times do
      #with_synth :piano do
      midi sc[deg-1] - 12, sustain: 0.9 /2, amp: 1.5, velocity: 110, channel: 4
      #end
      #t = 1.0 / pattern.length
      t = 0.25
      pattern.each do |i|
        n = sc[deg - 1 + 2*i + (i+1) / 4]
        #puts "n", n
        with_fx :lpf, cutoff: 50 do
          with_synth :beep do
            play n, sustain: 1.5 * t, amp: 0.8
          end
        end

        sleep t
      end
    end
  end
end
live_loop :anotherarp do
  # stop
  # cue :bassline
  arpeggiate [4,3,2], :g4, :minor, [3,0,1,2], 2
  #2.times { arpeggiate [6,7], :a3, :minor}
end

def partone
  2.times do
    play (note_range :d3, :d4, pitches: (chord :f, :M7)).tick, pan: -0.5, pitch: 0
    sleep 0.25
  end
end

def parttwo
  2.times do
    play (note_range :d3, :d4, pitches: (chord :f, :M7)).tick, pan: -0.5, pitch: 0
    sleep 0.125
  end
  4.times do
    2.times do
      midi (note_range :d3, :d4, pitches: (chord :g, :M)).pick, pan: 0.8, pitch: -12 do |q|
        control q, pitch: 0
      end
      sleep 0.125

    end
    2.times do
      midi (note_range :d3, :d5, pitches: (chord :a, :sus2)).pick, pan: 0.5, pitch: 0, pitch_slide: 0.25, channel: 8 do |p|
        control p, pitch: 12
      end
      sleep 0.25
    end
  end
end

live_loop :arpeggiator do
  #use_random_seed 999
  #sync :bassline
  use_synth :piano
  midi (note_range :c3, :c5, pitches: (chord :a, :min)).look, pan: 0.8, pitch: 12, channel: 1, velocity: 70, velocity_f: 72
  sleep 0.125
  #partone
  parttwo
  #sleep 1
end


#-----------------------

use_bpm 45

def sample_slice(samplefile,start,finish,sl=[0.5,1])
  s = sample SOUNDS, samplefile, start: start, finish: finish

  control s, hpf: 30

  sleep 1
end

#  live_loop :drumyloop do
    #4.times do
    12.times do
      sample_slice(:EM_Cosmic_Sitar_C_120bpm_03,0,0.25)
      sleep 1
    end
    #end

#  end

def sample_thing(samplename)
  x = SOUNDS, samplename

end


live_loop :abassline do
  stop
  use_bpm 45
  use_random_seed 9870
  6.times do
    x = SOUNDS, "PL_127bpm_Crackle_Drums"
    sample x, onset: range(0,4).choose
    sleep 0.28
  end

end



#
# live_loop :drumloop do
#   sample SOUNDS, loopfile, beat_stretch: 4, start: 0, finish: 0.125
#   sleep 0.5
#   sample SOUNDS, loopfile, beat_stretch: 4, start: 0, finish: 0.125
#   sleep 0.5
#   sample SOUNDS, loopfile, beat_stretch: 4, start: 0.5, finish: 0.75
#   play :A1
#   sleep 1
#   sample SOUNDS, loopfile, beat_stretch: 4, start: 0.25, finish: 0.5
#   sleep 1
#   sample SOUNDS, loopfile, beat_stretch: 4, start: 0.75, finish: 0.875
#   sleep 0.5
#   sample SOUNDS, loopfile, beat_stretch: 4, start: 0.25, finish: 0.375
#   sleep 0.5
# end


#------------------------------------------------------------------------

comment do
  live_loop :t do
    notes = (ring 33, 40, 52, 45, 50, 45, 38, 45, 48, 36, 33, 36, 47, 45, 40, 45)

    variable_name = midi notes.tick, attack: 0.0125

    sleep 0.55

  end
end
