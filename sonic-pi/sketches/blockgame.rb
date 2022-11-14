# Blockgame
# Coded by DJ_Dave
# ReCoded with b08x


set_volume! 0.66
set_mixer_control! hpf: 21
#use_sched_ahead_time 1

use_real_time
#use_bpm 89


live_loop :tock do
  4.times do |bar|
    puts "bar no: " + (bar + 1).to_s
    4.times do |beat|
      puts "beat no: " + (beat + 1).to_s
      cue :tock
      sleep 1
    end
  end
end

# Sync 2-bar patterns
live_loop :two_bars, autocue: false do
  sync :tock
  cue :every_two_bars
  sample :elec_blip, amp: 0.0125, rate: 1
  sleep 8
end

# Synch 4-bar patterns
live_loop :four_bars, autocue: false do
  sync :tock
  cue :every_four_bars
  sample :elec_blip, amp: 0.0125, rate: 2.0
  sleep 16
end



cmaster1 = 95
cmaster2 = 130

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end

@filter = lambda do |candidates|
  [candidates.tick]
end


live_loop :seq1 do
  #use_real_time
  # this will be either 1 or 0
  onoff = sync "/osc*/ll/*"
  
  # this will be in a range from 1-16
  index = parse_sync_address("/osc*/ll/*")[3].to_i
  
  set :stop, onoff
  print get[:stop][0]
  
  #print index
  
end

def perc1()
  set :kill1,false
  
  s1 = SOUNDS, "perc1_", @filter
  
  live_loop :perc1, sync: :tock do
    #stop
    sample s1, amp: 1.25, pan: -0.25 if pattern "-x--x---x--x"
    sleep 0.5
    
  end
  
end

perc1

live_loop :rice, sync: :tock do
  #stop
  with_fx :echo, pre_mix: 0.7, phase: 0.125, decay: 0.9, amp_slide: 10 do |e|
    control e, amp: 0.25
    with_fx :panslicer, mix: 0.8 do
      sample SOUNDS, /Rice/, @filter, amp: 1.25,  pan: rrand(-0.6,-0.25), rate: 1.5, cutoff: 110 if pattern "-x--x---x--x"
      sleep 0.25
    end
  end
end

with_fx :echo, mix: 0.2 do
  with_fx :reverb, mix: 0.2, room: 0.5 do
    live_loop :box, sync: :tock do
      #stop
      a = 0.80
      density 1 do
        sleep 1
        sample SOUNDS, "Box1", rate: 2.5, cutoff: cmaster1, amp: a
        sleep 0.25
        sample SOUNDS, "Box2", rate: 2.2, start: 0.02, cutoff: cmaster1, pan: 0.2, amp: a
        sample SOUNDS, "Box3", rate: 2, start: 0.04, cutoff: cmaster1, pan: -0.2, amp: a
        sleep 1
      end
    end
    
    live_loop :bucket, sync: :tock do
      #stop
      a = 0.75
      density 2 do
        sleep 1
        with_fx :pan, pan: -0.65 do
          sample SOUNDS, "Bucket1", rate: 2.5, cutoff: cmaster1, amp: a
          sample SOUNDS, "Bucket2", rate: 2.2, start: 0.02, cutoff: cmaster1, amp: a
          sleep 0.25
          sample SOUNDS, "Bucket3", rate: 2, start: 0.04, cutoff: cmaster1, amp: a
        end
        sleep 1
      end
    end
    
    live_loop :bottle, sync: :tock do
      
      #stop
      
      a = 0.45
      
      sleep 1
      with_fx :pan, pan: -0.85 do
        sample SOUNDS, "Bottle10", rate: 2.5, cutoff: cmaster1, amp: a
        sample SOUNDS, "Bottle11", rate: 2.2, start: 0.02, cutoff: cmaster1, amp: a
        sleep 0.25
        sample SOUNDS, "Bottle14", rate: 2, start: 0.04, cutoff: cmaster1, amp: a
      end
      sleep 4
      
    end
    
    
  end
end

with_fx :echo, pre_mix: 0.7, phase: 0.125, decay: 0.9, amp_slide: 10 do |e|
  control e, amp: 0.55
  live_loop :plate, sync: :tock do
    
    #stop
    
    with_fx :panslicer, mix: 0.8 do
      with_fx :lpf, cutoff: 110 do
        4.times do
          sample SOUNDS, "PlateOmni_", @filter, amp: 0.65,  pan: rrand(-0.8,-0.35), rate: 1.5, cutoff: 110 if pattern "-x--x---x--x"
          sleep 0.25
        end
        2.times do
          sample SOUNDS, /Frying/, @filter, amp: 0.65,  pan: rrand(-0.8,-0.35), rate: 1.5, cutoff: 110 if pattern "-x--x---x--x"
          sleep 0.25
        end
        
      end
      
    end
    
  end
  
  live_loop :hhc2, sync: :tock do
    stop
    a = 0.45
    sleep 0.5
    sample DRUMKITS, /hihat_closed_C/, @filter , pan: -0.5, cutoff: cmaster2, rate: 1.2, start: 0.01, finish: 0.5, amp: a
    sleep 0.5
  end
end

with_fx :reverb, mix: 0.7 do
  live_loop :crash, sync: :tock do
    stop
    a = 0.45
    c = cmaster2-10
    r = 1.5
    f = 0.5
    with_fx :echo, phase: 1, decay: 0.125, mix: (line 0.1, 1, steps: 128).mirror.tick do
      sleep 14.5
      sample SOUNDS, "g5_V03", amp: a, cutoff: c, rate: r, finish: f
      sample SOUNDS, "d4_V03", amp: a, cutoff: c, rate: r-0.2, finish: f
      sleep 1
      sample SOUNDS, "c4_V03", amp: a, cutoff: c, rate: r, finish: f
      sample SOUNDS, "a5_V03", amp: a, cutoff: c, rate: r-0.2, finish: f
      sleep 0.5
    end
  end
end

live_loop :kick1, sync: :tock do
  stop
  a = 1.0
  2.times do
    sample SOUNDS, "20220204_48_tom", @filter, amp: a, cutoff: cmaster1 if pattern "x---x---x---"
    sleep 0.25
  end
  
  2.times do
    sample SOUNDS, "20220204_48_tom", @filter, amp: a, cutoff: cmaster1 if pattern "x-------x--x"
    sleep 0.25
  end
end


with_fx :reverb, room: 0.2, mix: 0.5, damp: 0.8 do
  with_fx :panslicer, mix: 0.2 do
    live_loop :hhc1, sync: :tock do
      stop
      a = 0.85
      p = [-0.3, 0.3].choose
      sample :drum_cymbal_closed, amp: a, rate: 2.5, finish: 0.5, pan: p, cutoff: cmaster2 if pattern "x-x-x-x-x-x-x-x-xxx-x-x-x-x-x-x-"
      sleep 0.125
    end
  end
end



with_fx :reverb, mix: 0.7 do
  live_loop :arp, sync: :tock do
    with_fx :echo, phase: 1, mix: (line 0.1, 1, steps: 128).mirror.tick do
      stop
      a = 1.5
      r = 0.25
      c = 130
      p = (line -0.7, 0.7, steps: 64).mirror.tick
      at = 0.01
      use_synth :pluck
      tick
      notes = (scale :g4, :major_pentatonic).mirror
      2.times do
        play notes.tick, amp: a, release: r, cutoff: c, pan: p, attack: at, detune: 12
        sleep [0.75,0.50].tick
      end
    end
  end
end
live_audio :monique, input: 1, stereo: true
chords = [ (chord :e3, :m),
           (chord :e3, :m7),
           (chord :g3, :M),
           (chord :a3, :sus2),
           (chord :e3, :sus4),
           (chord :b3, :sus4) ]

with_fx :reverb, mix: 0.7 do
  live_loop :arp2, sync: :tock do
    with_fx :echo, phase: 1, mix: (line 0.1, 1, steps: 128).mirror.tick do
      stop
      a = 0.25
      r = 0.25
      c = 130
      p = (line -0.8, -0.3, steps: 64).mirror.tick
      at = 0.01
      use_synth :beep
      tick
      notes = chords.flatten.uniq.ring.mirror
      4.times do
        play notes.tick, amp: a, release: r, cutoff: c, pan: p, attack: at, detune: 12
        sleep [0.25,0.5].tick
      end
    end
  end
end


with_fx :panslicer, mix: 0.4 do
  with_fx :reverb, mix: 0.75 do
    live_loop :synthbass, sync: :tock do
      stop
      s = 4
      r = 2
      c = 60
      a = 0.5
      at = 0
      use_synth :pluck
      play :g3, sustain: 6, cutoff: c, amp: a, attack: at
      sleep 6
      play :d3, sustain: 2, cutoff: c, amp: a, attack: at
      sleep 2
      play :e3, sustain: 8, cutoff: c, amp: a, attack: at
      sleep 8
    end
  end
end
