set_mixer_control! hpf: 21

max_t = 8 # Adjust the run time of the piece
$global_clock = 0
use_bpm 60
set_volume! 2
set_sched_ahead_time! 2
use_cue_logging false
# SEED = 471646
# SEED = 32625
# SEED = 489370
SEED = 746742
# SEED = Time.now.usec # uncomment this to get a different run every time
# puts "Epoch seed: #{SEED}"
use_random_seed SEED

################ FUNCTIONS ########################

define :stopwatch do |int, max, fade|
  ## interval in seconds (display for log timer),
  ## max in mins, fade in secs
  count = 0
  set_mixer_control! amp: 1, amp_slide: 0.1
  with_bpm 60 do
    ctrl = true
    while count / 60.0 <= max
      if count % int == 0
        puts "Time: #{count / 60.0} Minutes"
      end
      count += 1
      sleep 1
      $global_clock = count / 60.0
      if count >= (max*60) - fade && ctrl == true
        set_mixer_control! amp: 0.01, amp_slide: fade
        puts "Stopping - #{fade} sec fadeout"
        ctrl = false # stops this block from running more than once
      end
    end
  end
end

define :autocue do |id, time|
  # send a cue after a specified time in decimal minutes, id must be a key
  # call in the loop you're syncing to
  return cue id if $global_clock >= time
end

define :autostop do |time|
  # same as :autocue but for stopping - call in the loop you want to stop
  return stop if $global_clock >= time
end


define :mk_rand_scale do |scale, len = 8|
  # random scale that may contain the same note more than once
  rand_s = []
  len.times do
    rand_s << scale.choose
  end
  return rand_s.ring
end
#############  CLOCK  #####################

comment do
  in_thread do
    stopwatch(30, max_t, max_t*60*0.1)
  end
end

#live_audio :yoshimi, input: 3, stereo: true
uncomment do
  live_loop :easingin do
    with_fx :slicer, wave: 3, smooth: 0.10 do
      with_fx :tremolo do
        sample :vinyl_hiss, amp: 0.85, amp_slide: 8, rate: 0.5, sustain: 4, sustain_level: 0.8,
        release: 0.125, pan: rrand(-0.6, 0.6), pan_slide: 8 do |hiss|
          control hiss, pan: rrand(-0.6, 0.6)
        end
        sleep 4
      end
    end
  end

  #### laughtr soundscape
  # comment from Ann; the clinky dishes was somehow relaxing....
  live_loop :laughter do
    sample SAMPLES, "donteattheeggs", start: 0.50, finish: 1, attack: 2, release: 0.5, rate: 1, amp: 0.75
    sleep sample_duration SAMPLES, "donteattheeggs", start: 0.50, finish: 1
  end



  live_loop :rain01 do
    with_fx :level, amp: 0.2 do
      with_fx :mono, pan: -0.9 do
        sample SAMPLES, 'rain', attack: 12, release: 2, amp: 0.3
        sleep sample_duration SAMPLES, 'rain', attack: 12, release: 2
      end
    end
  end

  live_loop :rain02 do
    with_fx :level, amp: 0.2 do
      with_fx :mono, pan: 0.9 do
        sample SAMPLES, 'rain', attack: 12, release: 2, amp: 0.3
        sleep sample_duration SAMPLES, 'rain', attack: 12, release: 2
      end
    end
  end




end




############## TUNED RESONATED DRONE  #########################
comment do
  live_loop :drone, auto_cue: false do

    autostop(max_t)
    autocue(:prb, (rrand 0, max_t*0.3)) # cues up all the other loops, within specified time range
    autocue(:pulse, (rrand 0, max_t*0.4))
    autocue(:stc, (rrand 0, max_t*0.3))
    autocue(:trans, (rrand max_t*0.2, max_t*0.5))
    scl = scale(:c5, :harmonic_minor, num_octaves: 1)[0..4]
    notes = mk_rand_scale(scl, 4)

    puts "Drone sequence: #{notes}"
    notes.size.times do
      frq = midi_to_hz(notes.tick) # converts scale to frequency for resonator effect
      del = 1.0 / frq # plug this into SP's echo...
      # use echo to produced tuned resonance - avoid setting decay too high!
      with_fx :echo, amp: 1, mix: 1, phase: del, decay: 2 do
        sample :ambi_drone, attack: 0.6,
          pan: 0, amp: 0.75, rate: 0.5, cutoff: 117.5
        sleep 8
      end
    end
  end

end




#before we dissolve
uncomment do
  #sample SAMPLES, "wrongrules", amp: 1

  in_thread do
    #on the high end of things, might tone down between 630 - 2000Hz to reduce sharp sibilance
    with_fx :band_eq, freq: 88, res: 0.6, db: -16 do

      with_fx :band_eq, freq: 96, res: 0.4, db: -16 do
        with_fx :band_eq, freq: 75, res: 0.2, db: -16 do
          sample SAMPLES, "beforewedissolve", start: 0.10, finish: 0.50
          sleep sample_duration SAMPLES, "beforewedissolve", start: 0.10, finish: 0.50



          sample SAMPLES, "beforewedissolve", start: 0.525, finish: 0.940
          sleep sample_duration SAMPLES, "beforewedissolve", start: 0.525, finish: 0.940

        end
      end

    end
  end

end
