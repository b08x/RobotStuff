# Welcome to Sonic Pi

# creates an array with 16 placeholders as nil
# convert nils to zeros https://stackoverflow.com/a/2527779
defonce :set_initial_sequences do

  [:seq1, :seq2, :seq3, :seq4 ].each do |seq|
    set seq, Array.new(16).map!{|x|x ?x:0}
  end

end

set_initial_sequences

$generate_sequence = lambda do |array,bool,index|
  array.delete_at(index)
  array.insert(index,bool)
end

def seq_router
  live_loop :router do

    use_real_time
    # this will be either 1 or 0
    onoff = sync "/osc*/row1/*"

    print parse_sync_address("/osc*/row1/*")

    # this will be in a range from 1-16
    index = parse_sync_address("/osc*/row1/*")[2].to_i

    set :onoff, onoff[0]
    print get[:onoff]

    set :index, index - 1
    print get[:index]

    i = get[:seq1].dup
    seq = $generate_sequence[i, get[:onoff], get[:index]]
    set :seq1, seq

  end

end
# 
# live_loop :hey do
#   16.times do
#     tick
#     sample :bd_gas, on: get[:seq1].ring.look
#     #play 48, amp: 1.0, attack: 0.125, release: 0.125, on: @seq1.ring.look
#     sleep 0.25
#   end
# end
#
#
# live_loop :seq2 do
#   8.times do
#     note = get[:note]
#     tick
#     play note, amp: 1.0, attack: 0.125, release: 0.125, on: get[:seq2].ring.look
#     sleep 0.25
#   end
# end
