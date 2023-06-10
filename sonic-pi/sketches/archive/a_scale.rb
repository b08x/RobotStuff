####
use_debug true
use_bpm 120

live_loop :start do
  
  play 60
  sleep 4
  2.times do
    play [64,61].tick
    sleep 1
  end
  
end

live_loop :second do
  4.times do
    
  play 46, attack: 0.125, release: 0.175
  sleep 1
  end
  sleep 1
end

tuning = (ring :d3, :d3, :a3, :fs3, :f4)

spirit_variation = (ring :d4, :ds4, :f4, :fs4, :a4, :as4, :c5, :cs5, :f5, :fs5)

blue_variation = (ring :g4, :gs4, :a4, :c5, :d5)

puts midi_to_hz(50)

with_synth :piano

####
##    harmonic_series:
##  the simpler the ratio between two frequencies, the more consonance they are
####  

fundamental_note = 146.82 #d3

fnote = fundamental_note

fnote * 2 = 293.64 #d4 2/1
fnote * 3 = 440.46 #a4  3/1
fnote * 4 = 587.28 #d5    4/1
fnote * 5 = 734.10 #f5    5/1

# a 3/1 ratio, for some reason, is a good place to start when creating a scale
# so, for example, with d3; add one note above and one note below by using a 3/1 ratio....

next_note_above_fund = 146.82 * 3 = 440.46 #a4
one_note_below_fund = 146.82 / 3 = 48.94 #g1

# so now we have, :g1, :d3, :a4

# now, multiply g1 * 2 and divide a4 / 2

146.82 * 3/2 = 220.23 #a3
146.82 / 3*2 = 97.88 #g2


# 

97.88 / 3 = 32.62 #c1
146.82
220.23 * 3 = 660.9 #e5

####
# 
#"tonic" can also be used here as a variable name
#tonic, being the root note of a scale...
# 
#the second note, the fourth note and the eigth note
#should be octaves of the tonic
#
#
#** continue here; https://youtu.be/WDbxhNb_gk4?t=222


