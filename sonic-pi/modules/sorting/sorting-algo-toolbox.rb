# BUBBLE SORT
def bubble_sort(list: DEFAULT_LIST_BUBBLE, sorted: DEFAULT_SORTED, amp: 1, play_list: true, synth: :beep,
                drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed}, sleep: 0.25, shutup_drums: false,
                drums_amp: 0, bleeps_amp: 0, synths_amp: 0, shutup_synths: false,
                shutup_bleeps: false, silence: false)

  notes = list.dup
  swapped = false
  repeats = notes.length - 2
  iterations = 0

  use_synth synth
  if play_list
    3.times do
      notes.each { |n|
        play n, amp: silence ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.2
        sleep sleep
      }
      # in_thread do
      #   sample drums[:bd], amp: silence ? 0 : shutup_drums ? 0 : amp + 0.5 + drums_amp < 0 ? 0 : amp + 0.5 + drums_amp
      # end
    end
  end

  print "hey-------------------------------"

  while true
    swaps = 0
    iterations += 1

    # in_thread do
    #   sample drums[:bd], amp: silence ? 0 : shutup_drums ? 0 : amp + 0.5 + drums_amp < 0 ? 0 : amp + 0.5 + drums_amp
    # end

    # unless shutup_drums
    #   in_thread do
    #     iterations.times do |i|
    #         sample drums[:cyms], amp: silence ? 0 : 1, rate: 2
    #         sleep (2.0 / iterations).round(2)
    #       end
    #   end
    # end

    for i in 0..repeats
      print "1st----#{notes[i]}----"

      play notes[i], amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.1
      sleep sleep
      print "what----#{notes[i]}----#{notes[i+1]}"
      # if notes[i+1] is the next note in the index, not notenumber plus one.
      if notes[i] > notes[i+1]
        # notes[i] becomes the next note in the array
        # for example: 45, 52 = 52, 45
        notes[i], notes[i+1] = notes[i+1], notes[i]

        swapped = true if !swapped

        # sample :elec_blip2, amp: silence ? 0 : shutup_bleeps ? 0 : amp + 0.5 + bleeps_amp < 0 ? 0 : amp + 0.5 + bleeps_amp

        print "2nd----#{(notes[i] + 12)}----"
        play notes[i] + 12, amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.1
        sleep sleep

        print "3rd----#{notes[i]}----"
        play notes[i], amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.1
        sleep sleep

        swaps += 1
        print "Swaps----#{swaps}----"
      end

    end #end for loop

    swapped ? swapped = false : break

  end #end while loop

  if not silence
    sorted.call(notes, "Bubble Sort")
  end
end

# SELECTION SORT
def selection_sort(list: DEFAULT_LIST_SELECT_INSERT, amp: 1, play_list: true, sleep: 0.125, shutup_drums: false, shutup_synths: false, silence: false,
                   drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed, :sn => :drum_snare_soft},
                   synths: {:main => :sine, :opt => :beep}, sorted: DEFAULT_SORTED,
                   drums_amp: 0, synths_amp: 0)

  notes = list.dup
  repeats = notes.length - 1
  swaps = 0

  use_synth synths[:main]
  if play_list
    print "notes #{notes}"
    notes.each { |n|
      play n, amp: silence ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.3
      sleep sleep * 2
    }
  end

  for i in 0..repeats
    min = notes[i]
    min_idx = i

    # sample drums[:bd], amp: silence ? 0 : shutup_drums ? 0 : amp * 2 + drums_amp < 0 ? 0 : amp * 2 + drums_amp

    use_synth synths[:main]
    sub = notes[i+1..-1].reverse
    print "sub - #{sub}"
    sub.each { |n|
      play n, amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.2, cutoff: 60, decay: 0.05
      wait [0.25,0.50].choose
    }

    replacements = 0
    for j in (i + 1)..repeats
      if notes[j] < min
        min = notes[j]
        min_idx = j
        replacements += 1
      end
    end

    # in_thread do
    #   replacements.times do
    #     sample drums[:cyms], rate: 2, amp: silence ? 0 : shutup_drums ? 0 : amp + 0.3 + drums_amp < 0 ? 0 : amp + 0.3 + drums_amp
    #     sleep sleep
    #   end
    # end

    in_thread do
      if min_idx != i
        notes[i], notes[min_idx] = notes[min_idx], notes[i]
        swaps += 1
        use_synth synths[:opt]
        print "notes[min_idx]-- #{notes[min_idx]}"
        play notes[min_idx] + 12, amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp, sustain: 0.1, decay: 0.2, release: 0.1, cutoff: 60
      else
        #sample drums[:sn], amp: silence ? 0 : 2, rate: -1
        print "silence"
      end
    end

    use_synth synths[:opt]
    sl = list.length * sleep > 2 ? 4 - (sub.length * sleep) : 2 - (sub.length * sleep)
    print "sl---#{notes[i]} #{sl}"
    play notes[i], amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp, cutoff: 70, sustain: 0.1, decay: 0.2, release: 0.1
    sleep sl
  end

  if not silence
    sorted.call(notes, "Selection Sort")
  end
end

# INSERTION SORT
def insertion_sort(list: DEFAULT_LIST_SELECT_INSERT, sorted: DEFAULT_SORTED, amp: 1, play_list: true,
                   drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed, :sn => :drum_splash_soft}, sleep: 0.125,
                   synths: {:main => :sine, :opt1 => :tri, :opt2 => :square}, shutup_drums: false,
                   shutup_synths: false, silence: false, drums_amp: 0, synths_amp: 0)

  notes = list.dup
  repeats = notes.length - 1
  swaps = 0

  use_synth synths[:main]
  if play_list
    3.times do
      notes.each {|n|
        play n, amp: silence ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.3
        sleep sleep * 2
      }
    end
  end

  for i in 1..repeats
    sample drums[:bd], amp: silence ? 0 : shutup_drums ? 0 : amp * 2 + drums_amp < 0 ? 0 : amp * 2 + drums_amp
    key = notes[i]
    j = i - 1

    overwrites = 0
    while j >= 0 and notes[j] > key
      notes[j + 1] = notes[j]
      j -= 1
      overwrites += 1
    end

    note_swapped = false
    if notes[j+1] != key
      note_swapped = notes[j+1]
      notes[j+1] = key
      swaps += 1
    else
      sample drums[:sn], amp: silence ? 0 : shutup_drums ? 0 : amp + 0.5 + drums_amp < 0 ? 0 : amp + 0.5 + drums_amp, rate: -1
    end

    # in_thread do
    #   sleep 1
    #   overwrites.times do
    #     sample drums[:cyms], rate: 2, amp: silence ? 0 : shutup_drums ? 0 : amp + 0.3 + drums_amp < 0 ? 0 : amp + 0.3 + drums_amp
    #     sleep sleep
    #   end
    # end

    sub = notes[0..i]
    sl = sub.length * sleep > 2 ? 4.0 - (sub.length * sleep) : 2.0 - (sub.length * sleep)

    sub.each { |n|
      n === key ? (inserted = true; use_synth synths[:opt1]) : (inserted = false; use_synth synths[:opt2])

      if inserted
        play n, amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp, cutoff: 70, release: 0.3
        wait [0.25,0.125].choose
        if note_swapped
          play note_swapped, cutoff: 60, release: 0.3, amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp
          wait 0.25
        end

      else
        play n, release: 0.3, amp: silence ? 0 : shutup_synths ? 0 : amp + (amp / 2.0) + synths_amp < 0 ? 0 : amp + (amp / 2.0) + synths_amp
      end

      sleep sleep
    }
    sleep sl
  end

  if not silence
    sorted.call(notes, "Insertion Sort")
  end
end


# MERGE SORT FUNCTIONS
def play_list(list:, amp:, pan: 0, sleep:, percs:, percs_amp:, synths_amp:, shutup_synths:, shutup_percs:, silence:)

  if list.length < 1
    sample percs[:opt3], pan: pan, amp: silence ? 0 : shutup_percs ? 0 : amp + (amp / 2.0) + percs_amp < 0 ? 0 : amp + (amp / 2.0) + percs_amp, rate: [1, 2, -1].choose
  else
    list.each do |n|
      play n, pan: pan, amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.1, sustain: 0.1, decay: 0.05
      sleep sleep
    end
  end
end


def merge(left:, right:, run_sorted:, sorted:, amp:, sleep:, synths:, percs:,
          percs_amp:, synths_amp:, shutup_synths:, shutup_percs:, silence:)

  sample percs[:opt3], amp: silence ? 0 : shutup_percs ? 0 : 1 + percs_amp < 0 ? 0 : 1 + percs_amp

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

  if run_sorted and sorted_list.length > 3
    sorted.call(sorted_list, "Merge")
  end

  sorted_list
end

def merge_sort(list: DEFAULT_LIST_MERGE, side: nil, sorted: DEFAULT_SORTED, run_sorted: true, amp: 1, sleep: 0.25,
               synths: {:main => :square, :opt => :sine}, shutup_synths: false, shutup_percs: true, silence: false,
               percs: {:opt1 => :elec_flip, :opt2 => :elec_plip, :opt3 => :ambi_swoosh}, percs_amp: 0, synths_amp: 0)

  sample percs[:opt1], amp: silence ? 0 : shutup_percs ? 0 : amp + 0.5 + percs_amp < 0 ? 0 : amp + 0.5 + percs_amp

  use_synth synths[:main]

  p = (side == "left") ? -1 : (side == "right") ?  1 : 0
  play_list(list: list, amp: amp, pan: p, sleep: sleep, percs: percs, shutup_synths: shutup_synths,
            shutup_percs: shutup_percs, percs_amp: percs_amp, synths_amp: synths_amp, silence: silence)

  if list.length <= 1
    sample percs[:opt2], amp: silence ? 0 : shutup_percs ? 0 : amp + (amp / 2.0) + percs_amp < 0 ? 0 : amp + (amp / 2.0) + percs_amp
    sleep sleep * 2
    return list
  end

  mid = list.length / 2
  left = merge_sort(list: list.slice(0...mid), side: "left", sorted: sorted, run_sorted: run_sorted,
                    amp: amp, sleep: sleep, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
                    shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  right = merge_sort(list: list.slice(mid..list.length), side: "right", sorted: sorted, run_sorted: run_sorted,
                     sleep: sleep, amp: amp, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
                     shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  merge(left: left, right: right, sorted: sorted, run_sorted: run_sorted, amp: amp,
        sleep: sleep, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
        shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)
end
