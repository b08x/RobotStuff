#!/usr/bin/env ruby

require 'shellwords'
require 'childprocess'
require 'coltrane'
require 'highline/import'
require 'pastel'
require 'tty-prompt'
require 'tty-box'
require 'tty-cursor'
require 'tty-screen'

args = ARGV[0]

def forkoff(command)
  fork do
    exec(command.to_s)
  end
end

# MIDI note names. NOTE_NAMES[0] is 'C', NOTE_NAMES[1] is 'C#', etc.
NOTE_NAMES = [
  'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'
]

module Monk
  module_function

  include Coltrane::Theory

  # Given a MIDI note number, return the name and octave as a string.
  def midi_to_note(num)
    Pitch.new(num).name
  end

  def note_to_midi(note)
    Pitch.new(note).midi
  end

  def note_to_hz(note)
    Pitch.new(note).frequency.frequency
  end

  # https://github.com/sonic-pi-net/sonic-pi/blob/main/app/server/ruby/lib/sonicpi/lang/western_theory.rb
  def hz_to_midi(freq)
    (12 * (Math.log(freq * 0.0022727272727) / Math.log(2))) + 69
  end

  def midi_to_hz(midi_note)
    440.0 * (2**((midi_note - 69) / 12.0))
  end

end

def box_info(midi_note,symbolic_note,frequency)
  return "midi note:     #{midi_note} \nsymbolic note: #{symbolic_note}\nfrequency:     #{frequency.round(2)}\n"
end

continue = "True"

while continue == "True"
  puts TTY::Cursor.clear_screen
  prompt = TTY::Prompt.new(enable_color: true)
  notice = Pastel.new.green.on_red.detach

  notes = prompt.ask('What note(s) do you want to convert, sweatie?', color: notice, convert: :array, active_color: notice) do |q|
    q.modify :up
    q.convert -> (input) { input.split(/ \s*/) }
  end

  info = []

  notes.each do |note|

    info << Monk.midi_to_note(note.to_i).downcase

    # if NOTE_NAMES.include?(note)
    #   info[:octave] = prompt.ask("Note: '#{note}' Octave: ", convert: :int)
    #   info[:frequency] = Monk.note_to_hz(note+octave.to_s)
    #   info[:midi_note] = Monk.note_to_midi(note+octave.to_s)
    #   info[:symbolic_note] = note+octave.to_s
    # else
    #   info[:midi_note] = note
    #
    #   info[:frequency] = Monk.note_to_hz(note.to_i)
    # end

    #info << box_info(midi_note,symbolic_note,frequency)

  end

  p info.map {|x| x.gsub(/\#/,'s').to_sym }

  # box1 = TTY::Box.frame(
  #   # top: 10,
  #   # left: 50,
  #   width: (TTY::Screen.width / 2),
  #   height: (TTY::Screen.width / 2),
  #   border: :thick,
  #   align: :left,
  #   padding: 3,
  #   title: {
  #     top_left: " file1 "
  #   },
  #   style: {
  #     fg: :bright_yellow,
  #     bg: :black,
  #     border: {
  #       fg: :bright_yellow,
  #       bg: :blue
  #     }
  #   }
  # ) do
  #     "#{info.join("\n")}"
  # end
  #
  # print box1

  # system("notify-send 'midi note #{midi_note} #{symbolic_note}'")

  continue = prompt.keypress('Press any key to continue, will exit in 5 seconds ...', timeout: 5)

  continue = "True" if continue

  unless continue
    puts "bad bye"
    #puts TTY::Cursor.clear_screen
    exit
  end
end
