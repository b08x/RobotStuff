#/bin/env ruby
# require 'osc-ruby'
# #code = 'play 50' # or whatever you want
# @client = OSC::Client.new('localhost', 9951)

#
# @client.send(OSC::Message.new("/sl/0/down", "s:record"))

# use_osc "localhost", 9951
#
# osc "/sl/-1/hit s:record"

oscsend localhost 9951 /sl/0/hit s record

[1] pry(main)> require 'osc-ruby'
=> true
[2] pry(main)> @client = OSC::Client.new('127.0.0.1', 9951)
=> #<OSC::Client:0x00000002bb8bc0 @so=#<UDPSocket:fd 13>>
[3] pry(main)> @client.send(OSC::Message.new("/sl/-1/hit", "record"))
[4] pry(main)> @client.send(OSC::Message.new("/sl/0/hit", "pause"))

---

i3-save-tree --workspace 10 > ~/workspace/seshmon/meter_tree.json

i3-msg 'workspace 10; append_layout ~/workspace/seshmon/meter_tree.json'
