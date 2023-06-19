# https://github.com/samaaron/sonic-pi/issues/1691
# https://in-thread.sonic-pi.net/t/midi-chords-creation-from-an-external-synth/355/2?u=b08x
# Use: midi_chord chord(:c4,:major), sustain:0.2

def midi_chord(notes, *args)
  notes.each do |note|
    print midi_to_hz(note)
    midi note, *args
  end
end
