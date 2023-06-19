# Welcome to Sonic Pi
class Drumkits
  attr_accessor :samples
  
  def initialize(index)
    @samples = DRUMKITS.children
    @samples.map! {|x| x + "/**"}
    @samples.map! {|x| File.join(DRUMKITS, x) }
    @samples = @samples[index]
  end
  
  def load
    load_samples @samples
  end
  
end

in_thread(name: :clock) do
  loop do
    cue :clock
    sleep 1
    puts current_beat_duration
  end
end


in_thread(name: :half, sync: :clock) do
  loop do
    cue :half
    sleep 0.5
  end
end

in_thread(name: :quarter, sync: :clock) do
  loop do
    cue :quarter
    sleep 0.25
  end
end

kitchen_beats01 = Drumkits.new(1).samples
load_samples kitchen_beats01

live_loop :beats01 do
  sync :quarter
  
  filter = lambda do |candidates|
    [candidates.choose]
  end
  
  use_random_seed 6508
  
  4.times do |x|
    sample kitchen_beats01, filter
    sleep 1
  end
  
end

other_beats = Drumkits.new(8).samples
load_samples other_beats

live_loop :beats02 do
  sync :quarter
  6.times do |x|
    sample other_beats, [0,2,4,6].tick
    sleep 0.75
  end
end