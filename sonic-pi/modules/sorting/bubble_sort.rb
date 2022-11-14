# BUBBLE SORT
def bubble_sort(list: DEFAULT_LIST_BUBBLE, sorted: DEFAULT_SORTED, amp: 1, play_list: true, synth: :piano, drums: { bd: :bd_tek, cyms: :drum_cymbal_closed },
sleep: 1, shutup_drums: false, drums_amp: 0, bleeps_amp: 0, synths_amp: 0, shutup_synths: false,
                shutup_bleeps: false, silence: false)

  arr = list.dup
  swapped = false
  r = arr.length - 2
  num_iters = 0

  use_synth synth
  if play_list
    arr.each do |n|
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
    num_iters += 1

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
      num_iters.times do |i|
        sample drums[:cyms],
               amp: if silence
                      0
                    elsif shutup_drums
                      0
                    else
                      amp + (i.to_f / 2.0) + drums_amp < 0 ? 0 : amp + (i.to_f / 2.0) + drums_amp
                    end, rate: 2
        sleep (2.0 / num_iters).round(2)
      end
    end

    for i in 0..r
      play arr[i], amp: if silence
                          0
                        elsif shutup_synths
                          0
                        else
                          amp + synths_amp < 0 ? 0 : amp + synths_amp
                        end, release: 0.1
      sleep sleep
      next unless arr[i] > arr[i + 1]

      arr[i], arr[i + 1] = arr[i + 1], arr[i]
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
      play arr[i], amp: if silence
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

  sorted.call(arr, 'Bubble Sort') unless silence
end
