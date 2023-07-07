#!/usr/bin/env ruby

require 'coltrane'
require 'highline/import'
require 'pastel'
require 'tty-prompt'
require 'tty-box'
require 'tty-cursor'
require 'tty-screen'

module Soundbot
  module_function
  include Coltrane::Theory

  def midi_to_note(num)
    Note.new(num).name
  end

  def midi_to_pitch(num)
    Pitch.new(num).name
  end

  def note_names(chord)
    Chord.new(name: chord).notes.names
  end

  def scale_names(chord)
    scales = {}
    Chord.new(name: chord).scales.strict_scales.each do |scale|
      scales[scale.name.to_sym] = scale.notes.names
    end
    return scales
  end

  def scales_having_notes(notes)
    scales = {}
    Scale.having_notes(NoteSet.new(notes)).strict_scales.each do |scale|
      pp scale
      scales[scale.name] = scale.notes.pretty_names
    end
    return scales
  end

  def scales_having_chords(chords)
    Scale.having_chords()
  end

  def chord_notes(root,chord)
    Chord.new(root_note: Note[root], quality: ChordQuality.new(name: chord)).notes.names
  end


#Coltrane::Theory::Scale.new(notes: %w[C D G], tone: 'D').all_chords.each {|x| p x.name}

end

# p Soundbot.note_names('A7')
# Soundbot.scale_names('A7').each do |s|
#   puts "#{s}\n"
# end
prompt = TTY::Prompt.new(enable_color: true)
notice = Pastel.new.green.on_red.detach
notes = prompt.ask('Enter notes to find a scale?\n', color: notice, convert: :array, active_color: notice) do |q|
  q.modify :up
  q.convert -> (input) { input.split(/ \s*/) }
  # q.in('A-G')
end
p notes
#notes = notes.map {|midi| Soundbot.midi_to_note(midi.to_i)}
Soundbot.scales_having_notes(notes).each do |k,v|
  puts "#{k}: #{v.join(",")}"
end
