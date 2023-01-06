# Welcome to Sonic Pi

$generate_sequence = lambda do |array,value,index|
  array.delete_at(index)
  array.insert(index,value)
end

class Sequencer
  attr_accessor :pattern1, :pattern2, :pattern3, :pattern4, :notes1
  
  def initialize
    @pattern1 = Array.new(16).map!{|x|x ?x:false}
    @pattern2 = Array.new(16).map!{|x|x ?x:false}
    @pattern3 = Array.new(16).map!{|x|x ?x:false}
    @pattern4 = Array.new(16).map!{|x|x ?x:false}
    @notes1 = Array.new(8).map!{|x|x ?x:0}
  end
  
end

@sequencer = Sequencer.new

if get[:pattern1].nil?
  set :pattern1, @sequencer.seq1
  set :pattern2, @sequencer.seq2
  set :pattern3, @sequencer.seq3
  set :pattern4, @sequencer.seq4
end

if get[:notes1].nil?
  set :notes1, @sequencer.notes1
end


def start_router
  live_loop :router do
    
    use_real_time
    # this will be either 1 or 0
    value = sync "/osc*/*/*"
    
    message = parse_sync_address("/osc*/*/*")
    print message
    
    row = message[1]
    print row
    
    # this will be in a range from 1-16
    if message[2] == "reset"
      index = "reset"
      set :index, index
    else
      index = message[2].to_i
      set :index, index - 1
    end
    
    print get[:index]
    
    set :value, value[0]
    print get[:value]
    
    case row
    when "pattern1"
      seq = $generate_sequence[@sequencer.pattern1 ,get[:value], get[:index]]
      print seq
      set row.to_sym, seq
    when "pattern2"
      seq = $generate_sequence[@sequencer.pattern2 ,get[:value], get[:index]]
      print seq
      set row.to_sym, seq
    when "pattern3"
      seq = $generate_sequence[@sequencer.pattern3 ,get[:value], get[:index]]
      print seq
      set row.to_sym, seq
    when "pattern4"
      seq = $generate_sequence[@sequencer.pattern4 ,get[:value], get[:index]]
      print seq
      set row.to_sym, seq
    when "notes"
      if get[:index] == "reset"
        set row.to_sym, Array.new(8).map!{|x|x ?x:0}
      else
        notes =  $generate_sequence[@sequencer.notes1 ,get[:value], get[:index]]
        print notes
        set :notes1, notes
      end
    end
    
  end
  
end

start_router

uncomment do
  
  live_loop :test do
    print get[:notes1].ring
    
    notes = get[:notes1].ring
    
    midi notes.tick, velocity: 90
    sleep 0.25
    
  end
  
  live_loop :hey do
    
    sample SOUNDS, "RC_Kick_01", 6, amp: 0.5 if get[:pattern1].ring.tick
    #play 48, amp: 1.0, attack: 0.125, release: 0.125, on: @pattern1.ring.look
    sleep 0.25
  end
  
end
