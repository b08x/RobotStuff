#!/usr/bin/env ruby

require 'tty-command'
require_relative 'soxstuff.rb'

# ecadcfix only takes files in wav format
# create a copy of the file in wav format
# then run ecadcfix on the file

def run(*args)
  cmd = TTY::Command.new(printer: :pretty)
  result = cmd.run(args.join(' '), only_output_on_error: false)
  return result
end

files = ARGV

files.each do |file|

  info = SoxStuff.info(file.shellescape)

  dcoffset = info[:dc_offset].split[0].to_f.round(4)

  next if dcoffset.zero?

  puts "------------------------\n"
  puts "#{file}: #{dcoffset}"

  folder = File.dirname(file)
  basename = File.basename(file)
  extension = File.extname(basename)

  tmpfolder = File.join("/tmp", "dcfix")
  tmpfile = File.join(tmpfolder, basename.sub(extension, ".wav"))

  dcremoved = File.join(tmpfolder, basename.sub(extension,"-dcremoved.wav"))

  begin

    `rm -rf #{tmpfolder} && mkdir -pv #{tmpfolder}`

    if run("ffmpeg -i '#{file}' '#{tmpfile}'").success?

      if run("lv2file -i '#{tmpfile}' 'http://plugin.org.uk/swh-plugins/dcRemove' -o '#{dcremoved}'").success?

        run("ffmpeg -y -i '#{dcremoved}' '#{file}'")

      end
    end

  rescue StandardError => e
    puts "#{e.message}"
  ensure
    `rm -rf "#{tmpfile}"`
  end

  puts "next"
  puts "----------------\n"

end

puts "finished"
