### Helper functions and variables that can be used with the toolbox ###
use_sched_ahead_time 1
use_midi_defaults channel: 1, port: "midi_through_midi_through_port-0_14_0"

# edit

# Based on minor pentatonic on G
DEFAULT_LIST_BUBBLE = [33, 40, 52, 45, 50, 45, 38, 45, 48, 36, 33, 36, 47, 45, 40, 45]

# Unsorted array based on hirajoshi scale
DEFAULT_LIST_SELECT_INSERT = [82, 81, 70, 62, 57, 74, 86, 55, 67, 75, 79, 63, 58, 69, 87, 91]

# Custom-made list
DEFAULT_LIST_MERGE = [79, 76, 67, 59, 55, 71, 52, 64, 74, 83, 62, 86]

notes = (ring 33, 40, 52, 45, 50, 45, 38, 45, 48, 36, 33, 36, 47, 45, 40, 45)
durations = (ring 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5)
durations01 = (knit 0.25, 8)

transpose = 0
rel = 0.5 # release time (multiplier of duration)


live_loop :tick do
  4.times do |bar|
    puts "bar no: " + (bar + 1).to_s
    4.times do |beat|
      puts "beat no: " + (beat + 1).to_s
      cue :tick
      sleep 1
    end
  end
end

use_bpm 45
with_fx :reverb, room: 0.2 do
  live_loop :merge do

    with_octave -3 do
      merge_sort(synths_amp: -0.3, shutup_synths: false, shutup_percs: false, silence: false)
    end
  end

  live_loop :selection, sync: :tick do
    with_octave -3 do
      selection_sort(shutup_synths: false, play_list: false, shutup_drums: false)
    end
  end

  # live_loop :insert, sync: :tick do
  #   use_synth :piano
  #   density 2 do
  #
  #     insertion_sort(amp: 0.6, shutup_synths: true, shutup_drums: false, play_list: false)
  #     sleep [0.125,0.25].choose
  #
  #   end
  #   #end
  # end

  live_loop :bubble, sync: :tick do
    #stop
    with_octave -3 do
      bubble_sort(amp: 0.6, shutup_drums: false, shutup_synths: false, play_list: true)
    end

  end

  live_loop :rcbreak, sync: :tick do
    #stop
    use_bpm 45
    sample SOUNDS, :RC_21_95bpm_Break_DurtyC, beat_stretch: 4, onset: (range 0, 4).tick, amp: 0.75
    sleep 0.25
  end

  live_loop :helm_bassline, sync: :tick do
    stop
    use_bpm 45

    i = tick
    1.times do
      currentNote = notes.look + 12
      currentDuration = durations.look
      if currentNote != 128 # rest
        my_note = midi currentNote, sustain: currentDuration, channel: 1, release: rel, velocity: 90
      end
      sleep currentDuration
    end
  end
end
