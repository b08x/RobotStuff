#!/usr/bin/env ruby

require 'pathname'
require 'tty-command'
require 'tty-prompt'

def prompt
  prompt = TTY::Prompt.new(interrupt: :exit)
  return prompt
end

def run(*args)
  cmd = TTY::Command.new(printer: :pretty)
  result = cmd.run(args.join(' '), only_output_on_error: false)
  return result
end

@keep = prompt.yes?("Keep original?")

files = ARGV.map { |f| Pathname.new(f)  }

files.each do |f|

    file = f.to_s.shellescape

    extension = f.extname

    new_file = f.sub(extension,".wav").to_s.shellescape

  begin
    if run("ffmpeg -i #{file} #{new_file}").success?
      run("rm -rf #{file}") unless @keep
    end
    sleep 0.25
  rescue StandardError => e
    puts "#{e.message}"
    run("rm -rf '#{new_file}'")
  end

end

if prompt.yes?("as expected?")
  puts "good"
end
