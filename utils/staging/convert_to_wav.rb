#!/usr/bin/env ruby

# This script does the following:
# * removes dcoffset is there is one

require 'fileutils'
require 'open3'
require 'pathname'
require 'tty-prompt'
require_relative 'soxstuff.rb'

def prompt
  prompt = TTY::Prompt.new(interrupt: :exit)
  return prompt
end

files = ARGV

files.each do |f|

  file = Pathname.new(f)

  extension = file.extname

  new_file = file.sub(extension,".wav").to_s.shellescape

  begin
    info = SoxStuff.info(file.to_s.shellescape)

    `sox #{file} #{new_file}`

    dcoffset = info[:dc_offset].split[0].to_f.round(4)

    if dcoffset > 0.0 || dcoffset < 0.0
      `ecafixdc #{new_file}` if  > 0.0
    end

    sleep 0.25

  rescue StandardError => e
    puts "#{e.message}"
    `rm -rf #{new_file}`
  end

end

puts "finished"
