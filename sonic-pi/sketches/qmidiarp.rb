
# e.g. arpeggiate [4,2,3], :d3, :major, [0,1,2,3,4], 4
use_bpm 60
use_midi_defaults port:  "midi_through_midi_through_port-0_14_0", channel: 1


live_loop :pianos01 do
  midiarpeggiate [1,2], :e5, :melodic_minor_asc, [0,2,3], 1
  
end

live_loop :pianos02 do
  midiarpeggiate [1,2], :e2, :melodic_minor_asc, [0,2,3], 1
  
end

# qmidiarp LFO frequency 0(1/32) - 13(8)
#midi_cc 10, 3

# qmidiarp LFO frequency 0(1/32) - 13(8)
# 1/32 1/16 1/8 1/4 3/4 1 2 3 4 5 6 7 8
#midi_cc 10, 3

# qmidiarp LFO resolution 0 - 8
#1,2,4,8,16,32,64,128,192
#midi_cc X, 0


# qmidiarp LFO Length 0 - 11
# 1 2 3 4 5 6 7 8 12 16 24 32

# qmidiarp LFO waveform 0 - 5
# square triangle pulse ...


# qmidiarp LFO direction 0 - 6
qmidiarp_direction = {
  :loop_right => 0,
  :loop_left => 1,
  
  :bounce_right => 2,
  :bounce_left => 3,
  
  :once_right => 4,
  :once_left => 5,
  
  :random => 6
}

print qmidiarp_direction[:loop_right]


# qmidiarp LFO amplitutde 0 - 127
# qmidiarp SEQ velocity 0 - 127

# qmidiarp LFO offset 0 - 128

# qmidiarp mute 0 - 1

# qmidiarp record 0 - 1

# seq transpose -24 - 24

# seq note length 0 - 127

# seq resolution 1 2 4 8 16

# seq length 1 2 3 4 5 6 7 8 16 32

# arp pattrern/preset switch 0 - whatever
# add pattern to qmidiarp and reference it here

# global groove
#global shift
# global velocity

# global restore
# create seq 1
# select notes and what not
# go down to global restore area
# click the save icon next to 1

# click on the save icon nex to 2
# this creates a duplicate of seq 1
# then in from the second row, select
# seq1, 2
# edit the sequence to make it different from 1


midi_cc 101, 0

live_loop :first do
  cue :first
  play 32
  #sleep [0.25,0.50].choose
  sleep [0.5,0.75].choose
  sleep 4
end



live_loop :second do
  dir = "/home/b08x/Library/to_process/loops/7THSUN124/samples"
  sun_loop = load_sample dir, 1
  #use_random_seed 3435
  use_random_seed 8871
  o = range(4,16).choose
  sample sun_loop, onset: o
  sleep sample_duration(sun_loop, onset: o)
end

live_loop :third do
  sync :first
  play 38, amp: 0.5, attack: 0.125
  sleep 0.75
  sleep 4
end
