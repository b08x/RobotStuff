#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-cursor'
require 'tty-prompt'

def prompt
  prompt = TTY::Prompt.new(interrupt: :exit)
  return prompt
end

# connections = `jack_lsp -p`.split("\n")
#
# outputs = []
#
#
# connections.each_slice(2) do |pair|
#   if pair[0].match?(/midi|Midi/) || pair[1].include?("input")
#     next
#   end
#   outputs << pair[0]
# end
#
# puts "#{outputs}"
#
# aliases = `jack_lsp -A`.split("\n")
# aliases.delete_if {|x| x.match?(/midi|Midi|a2j/) }
#
# aliases.each_slice(2) do |pair|
#   puts "#{pair[0]} = #{pair[1]}"
# end

ports = %w[
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

#########################################
aliases = []

# get current aliases for linuxsampler ports
current_aliases = `jack_lsp -A | grep LinuxSampler -A3`.split(/LinuxSampler/, -1)

current_aliases.each do |line|
  # formating the output of jack_lsp
  alias_array = line.gsub(/\n/,'').split(/\s/).delete_if { |x| x.empty? }

  # if there is only 1 or less objects, then there is no current alias
  next if alias_array.length <= 1

  # select the first alias
  port = alias_array.slice!(0).prepend("LinuxSampler")
  current_alias = alias_array.slice(0)

  # if there is more than one, discard the rest
  alias_array.each do |remaining|
    `jack_alias -u #{port} #{remaining}`
  end

  # ask to use current alias
  use_current = prompt.yes?("use current alias? #{port} = #{current_alias}")

  # if not, unlias if so add to alias array
  # and remove the port from the port array
  if use_current
    #ports.delete_if { |x| x == port }
    aliases << current_alias
  else
    `jack_alias -u #{port} #{current_alias}`
  end

end


#########################################

puts TTY::Cursor.clear_screen
#

selections = prompt.multi_select("select ports to assign alias", ports + aliases, per_page: 16)


selections.each do |port|

  new_alias = prompt.ask("Instrument name: ")

  aliases << new_alias

  `jack_alias #{port} #{new_alias}`

end
#
p selections
p aliases
test = Hash[ports.zip aliases]

p test
#`jmeters -t vu -c 2 #{aliases.join(" ")}`


##################

label = prompt.ask("Instrument name: ")
