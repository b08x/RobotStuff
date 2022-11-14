#!/usr/bin/env ruby

# This script does the following:
# * if clipping is detected, files is normalized using tp-norm


require 'fileutils'
require 'open3'
require 'pathname'
require 'tty-command'
require 'tty-prompt'
require_relative 'soxstuff.rb'

def cmd
  cmd = TTY::Command.new
  return cmd
end

def add_suffix(file,suffix,extension)
  return file.sub(extension,"_#{suffix}#{extension}").to_s.shellescape
end

def prompt
  prompt = TTY::Prompt.new(interrupt: :exit)
  return prompt
end

files = ARGV

files.each do |f|
  file = Pathname.new(f)
  info = SoxStuff.info(file.to_s.shellescape)

  next unless info[:volume_adjustment].to_f == 1.000

  parentFolder = file.dirname
  basename = file.basename
  extension = file.extname
  tmpfile = File.join("/tmp", basename.sub(extension, ".wav")).shellescape

  normalized = File.join("/tmp/tp-norm", file.sub(extension,"-tp-norm.wav").basename.to_s.shellescape)

  puts "#{normalized}"

  begin
    SoxStuff.samplerate(file,tmpfile)

    `tp-norm -t -3 #{tmpfile}`

    `play #{file} && sleep 1 && play #{normalized}`

    s = prompt.yes?("are you satisfied?")
    if s == true
      o = prompt.yes?("overwrite with new file?")
      if o == true
        `sox #{normalized} #{file.to_s.shellescape}`
        `rm -rf /tmp/tp-norm`
        `rm -rf #{tmpfile}`
      else
        puts "well too bad...it's this or nothing."
      end
    else
      puts "nevermind"
    end
    #
    # `sox #{tmpfile} #{file.to_s.shellescape}`
  rescue StandardError => e
    puts "#{e.message}"
    `rm -rf #{tmpfile}`
  end

end

puts "finished"
