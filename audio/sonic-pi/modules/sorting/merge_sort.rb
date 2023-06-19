# MERGE SORT FUNCTIONS
def play_list(list:, amp:, sleep:, percs:, percs_amp:, synths_amp:, shutup_synths:, shutup_percs:, silence:, pan: 0)
  if list.length < 1
    sample percs[:opt3][0], pan: pan,
                            amp: if silence
                                   0
                                 elsif shutup_percs
                                   0
                                 else
                                   amp + (amp / 2.0) + percs_amp < 0 ? 0 : amp + (amp / 2.0) + percs_amp
                                 end, rate: [1, 2, -1].choose
  else
    list.each do |n|
      play n, pan: pan, amp: if silence
                               0
                             elsif shutup_synths
                               0
                             else
                               amp + synths_amp < 0 ? 0 : amp + synths_amp
                             end,
              release: 0.05, sustain: 0.1, decay: 0.05
      sleep sleep
    end
  end
end

def merge(left:, right:, run_sorted:, sorted:, amp:, sleep:, synths:, percs:,
          percs_amp:, synths_amp:, shutup_synths:, shutup_percs:, silence:)

  sample percs[:opt3][0], amp: if silence
                                 0
                               elsif shutup_percs
                                 0
                               else
                                 1 + percs_amp < 0 ? 0 : 1 + percs_amp
                               end

  use_synth synths[:opt]

  in_thread do
    play_list(list: left, amp: (amp / 2.0) + (amp / 4.0), pan: -1, sleep: sleep,
              percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
              shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)
  end

  play_list(list: right, amp: (amp / 2.0) + (amp / 4.0), pan: 1, sleep: sleep,
            percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
            shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  sorted_list = []
  while !left.empty? && !right.empty?
    if left.first < right.first
      sorted_list.push(left.shift)
    else
      sorted_list.push(right.shift)
    end

    in_thread do
      play_list(list: left, amp: amp / 2.0, pan: -1, sleep: sleep, percs: percs, shutup_synths: shutup_synths,
                shutup_percs: shutup_percs, percs_amp: percs_amp, synths_amp: synths_amp,
                silence: silence)
    end

    play_list(list: right, amp: amp / 2.0, pan: 1, sleep: sleep,
              percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
              shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)
  end

  play_list(list: left, amp: amp, pan: -1, sleep: sleep, percs: percs, percs_amp: percs_amp,
            synths_amp: synths_amp, shutup_synths: shutup_synths, shutup_percs: shutup_percs,
            silence: silence)

  play_list(list: right, amp: amp, pan: 1, sleep: sleep, percs: percs, percs_amp: percs_amp,
            synths_amp: synths_amp, shutup_synths: shutup_synths, shutup_percs: shutup_percs,
            silence: silence)

  play_list(list: sorted_list.concat(right).concat(left), amp: amp, sleep: sleep, percs: percs,
            percs_amp: percs_amp, synths_amp: synths_amp, shutup_synths: shutup_synths,
            shutup_percs: shutup_percs, silence: silence)

  sorted.call(sorted_list, 'Merge') if run_sorted and sorted_list.length > 3

  sorted_list
end

def merge_sort(list: DEFAULT_LIST_MERGE, side: nil, sorted: DEFAULT_SORTED, run_sorted: true, amp: 1, sleep: 0.25,
               synths: { main: :square, opt: :beep }, shutup_synths: false, shutup_percs: false, silence: false,
               percs: { opt1: :elec_flip, opt2: :elec_plip,
                        opt3: "DRUMKITS, '41_dropbass'" }, percs_amp: 0, synths_amp: 0)

  sample percs[:opt1], amp: if silence
                              0
                            elsif shutup_percs
                              0
                            else
                              amp + 0.5 + percs_amp < 0 ? 0 : amp + 0.5 + percs_amp
                            end

  use_synth synths[:main]

  p = if side == 'left'
        -1
      else
        side == 'right' ? 1 : 0
      end
  play_list(list: list, amp: amp, pan: p, sleep: sleep, percs: percs, shutup_synths: shutup_synths,
            shutup_percs: shutup_percs, percs_amp: percs_amp, synths_amp: synths_amp, silence: silence)

  if list.length <= 1
    sample percs[:opt2],
           amp: if silence
                  0
                elsif shutup_percs
                  0
                else
                  amp + (amp / 2.0) + percs_amp < 0 ? 0 : amp + (amp / 2.0) + percs_amp
                end
    sleep sleep * 2
    return list
  end

  mid = list.length / 2
  left = merge_sort(list: list.slice(0...mid), side: 'left', sorted: sorted, run_sorted: run_sorted,
                    amp: amp, sleep: sleep, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
                    shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  right = merge_sort(list: list.slice(mid..list.length), side: 'right', sorted: sorted, run_sorted: run_sorted,
                     sleep: sleep, amp: amp, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
                     shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  merge(left: left, right: right, sorted: sorted, run_sorted: run_sorted, amp: amp,
        sleep: sleep, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
        shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)
end
