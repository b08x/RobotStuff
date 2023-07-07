#!/usr/bin/env ruby

require 'tty-prompt'
require 'osc-ruby'


# in this case, take input from terminal using a slider for volume. then pass the volume variable to an OSC client


prompt = TTY::Prompt.new

vol = prompt.slider('Volume', max: 100, step: 5, default: 75)

puts "#{vol}"

# sets up a client to send OSC messages to port 4559 on the localhost
#@client = OSC::Client.new(4560)

# same as above except to a remote client
@client = OSC::Client.new(4560, "127.0.0.1")



# send an OSC message to the host using a string address
# and a value. in this case we are sending to sonic pi
# other OSC hosts have different addy requirements (e.g. sooperlooper)
def sonic_osc_send(addy, value)

  @client.send OSC::Message.new(addy, value)

end

sonic_osc_send("/volume", vol)
