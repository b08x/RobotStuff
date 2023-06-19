# Welcome to Sonic Pi
this_event = 0
last_event = beat
notes = []

live_loop :note_record do
  
  onoff = sync "/osc*/group35/*"
  
  message = parse_sync_address("/osc*/*/*")
  
  note = message[2].to_i
  
  print note
  
  this_event = beat
  
  notes << note
  notes << this_event - last_event
  
  print notes
  last_event = this_event
  
  
  
end