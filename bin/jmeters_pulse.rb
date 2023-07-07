#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-cursor'
require 'tty-prompt'
require 'yaml'

def forkoff(command)
  fork do
    exec(command.to_s)
  end
end


meterAliases = File.join(ENV['HOME'], "Studio", "projects", "meters.yml")

monitor_ports = YAML.load_file(meterAliases).map { |ports| ports.map { |port| "'#{port}'"} }


forkoff("jmeters -t vu -c 4 #{monitor_ports.flatten.join(' ')}")
