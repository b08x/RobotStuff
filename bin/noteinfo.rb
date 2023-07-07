#!/usr/bin/env ruby

require 'childprocess'
require 'clipboard'
require 'coltrane'
require 'highline/import'
require 'pastel'
require 'shellwords'
require 'tty-box'
require 'tty-cursor'
require 'tty-prompt'
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
  pastel = Pastel.new

  active_color = Pastel.new.green.on_red.detach

  input = pastel.yellow("Provide") + " midi notes " + pastel.magenta("to convert: ")

  notes = prompt.ask(input, color: :bright_green, convert: :array, active_color: :bright_yellow) do |q|
    q.modify :up
    q.convert -> (input) { input.split(/ \s*/) }
  end

  info = []
  to_clipboard = []

  notes.each do |note|

    if NOTE_NAMES.include?(note)
      octave = prompt.ask("Note: '#{note}' Octave: ", convert: :int)
      frequency = Monk.note_to_hz(note+octave.to_s)
      midi_note = Monk.note_to_midi(note+octave.to_s)
      symbolic_note = note+octave.to_s
    else
      midi_note = note.to_i
      symbolic_note =Monk.midi_to_note(note.to_i).downcase
      frequency = Monk.note_to_hz(note.to_i)
    end

    info << box_info(midi_note,symbolic_note,frequency)
    to_clipboard << symbolic_note
  #
  end

  box1 = TTY::Box.frame(
    # top: 10,
    # left: 20,
    width: (TTY::Screen.width),
    height: (TTY::Screen.height / 1.25).round,
    border: :ascii,
    align: :left,
    padding: 3,
    title: {
      top_left: " information "
    },
    style: {
      fg: :bright_yellow,
      bg: :black,
      border: {
        fg: :bright_yellow,
        bg: :black
      }
    }
  ) do
      "#{info.join("\n")}"

  end

  puts TTY::Cursor.clear_screen

  print box1

  Clipboard.copy(to_clipboard.map {|x| x.gsub(/\#/,'s').to_sym})

  #(0..2).each { |x| print "\n"}
  # system("notify-send 'midi note #{midi_note} #{symbolic_note}'")
  continue = prompt.keypress('Depress any key for action ...', timeout: 60)

  continue = "True" if continue

  unless continue
    puts "bad bye"
    #puts TTY::Cursor.clear_screen
    exit
  end
end
