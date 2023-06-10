scale_names.each_with_index do |x,v|
  print x
  print v
end

print chord_names.to_s


use_osc "192.168.41.145", 9000

define :getscales do
  sc = scale_names
end

define :getchords do

end
#play chord :c3, '+5'
#scale :a3, :aeolian
print midi_notes :d3, :d4, :d5
#midi_notes :


puts sample_duration :ambi_haunted_hum

a = [:r,:r]

a[0] = 12
print a[0].to_r

pattern = [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]
pattern[1] = 1
pattern[4] = 1
print pattern.methods
p = bools pattern
print p


print a

----------------------



comment do

  q = (chord :d, '6*9')
  puts q

  a = Something::get_chord_note_names("D")
  a.each do |x|
    x.each do |y|
      use_transpose 24
      use_synth :piano
      n = hz_to_midi(y.frequency.frequency)
      play n
      sleep 0.25
    end
    sleep 1

  end
end

# if the intent is to only play this once,
# and not have it play again when sonic is
# 're-run', try using defonce:
# it won't even play again if sonic is
# stopped
defonce :omething do
  sample :drum_tom_lo_soft
end

omething



# this will, change the note of "@a" ("@" indicating this is an instance variable from 52 to 80 if the
# toggle button is pressed and set to 1.0
use_osc "192.168.41.4", 9000
use_osc_logging true


# /soundbot/label136, "whatever" didn't work, but this does...
osc "/1/trackname", "hey"
osc "/soundbot/label77", "ho"
# these worked....
#osc "/soundbot/led59",1
#osc "/soundbot/fader1", 0

#set the active page on the device, e.g. switch to page two
#osc "/2"

#change the colors of the controls
osc "/1/volume/color", "blue"
osc "/1/trackname/color", "yellow"


#toggle whether or not the control is visible on the device
osc "/1/volume/visible", 1

#https://hexler.net/docs/touchosc-controls





live_loop :asetting do
  z = sync "/osc*/*/*"
  a,b,c = parse_sync_address "/osc*/*/*"

  if b.to_i == 1
    play 70
  end

  case z[0]
  when 1
    control @a, note: 80
  when 0
    control @a, note: 66
  end
end

live_loop :this do
  use_synth :beep
  sleep 1
  @a = play degree(:ii, :d3, :major), attack: 1, note_slide: 3
  sleep 1
  b = play degree(:v, :d2, :major), attack: 1

end

end
end
