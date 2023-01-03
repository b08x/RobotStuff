# Welcome to Sonic Pi

$generate_sequence = lambda do |array,bool,index|
  array.delete_at(index)
  array.insert(index,bool)
end

class Sequencer
  attr_accessor :seq1, :seq2, :seq3, :seq4, :midiseq1

  def initialize

    @seq1 = Array.new(16).map!{|x|x ?x:0}
    @seq2 = Array.new(16).map!{|x|x ?x:0}
    @seq3 = Array.new(16).map!{|x|x ?x:0}
    @seq4 = Array.new(16).map!{|x|x ?x:0}
    @midiseq1 = Array.new(8).map!{|x|x ?x:0}

  end

  def generate(array,bool,index)
    array.delete_at(index)
    array.insert(index,bool)
    return array
  end

  def generate_midi(array,note,index)
    if index == "reset"
      array = Array.new(8).map!{|x|x ?x:0}
    else
      array.delete_at(index)
      array.insert(index,note)
    end
    return array
  end

end

@sequence = Sequencer.new

def seq_router
  live_loop :router do

    use_real_time

    onoff = sync "/osc*/*/*"

    message = parse_sync_address("/osc*/*/*")

    print onoff
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

    set :onoff, onoff[0]

    case row
    when "seq1"
      seq = @sequence.generate(@sequence.seq1 ,get[:onoff], get[:index])
      print seq
      set row.to_sym, seq
    when "seq2"
      seq = @sequence.generate(@sequence.seq2 ,get[:onoff], get[:index])
      print seq
      set row.to_sym, seq
    when "seq3"
      seq = @sequence.generate(@sequence.seq3 ,get[:onoff], get[:index])
      print seq
      set row.to_sym, seq
    when "seq4"
      seq = @sequence.generate(@sequence.seq4 ,get[:onoff], get[:index])
      print seq
      set row.to_sym, seq
    when "midiseq1"
      midiseq = @sequence.generate_midi(@sequence.midiseq1 ,get[:onoff], get[:index])
      print midiseq

      set row.to_sym, midiseq
    end

  end

end

seq_router

live_loop :test do

  notes = get[:midiseq1].ring

  midi notes.tick, velocity: 90, channel: 1
  sleep 1

end

live_loop :hey do
  16.times do
    tick
    sample SOUNDS, "RC_Kick_01", 6, amp: 0.5, on: get[:seq1].ring.look
    #play 48, amp: 1.0, attack: 0.125, release: 0.125, on: @seq1.ring.look
    sleep 0.25
  end
end
