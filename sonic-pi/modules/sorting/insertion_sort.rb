# INSERTION SORT
def insertion_sort(list: DEFAULT_LIST_SELECT_INSERT, sorted: DEFAULT_SORTED, amp: 1, play_list: true,
                   drums: { bd: :bd_tek, cyms: :drum_cymbal_closed, sn: :drum_splash_soft }, sleep: 0.125,
                   synths: { main: :piano, opt1: :tri, opt2: :pluck }, shutup_drums: false,
                   shutup_synths: false, silence: false, drums_amp: 0, synths_amp: 0)

  arr = list.dup
  r = arr.length - 1
  swaps = 0

  use_synth synths[:main]
  if play_list
    arr.each do |n|
      play n, amp: if silence
                     0
                   else
                     amp + synths_amp < 0 ? 0 : amp + synths_amp
                   end, release: 0.3
      sleep sleep * 2
    end
  end

  for i in 1..r
    sample drums[:bd], amp: if silence
                              0
                            elsif shutup_drums
                              0
                            else
                              amp * 2 + drums_amp < 0 ? 0 : amp * 2 + drums_amp
                            end
    key = arr[i]
    j = i - 1

    overwrites = 0
    while j >= 0 and arr[j] > key
      arr[j + 1] = arr[j]
      j -= 1
      overwrites += 1
    end

    note_swapped = false
    if arr[j + 1] != key
      note_swapped = arr[j + 1]
      arr[j + 1] = key
      swaps += 1
    else
      sample drums[:sn], amp: if silence
                                0
                              elsif shutup_drums
                                0
                              else
                                amp + 0.5 + drums_amp < 0 ? 0 : amp + 0.5 + drums_amp
                              end,
                         rate: -1
    end

    in_thread do
      sleep 1
      overwrites.times do
        sample drums[:cyms], rate: 2,
                             amp: if silence
                                    0
                                  elsif shutup_drums
                                    0
                                  else
                                    amp + 0.3 + drums_amp < 0 ? 0 : amp + 0.3 + drums_amp
                                  end
        sleep sleep
      end
    end

    sub = arr[0..i]
    sl = sub.length * sleep > 2 ? 4.0 - (sub.length * sleep) : 2.0 - (sub.length * sleep)

    sub.each do |n|
      if n === key
        (inserted = true
         use_synth synths[:opt1])
      else
        (inserted = false
         use_synth synths[:opt2])
      end

      if inserted
        play n, amp: if silence
                       0
                     elsif shutup_synths
                       0
                     else
                       amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp
                     end,
                cutoff: 70, release: 0.3

        if note_swapped
          play note_swapped, cutoff: 60, release: 0.3,
                             amp: if silence
                                    0
                                  elsif shutup_synths
                                    0
                                  else
                                    amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp
                                  end
        end

      else
        play n, release: 0.3,
                amp: if silence
                       0
                     elsif shutup_synths
                       0
                     else
                       amp + (amp / 2.0) + synths_amp < 0 ? 0 : amp + (amp / 2.0) + synths_amp
                     end
      end

      sleep sleep
    end
    sleep sl
  end

  sorted.call(arr, 'Insertion Sort') unless silence
end
