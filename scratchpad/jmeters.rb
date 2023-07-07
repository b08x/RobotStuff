#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'tty-prompt'

def get_soundfonts_from(path)
  return Dir.glob(File.join(path, "**/*{,/*/**}.{sfz,sf2,gig}"))
end

def prompt
  prompt = TTY::Prompt.new(interrupt: :exit)
  return prompt
end

soundfont_directory = File.join(ENV['HOME'], "Library", "soundfonts")

p soundfont_directory

table = ["brass",
"collections",
"downloads",
"fx",
"keys",
"loops",
"percussion",
"strings",
"synths",
"winds"]

choice = prompt.select("Select instrument class", table, filter: true) do |menu|
  menu.enum "."
end

soundfonts = get_soundfonts_from(File.join(soundfont_directory, choice))
              .map { |file| Pathname.new(file) }

soundfont = prompt.select("Pick your soundfont. Now.", soundfonts, filter: true) do |menu|
  menu.enum "."
end

### ooorrr

load lscp, get intrsument name,
#
