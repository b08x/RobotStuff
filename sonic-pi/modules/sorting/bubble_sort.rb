# BUBBLE SORT
def bubble_sort(list: DEFAULT_LIST_BUBBLE, sorted: DEFAULT_SORTED,
  amp: 1,
  play_list: true,
  synth: :piano,
  drums: { bd: :bd_tek, cyms: :drum_cymbal_closed },
  sleep: 1,
  shutup_drums: false,
  shutup_synths: false,
  shutup_bleeps: false,
  drums_amp: 0, bleeps_amp: 0, synths_amp: 0,
  silence: false)

  notes = list.dup
  swapped = false
  r = notes.length - 2
  iterations = 0

  use_synth synth
  if play_list
    notes.each do |n|
      3.times do
        midi n, sustain: 0.1
        sleep 0.125
      end
      # play n, amp: silence ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.2
      sleep 4
    end
  end

  while true
    swaps = 0
    iterations += 1

    in_thread do
      sample drums[:bd], amp: if silence
                                0
                              elsif shutup_drums
                                0
                              else
                                amp + 0.5 + drums_amp < 0 ? 0 : amp + 0.5 + drums_amp
                              end
    end

    in_thread do
      iterations.times do |i|
        sample drums[:cyms],
               amp: if silence
                      0
                    elsif shutup_drums
                      0
                    else
                      amp + (i.to_f / 2.0) + drums_amp < 0 ? 0 : amp + (i.to_f / 2.0) + drums_amp
                    end, rate: 2
        sleep (2.0 / iterations).round(2)
      end
    end

    for i in 0..r
      play notes[i], amp: if silence
                          0
                        elsif shutup_synths
                          0
                        else
                          amp + synths_amp < 0 ? 0 : amp + synths_amp
                        end, release: 0.1
      sleep sleep
      next unless notes[i] > notes[i + 1]

      notes[i], notes[i + 1] = notes[i + 1], notes[i]
      swapped ||= true

      sample :glitch_bass_g,
             amp: if silence
                    0
                  elsif shutup_bleeps
                    0
                  else
                    amp + 0.5 + bleeps_amp < 0 ? 0 : amp + 0.5 + bleeps_amp
                  end
      sleep sleep

      play notes[i], amp: if silence
                          0
                        elsif shutup_synths
                          0
                        else
                          amp + synths_amp < 0 ? 0 : amp + synths_amp
                        end
      sleep sleep
      swaps += 1
    end
    swapped ? swapped = false : break
  end

  sorted.call(notes, 'Bubble Sort') unless silence
end
