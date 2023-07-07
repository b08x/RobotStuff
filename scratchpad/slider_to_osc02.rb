#!/usr/bin/env ruby

require 'tty-reader'
require 'tty-prompt'
require 'osc-ruby'


# in this case, take input from terminal using a slider for volume. then pass the volume variable to an OSC client
prompt = TTY::Prompt.new

vol = prompt.slider('Volume', max: 100, step: 5, default: 75)

puts "#{vol}"

# setup a listener to exit when either ctrl+x or esc is pressed

reader = TTY::Reader.new

reader.on(:keyctrl_x, :keyescape) do
  puts "Exiting..."
  exit
end

# when running the code below, event machine
# will keep the connection open...

include OSC

def sonicosc(value)
#TODO: gracefully close connection
  OSC.run do
    client = Client.new(4560)
    client.send Message.new('/volume', value)
  end


end

sonicosc(vol)
