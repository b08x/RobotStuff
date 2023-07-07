#!/usr/bin/env ruby
# send osc messages to sonic-pi for every line printed when running a playbook
# https://stackoverflow.com/a/43208709/10073106

require 'open3'


Dir.chdir(File.join(ENV["HOME"], "Workspace", "soundbot", "ansible")) do
  Open3.popen3 "ansible-playbook -C -i hosts soundbot.yml --limit thinkbot" do |stdin, stdout, stderr, thread|
    while line = stdout.gets
      puts line
      `oscsend localhost 4560 /test/thing f 1.0`
    end
  end
end
