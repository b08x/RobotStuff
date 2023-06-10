# Welcome to Sonic Pi
set_mixer_control! hpf: 21
#set_volume! 1

run_file "/home/b08x/Workspace/robot-stuff/sonic-pi/sketches/introduction.rb"

use_bpm 60

use_debug true

in_thread do
  loop do
    cue :tick
    sleep 1
  end
end

# ├─ (ring <SonicPi::Chord :D :m7 [38, 41, 45, 48])
# ├─ (ring <SonicPi::Chord :G :7 [43, 47, 50, 53])
# ├─ (ring <SonicPi::Chord :C :M7 [36, 40, 43, 47])
# └─ (ring <SonicPi::Chord :F :M7 [41, 45, 48, 52])
#
# chords = [ (chord :d2, 'm7')
# print chord :g2, '7'
# print chord :c2, 'M7'
# print chord :f2, 'M7'

with_fx :reverb, room: 0.1, damp: 0.5 do
  
  #live_audio :helm, input: 3, stereo: true
  
  # fade in to wobbly vinyl hiss
  @hissloop = in_thread(name: :hiss_loop) do
    ampr = 3
    
    with_fx :level, amp: 0, amp_slide: 8 do |a|
      control a, amp: ampr
      
      loop do
        hiss
      end
      
    end
  end
  
  sleep 24
  
  live_loop :background do
    sleepypants = sample_duration SAMPLES, "wedrankthewater", start: 0.825, finish: 0.97, attack: 2, release: 0.3, rate: 0.5
    
    with_fx :level, amp: 0, amp_slide: 8 do |a|
      control a, amp: 3
      
      8.times do |x|
        print x
        if x == 7
          control a, amp: 0.7, amp_slide: 2
        end
        with_fx :echo, phase: 0.125, decay: 8, pre_mix: 0.4 do
          with_fx :bpf, centre: 82, res: 0.75, pre_mix: 0.5 do
            sample SAMPLES, "wedrankthewater", start: 0.825, finish: 0.9681, attack: 2, release: 0.3, amp: 1, rate: 0.5, pitch: 6, pan: rrand(0.8,0.5), pan_slide: 6 do |x|
              control x, pan: rrand(-0.4,-0.2)
            end
          end
        end
        sleep sleepypants.round(3)
      end
    end
  end
  
  #TDOD: some sort of fade in/fade out method
  def lab_ambience
    @lab_ambience = in_thread(name: :lab_ambience) do
      ampr = 1
      with_fx :sound_out, output: 6, amp: 0 do
        with_fx :level, amp: 0, amp_slide: 18 do |a|
          control a, amp: ampr
          sample SOUNDS, "014_qubodup_sci-fi-laboratory-ambience", start: 0, finish: 0.5, amp: 0.45, pan: -0.125, hpf: 40
        end
      end
    end
  end
  
  lab_ambience
  
  with_fx :sound_out_stereo, output: 3, amp: 0 do
    @laughamp = 0.35
    with_fx :level, amp: 0, amp_slide: 4 do |x|
      live_loop :laughter do
        control x, amp: @laughamp
        sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 0.125, release: 0.125, rate: 1
        sleep (sample_duration SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5 - 0.125)
      end
    end
  end
  
  defonce :one do
    with_fx :reverb, room: 0.8, damp: 0.3 do
      print "but we drank the water"
      sample SAMPLES, "wedrankthewater", start: 0.28, finish: 0.35, amp: 0.8, attack: 0.25
      
      sleep 8
      
      print "yeah"
      sample SAMPLES, "wedrankthewater", start: 0.44, finish: 0.5, amp: 0.8
      sleep 20
    end
  end
  
  # one
  
  def eggs01
    with_fx :pan, pan: -0.7 do
      with_fx :reverb, mix: 0.5, damp: 0.2, room: 0.6 do
        with_fx :echo, phase: 0.8, decay: 8, amp_slide: 10 do |e|
          control e, amp: 0.25
          with_fx :mono do
            sample SAMPLES, "donteattheeggs", start: 0.345, finish: 0.379, attack: 0.25, release: 0.125, amp: 0.8
          end
        end
      end
    end
  end
  
  
  def shake_rattle_brush
    2.times do |x|
      with_fx :echo, mix: 0.5, decay: 1.2, phase: 0.8 do
        with_fx :band_eq, freq: 112, db: 3, res: 0.6 do
          with_fx :level, amp: 0.45 do
            with_fx :bitcrusher, cutoff: 40, mix: 0.1 do
              with_fx :lpf, cutoff: 100 do
                sample SAMPLES, "001_incarnadine_shake-rattle-and-brush.flac", hpf: 45, start: 0.0125, finish: 0.8,
                  beat_stretch: 4, pitch: -12, attack: 2, release: 1, rate: range(1, -1, step: 2, inclusive: true).tick
              end
            end
          end
        end
      end
      sleep 20
    end
  end
  
  
  print "emd of intro"
  
  live_loop :background do
    stop
  end
  
  
  
  def electromagnetic_hum
    ampr = 1
    
    with_fx :level, amp: 0, amp_slide: 10 do |a|
      control a, amp: ampr
      
      sample COLLECTIONS, "Electromagnetic_Fields_Hum_Buzzing", start: 0, finish: 0.25, amp: 2.0, amp_slide: 10 do |hum|
        control hum, amp: 0.0
      end
      
      
    end
  end
  
  def drip
    in_thread(name: :drip) do
      puts "begin drip"
      sample SAMPLES, "008_sclolex_water-dripping-in-cave", pan: -0.45
      puts "end drip"
    end
  end
  
  
  
  
  
  
  
end
