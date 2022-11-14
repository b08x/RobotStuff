# Blockgame
# Coded by DJ_Dave
# ReCoded with b08x


set_volume! 0.66
set_mixer_control! hpf: 21
use_sched_ahead_time 1

#use_real_time

live_loop :tock do
  puts "current bpm " + current_bpm.to_s
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

with_fx :level, amp: 0.75 do
  with_fx :pan, pan: -0.25 do
    live_audio :monique, input: 5, stereo: true
  end
end

with_fx :level, amp: 0.75 do
  with_fx :pan, pan: -0.25 do
    live_audio :helm, input: 7, stereo: true
  end
end

cmaster1 = 95
cmaster2 = 130

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end

filter = lambda do |candidates|
  [candidates.tick]
end


live_loop :perc1, sync: :tock do
  #link
  #stop
  with_fx :reverb, room: 0.8, damp: 0.1, pre_mix: 1.0 do
    with_fx :hpf, cutoff: 40 do
      #density 2 do
      8.times do
        sample SOUNDS, "Djembe2 Bass", filter, amp: 0.25,  pan: rrand(-0.6,-0.25)  if pattern "----x---x--x"
        sleep 1

        sample SOUNDS, "Djembe3 Tone", filter, amp: 0.3,  pan: rrand(-0.6,-0.25)  if pattern "----x---x--x"
      end

      sample SOUNDS, "Kenkeni1 Bell Mute", filter, amp: 0.25,  pan: rrand(-0.6,-0.25)  if pattern "x---x---x--x"
      sleep 0.25
      #end

    end
  end

end

live_loop :rice, sync: :tock do
  #stop
  with_fx :echo, pre_mix: 0.8, phase: 0.125, decay: 0.9, amp_slide: 10 do |e|
    control e, amp: 0.8
    with_fx :panslicer, mix: 0.8 do
      density 2 do
        sample SOUNDS, /Rice/, filter, amp: 0.75,  pan: rrand(-0.6,-0.25), rate: 1.25, cutoff: 110 if pattern "----x---x--x"
        sleep 0.25
      end
    end
  end
end


live_loop :box, sync: :tock do
  #stop
  a = 0.80
  with_fx :echo, mix: 0.2 do
    with_fx :reverb, mix: 0.2, room: 0.5 do
      density 1 do
        sleep 1
        sample SOUNDS, "Box1", rate: 2.5, cutoff: cmaster1, amp: a
        sleep 0.25
        sample SOUNDS, "Box2", rate: 2.2, start: 0.02, cutoff: cmaster1, pan: 0.2, amp: a
        sample SOUNDS, "Box3", rate: 2, start: 0.04, cutoff: cmaster1, pan: -0.2, amp: a
        sleep 1
      end
    end

    live_loop :bucket, sync: :box do
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
        sleep 0.5
      end
    end

    live_loop :bottle, sync: :tock do
      #stop
      a = 0.5
      sleep 1

      with_fx :pan, pan: -0.85 do
        sample SOUNDS, "Bottle10", rate: 2.5, cutoff: cmaster1, amp: a
        sample SOUNDS, "Bottle11", rate: 2.2, start: 0.02, cutoff: cmaster1, amp: a
        sleep 0.25
        sample SOUNDS, "Bottle14", rate: 2, start: 0.04, cutoff: cmaster1, amp: a
      end
      sleep 8

    end

  end
end

live_loop :plate, sync: :tock do
  #stop
  with_fx :echo, pre_mix: 0.7, phase: 0.125, decay: 0.9, amp_slide: 10 do |e|
    control e, amp: 0.55
    with_fx :panslicer, mix: 0.8 do
      with_fx :lpf, cutoff: 110 do
        4.times do
          sample SOUNDS, "PlateOmni_", filter, amp: 0.65,  pan: rrand(-0.8,-0.35), rate: 1.5, cutoff: 110 if pattern "-x--x---x--x"
          sleep 0.25
        end
        2.times do
          sample SOUNDS, /Frying/, filter, amp: 0.65,  pan: rrand(-0.8,-0.35), rate: 1.5, cutoff: 110 if pattern "-x--x---x--x"
          sleep 0.25
        end

      end

    end

  end

  live_loop :hhc2, sync: :tock do
    #stop
    a = 0.45
    sleep 0.5
    sample DRUMKITS, /hihat_open_C/, filter , pan: -0.5, cutoff: cmaster2, rate: 1.2, start: 0.01, finish: 0.5, amp: a
    sleep 0.5
  end
end


live_loop :crash, sync: :tock do
  #stop
  a = 0.45
  c = cmaster2-10
  r = 1.5
  f = 0.5
  with_fx :reverb, mix: 0.7 do
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
  #stop
  a = 1.0
  2.times do
    sample SOUNDS, "RC_Kick_01", 1, amp: 0.5, cutoff: cmaster1 if pattern "x---x---x---"
    sleep 0.25
  end

  2.times do
    sample SOUNDS, "20220204_48_tom", filter, amp: a, cutoff: cmaster1 if pattern "x-------x--x"
    sample SOUNDS, "35_smack_", filter, amp: a, cutoff: cmaster1 if pattern "x---x---x---"
    sleep 0.25
  end
end

live_loop :gravity, sync: :tock do

  8.times do |x|
    sample SOUNDS, "EM_Kanjira_Gravity_Nopitch_80bpm_03", amp: 1.8, num_slices: 4, onset: x
    sleep 0.25
  end
end

live_loop :hhc1, sync: :tock do
  #stop
  a = [0.25,0.45].tick
  p = [-0.3, 0.3].choose
  with_fx :reverb, room: 0.8, mix: 0.5, damp: 0.8 do
    with_fx :panslicer, mix: 0.2 do
      sample DRUMKITS, /hihat_closed_C/, filter, amp: a, rate: 3.5, finish: 0.5, pan: p, cutoff: cmaster2 if pattern "x-x-x-x-x-x-x-x-xxx-x-x-x-x-x-x-"
      sleep 0.125
    end
  end
end



live_loop :arp, sync: :tock do
  with_fx :reverb, mix: 0.8 do
    with_fx :echo, phase: 1, mix: (line 0.1, 1, steps: 128).mirror.tick do
      #stop
      a = 1.5
      r = 0.25
      c = 130
      p = (line -0.7, 0.7, steps: 64).mirror.tick
      at = 0.01
      use_synth :pluck
      tick
      notes = (scale :c6, :melodic_major).mirror
      density 1 do
        1.times do
          #play notes.tick, amp: a, release: r, cutoff: c, pan: p, attack: at, detune: 12
          midi notes.tick, channel: 3, port: "midi_through_midi_through_port-0_14_0", vel: 109, sustain: 0.0125
          sleep 0.25
        end
        sleep 1
      end
    end
  end
end


chords = [ (chord :e3, :m),
           (chord :e3, :m7),
           (chord :g3, :M),
           (chord :a3, :sus2),
           (chord :e3, :sus4),
           (chord :b3, :sus4) ]

live_loop :arp2, sync: :tock do
  #use_bpm 45
  print current_beat_duration
  with_fx :reverb, room: 0.3, mix: 0.7 do
    with_fx :echo, phase: 1, mix: (line 0.1, 1, steps: 128).mirror.tick do
      #stop
      a = 0.25
      r = 0.25
      c = 130
      p = (line -0.8, -0.3, steps: 64).mirror.tick
      at = 0.01
      use_synth :beep
      tick
      notes = chords.flatten.uniq.ring.mirror
      with_octave -1 do
        4.times do
          play notes.tick, amp: a, release: r,  cutoff: c, pan: p, attack: at, detune:  12
          2.times do
            midi notes.tick, channel: 1, port: "midi_through_midi_through_port-0_14_0", vel: 80, sustain: 0.125
            #sleep 0.25
          end
          sleep [0.25,0.5].tick
        end
      end
    end
  end
end




live_loop :synthbass, sync: :tock do
  stop
  s = 4
  r = 2
  c = 60
  a = 0.5
  at = 0
  use_synth :pluck
  with_fx :reverb, room: 0.1, damp: 0.8, mix: 1 do
    with_fx :panslicer, mix: 0.4 do
      with_fx :tremolo, depth: 0.225, invert_wave: 1, phase: 0.225 do
        play :g3, sustain: 6, cutoff: c, amp: a, attack: at
        sleep 6
        play :d3, sustain: 2, cutoff: c, amp: a, attack: at
        sleep 2
        play :e3, sustain: 8, cutoff: c, amp: a, attack: at
        sleep 8
      end
    end
  end
end
