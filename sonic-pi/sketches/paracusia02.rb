#########################################################################################################
#                                     paracusia: an auditory alucinari
#########################################################################################################
# { ancient greek ἀλύω }
#
# some few years later I'd imagine...
#
# the word makes it to < latin > country
#
# alucinari: inflection of alucinor
#
# [the latin suffix -ari is used to form demonyms, which are:
#                                   nouns used to denote the natives or
#                                   inhabitants of a particular country,
#                                   state, city, etc.]
#
# alucinor: to wander or roam in the mind, talk idly, dream
#
#           ālūcinātor: refering in the 2nd or 3rd person
#
# alūcinātus: refering to an alucinor that occurred in the past
#
# some odd years later, the vowels and constants are transferred back over
# to what I suppose should be called regular greek
#
# alussein: be uneasy or distraught.
#
# Well sure, you're gonna want to replace daydreaming with anxiety. How else are things to be done!?
#
# Some odd years later in the mid 17th century, English speaking (or trying to anyway) people decided to keep the
# higher strung greek version in favor the laxidascal latin.
#
# quick poem:
# hallucinari: to be uneasy or distraught
# hallucinat: gone astray in thought
#
#
# After all the flags were surplanted, the words carried on a :jetstream that we can't see
# but we all agree is there.
#
# And here's where all these words, and more!, ended up...
#
# hallucination: a sensory perception (such as a visual image or a sound)
# that occurs in the absence of an actual external stimulus and usually
# arises from neurological disturbance (such as that associated
# with delirium tremens, schizophrenia, Parkinson's disease, or narcolepsy)
# or in response to drugs (such as LSD or phencyclidine)
#
#
# If you think about it, it is sort of astounding
# That anyone could think we should all agree,
#   on the how the individual expierences the senses.
#   Uncertainly there are too many.
#   This word is damaged.
#   Labled out of ignorance
# driving fear driving ignorance.
#   I'd much rather think of it as a passtime.
# to play paracusor on the holonym device.

# Brought to you by:
#
#                   Electricity.
#                    Making it happen since whenever.
#
# And the Proud Folks over at:
#                            Computers!: They're not telephones, but they can be if you want.
#
#
#


# paracudramija ( para coo drame jaa ) listening to audio signals, transferred via a digial device usually, while relaxing
# so as to focus on listening for words and sentences
# paracudramias ( para coo dram e ss) laying in bed, mostly clothed, listening to the music that results in the mixture of white noises.
#                                                                            soft radio
#
# from the latin paracu-sia, meaning to expierence auditory events without present stimuli.
#               that is to say, you can hear the music in the static.
# from Proto-Germanic *draumijaną‎ meaning to be festive, part root of today's word for dream, or waking life. The thing you may expierence
#                                                                                                      when you sleep
#
#
#

ambulo: from ambi + alo = to wander, traverse, travel, walk

#dream: …from Proto-Germanic *draumijaną‎, *draugmijaną‎ ("to be festive,

set_mixer_control! hpf: 21
set_volume! 0.5

use_real_time

use_midi_defaults port:  "midi_through_midi_through_port-0_14_0", channel: 1

#["A1", "E2", "E3", "A2", "D3", "A2", "D2", "A2", "C3", "C2", "A1", "C2", "B2", "A2", "E2", "A2"]
chords = ["Am", "AMsus2", "DMsus2", "DM6sus2", "D7sus2", "AMsus4", "EMsus4", "E7sus4", "E+sus4", "E+7sus4"]

# given a scale, return it as an indexed hash
# {0=>60, 1=>62, 2=>64, 3=>65, 4=>67, 5=>69, 6=>71, 7=>72}
def note_hash(scale)
  scl = {}
  scale.each_with_index do |note,index|
    scl[index] = note
  end
  return scl
end

c_maj = note_hash(scale :c, :major)
g_maj = note_hash(scale :g, :major)
a_harmonic_minor = note_hash(scale :a, :harmonic_minor)
a_hungarian_minor = note_hash(scale :a, :hungarian_minor)
e_melodic_minor_asc = note_hash(scale :e, :melodic_minor_asc)

s = ring(c_maj, g_maj, a_harmonic_minor, a_hungarian_minor, e_melodic_minor_asc)

print s


play  chord :Cs, '+5'




exit


in_thread name: :definitions do
  def tempo(tempo)
    set :tempo, tempo
  end
end

tempo(89)

in_thread name: :clock do
  loop  do
    cue :clock
    use_bpm get[:tempo]
    puts get[:tempo]
    sleep 1
    puts current_beat_duration
  end
end

in_thread name: :twobars do
  loop  do
    sync :clock
    cue :twobars
    sleep 4
    puts current_beat_duration
  end
end


live_loop :first do
  sync :clock
  cue :first
  play 32, amp: 0.5, attack: 0.0125
  #sleep [0.25,0.50].choose
  #sleep [0.5,0.75,2].choose
  #sleep 1
end

live_loop :second do
  sync :twobars
  cue :second
  sample :drum_bass_hard, amp: 0.8, attack: 0.125, sustain: 0.5
  #sleep [0.25,0.50].choose
  #sleep [0.5,0.75,2].choose
  #sleep 1
end

sleep 8

live_loop :third do
  sync :clock
  cue :third
  
  use_random_seed 497
  use_octave 0
  
  
  notes = (ring 33, 40, 52, 45, 50, 45, 38, 45, 48, 36, 33, 36, 47, 45, 40, 45)
  
  midi notes.tick, attack: 0.0125
  
  #sleep [0.55,0.60,0.65].choose * 1.5
end
