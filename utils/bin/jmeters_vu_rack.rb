#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-cursor'
require 'tty-prompt'

def forkoff(command)
  fork do
    exec(command.to_s)
  end
end

def prompt
  prompt = TTY::Prompt.new(interrupt: :exit)
  return prompt
end

outputs = %w[
  LinuxSampler:0
  LinuxSampler:1
  LinuxSampler:2
  LinuxSampler:3
  LinuxSampler:4
  LinuxSampler:5
  LinuxSampler:6
  LinuxSampler:7
  LinuxSampler:8
  LinuxSampler:9
  LinuxSampler:10
  LinuxSampler:11
  LinuxSampler:12
  LinuxSampler:13
  LinuxSampler:14
  LinuxSampler:15
]

aliases = []

monitor_ports = {}

# get current aliases for linuxsampler outputs
current_aliases = `jack_lsp -A | grep LinuxSampler -A3`.split(/LinuxSampler/, -1)

# remove midi ports and empty indexes
current_aliases.delete_if {|x| x.include?("midi") || x.empty? }

current_aliases.each do |line|

  # format the output of jack_lsp
  # each port that has an alias is followed by an indented line
  # this is what is returned
  # [
  #     [ 0] ":0\n   ngrand\n",
  #     [ 1] ":1\n   ngrand\n",
  #     [ 2] ":2\n   contrabass\n",
  #     [ 3] ":3\n   contrabass\n",
  #     [ 4] ":4\n",
  #     [ 5] ":5\n",
  #     [ 6] ":6\n",
  #     [ 7] ":7\n",
  #     [ 8] ":8\n",
  #     [ 9] ":9\n",
  #     [10] ":10\n",
  #     [11] ":11\n",
  #     [12] ":12\n",
  #     [13] ":13\n",
  #     [14] ":14\n",
  #     [15] ":15\n"
  # ]
  #
  # result for each item
  # [
  #     [0] ":0",
  #     [1] "ngrand"
  # ]
  alias_array = line.gsub(/\n/,'').split(/\s/).delete_if { |x| x.empty? }

  # if the length of the array is less than or equal to 1,
  # then there is no alias
  next if alias_array.length <= 1

  # select the first alias assigned
  port = alias_array.slice!(0).prepend("LinuxSampler")
  current_alias = alias_array.slice!(0)

  # if there is more than one, unalias the remaining
  unless alias_array.empty? || alias_array.nil?
    alias_array.each do |remaining|
      `jack_alias -u #{port} #{remaining}`
    end
  end

  # ask to use current alias
  use_current = prompt.yes?("use current alias? #{port} = #{current_alias}")

  # if not, unlias
  # if so add to monitor_ports hash
  # and remove the port from the outputs array
  if use_current
    monitor_ports[port] = current_alias
    outputs.delete_if { |x| x == port }
  else
    `jack_alias -u #{port} #{current_alias}`
  end

end

#########################################

puts TTY::Cursor.clear_screen

# select outputs that currently are not assigned an alias
choices = prompt.multi_select("select outputs to assign alias", outputs, per_page: 16)

choices.each do |port|
  # prompt input for new alias
  new_alias = prompt.ask("Instrument name for port #{port}:  ")

  # assign the alias
  `jack_alias #{port} #{new_alias}`

  # add to monitor_ports hash
  monitor_ports[port] = new_alias

end

#
# "LinuxSampler:0 ngrand LinuxSampler:1 ngrand LinuxSampler:2 contrabass LinuxSampler:3 contrabass LinuxSampler:4 jazzbass"

forkoff("jmeters -t vu -c 3 #{monitor_ports.flatten.join(' ')}")


##################

#label = prompt.ask("Instrument name: ")
