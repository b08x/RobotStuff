#!/usr/bin/env ruby
# frozen_string_literal: true

require 'coltrane'

# MIDI note names. NOTE_NAMES[0] is 'C', NOTE_NAMES[1] is 'C#', etc.
NOTE_NAMES = [
  'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'
]

module Monk
  module_function

  include Coltrane::Theory

  # Given a MIDI note number, return the name and octave as a string.
  def note(num)
    Pitch.new(num).name.downcase.gsub(/\#/,'s').to_sym
  end

  def note_to_midi(note)
    Pitch.new(note).midi
  end

  def note_to_hz(note)
    Pitch.new(note).frequency.frequency
  end

  def degrees(scale)

    notes = scale.notes.map {|n| midi_to_note(n)}

    degrees = 0..(notes.length - 1)

    return Hash[degrees.zip(notes)]

  end

  # return an array of chords given a progression and key
  def progression(progression, key)

    # returns chord notes object
    notes = Progression.new("#{progression}", key: key.to_s.upcase).chords.map(&:notes)

    # return the names from the object
    notes.map! {|note| note.names}

    # symbolize note names
    notes.each { |ns| ns.map! { |x| x.gsub(/\#/,'s').to_sym } }

    notes.map! { |noteset| noteset.ring }

    return notes
  end

  # def find_progression(*chords)
  #
  #   print chords.join(",")
  #
  #   x = Progression.find('F#dim', 'Am', 'Em', 'DM')
  #
  #   numerals = x.progressions.map { |p| p.roman_chords.map {|rc| rc.roman_numeral} }
  #
  #   return numerals.map { |n| n.join("-") }
  # end

end

#Monk.progressions [:I, :I, :vi, :V], :e2, :minor
#print Monk.progressions('I-I-vi-V', :e)
#print Monk.progression('IM7-IV7-vi-Vdim7', :e)
