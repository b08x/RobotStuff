# SELECTION SORT
def selection_sort(list: DEFAULT_LIST_SELECT_INSERT,
  amp: 1,
  play_list: true,
  sleep: 0.125,
  shutup_drums: false, shutup_synths: false, silence: false,
  drums: { bd: :bd_tek, cyms: :drum_cymbal_closed, sn: :drum_snare_soft },
  synths: { main: :sine, opt: :tb303 },
  sorted: DEFAULT_SORTED,
  drums_amp: 0, synths_amp: 0)

  notes = list.dup
  r = notes.length - 1
  swaps = 0

  use_synth synths[:main]
  if play_list
    notes.each do |n|
      play n, amp: if silence
                     0
                   else
                     amp + synths_amp < 0 ? 0 : amp + synths_amp
                   end, release: 0.3
      sleep sleep * 2
    end
  end

  for i in 0..r
    min = notes[i]
    min_idx = i

    sample drums[:bd], amp: if silence
                              0
                            elsif shutup_drums
                              0
                            else
                              amp * 2 + drums_amp < 0 ? 0 : amp * 2 + drums_amp
                            end

    use_synth synths[:main]
    sub = notes[i + 1..-1].reverse
    sub.each do |n|
      play n, amp: if silence
                     0
                   elsif shutup_synths
                     0
                   else
                     amp + synths_amp < 0 ? 0 : amp + synths_amp
                   end, release: 0.02,
              cutoff: 60, decay: 0.05
      sleep sleep
    end

    replacements = 0
    for j in (i + 1)..r
      next unless notes[j] < min

      min = notes[j]
      min_idx = j
      replacements += 1
    end

    in_thread do
      replacements.times do
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

    in_thread do
      if min_idx != i
        notes[i], notes[min_idx] = notes[min_idx], notes[i]
        swaps += 1
        use_synth synths[:opt]
        play notes[min_idx],
             amp: if silence
                    0
                  elsif shutup_synths
                    0
                  else
                    amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp
                  end, sustain: 0.1, decay: 0.2, release: 0.1, cutoff: 60
      else
        sample drums[:sn], amp: silence ? 0 : 2, rate: -1
      end
    end

    use_synth synths[:opt]
    sl = list.length * sleep > 2 ? 4 - (sub.length * sleep) : 2 - (sub.length * sleep)
    play notes[i], amp: if silence
                        0
                      elsif shutup_synths
                        0
                      else
                        amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp
                      end,
                 cutoff: 70, sustain: 0.1, decay: 0.2, release: 0.1
    sleep sl
  end

  sorted.call(notes, 'Selection Sort') unless silence
end
