# Welcome to Sonic Pi

$generate_sequence = lambda do |array,bool,index|
  array.delete_at(index)
  array.insert(index,bool)
end

$generate_midi_sequence = lambda do |array,note,index|
  array.delete_at(index)
  array.insert(index,note)
end


class Sequencer
  attr_accessor :seq1, :seq2, :seq3, :seq4, :midiseq1

  def initialize

    @seq1 = Array.new(16).map!{|x|x ?x:0}
    @seq2 = Array.new(16).map!{|x|x ?x:0}
    @seq3 = Array.new(16).map!{|x|x ?x:0}
    @seq4 = Array.new(16).map!{|x|x ?x:0}
    @midiseq1 = Array.new(16).map!{|x|x ?x:0}

  end

  def generate(array,bool,index)
    array.delete_at(index)
    array.insert(index,bool)
    return array
  end

  def generate_midi(array,note,index)
    array.delete_at(index)
    array.insert(index,note)
    return array
    print "array!"
    print array
  end

end

@sequence = Sequencer.new

def seq_router
  live_loop :router do

    use_real_time
    # this will be either 1 or 0
    onoff = sync "/osc*/*/*"

    print parse_sync_address("/osc*/*/*")

    row = parse_sync_address("/osc*/*/*")[1]
    print row

    # this will be in a range from 1-16
    index = parse_sync_address("/osc*/*/*")[2].to_i

    set :onoff, onoff[0]
    print get[:onoff]

    set :index, index - 1
    print get[:index]

    case row
    when "seq1"
      seq = $generate_sequence[@sequence.seq1 ,get[:onoff], get[:index]]
      print seq
      set row.to_sym, seq
    when "seq2"
      seq = $generate_sequence[@sequence.seq2 ,get[:onoff], get[:index]]
      print seq
      set row.to_sym, seq
    when "seq3"
      seq = $generate_sequence[@sequence.seq3 ,get[:onoff], get[:index]]
      print seq
      set row.to_sym, seq
    when "seq4"
      seq = $generate_sequence[@sequence.seq4 ,get[:onoff], get[:index]]
      print seq
      set row.to_sym, seq
    when "midiseq1"
      midiseq =  $generate_sequence[@sequence.midiseq1 ,get[:onoff], get[:index]]
      print midiseq

      set row.to_sym, midiseq
    end

  end

end

seq_router

live_loop :test do

  notes = get[:midiseq1].ring

  midi notes.tick, velocity: 90
  sleep 1

end
