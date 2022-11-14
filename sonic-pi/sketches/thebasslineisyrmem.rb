# simple midi phrase player for sonic pi

# midi notes:
#   C	  C#	 D	D#	E	  F	  F#	G	  G#	A 	A#	B
# 0	0 	1	  2  	3 	4	  5	  6	  7	  8	  9	  10  11
# 1	12	13	14	15	16	17	18	19	20	21	22	23
# 2	24	25	26	27	28	29	30	31	32	33	34	35
# 3	36	37	38	39	40	41	42	43	44	45	46	47
# 4	48	49	50	51	52	53	54	55	56	57	58	59
# 5	60	61	62	63	64	65	66	67	68	69	70	71
# 6 72  73  74  75  76  77  78  79  80  81  82  83
# 7 84  85  86  87  88  89  90  91  92  93  94  95
# 8 96  97  98  99  100 101 102 103 104 105 106 107
# 9 108 109 110 111 112 113 114 115 116 117 118 119
#10 120 121 122 123 124 125 126 127

tempo = 45
transpose = 0
rel = 0.25 # release time (multiplier of duration)
use_sched_ahead_time 1
use_midi_defaults channel: 1, port: "midi_through_midi_through_port-0_14_0"

notes = (ring :A1, :E2, :E3, :A2, :D3, :A2, :D2, :A2, :C3, :C2, :A1, :C2, :B2, :A2, :E2, :A2)
durations = (ring 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5)
durations01 = (knit 0.25, 8)
# durations = (knit 0.5,2)

e2_minor_pen = (ring :E2, :G2, :A2, :B2, :D3, :E3)
b1_minor_pen = (ring :B1, :D2, :E2, :A2, :B2).mirror
e2_minor = (ring :E2, :G2, :A2, :B2, :C3, :D3, :E3)


canon01 = [
  {pitch: :a1, length: 0.5}, {pitch: :e2,  length: 0.5}, {pitch: :e3, length: 0.5},
  {pitch: :a2, length: 0.5}, {pitch: :d3, length: 0.5}, {pitch: :a2, length: 0.5},
  {pitch: :d2, length: 0.5}, {pitch: :a2,  length: 0.5}, {pitch: :c3, length: 0.5},
  {pitch: :c2, length: 0.5}, {pitch: :a1,  length: 0.5}, {pitch: :c2, length: 0.5},
  {pitch: :b2, length: 0.5}, {pitch: :a2, length: 0.5}, {pitch: :e2, length: 0.5},
  {pitch: :a2, length: 0.5}, {pitch: :a1, length: 0.5}
]

canon02 = [
  {pitch: :a1, length: 1},
  {pitch: :e2, length: 1},
  {pitch: :e3, length: 1},
  {pitch: :d3, length: 1},
  {pitch: :a2, length: 1},
  {pitch: :d2, length: 0.25}, {pitch: :a2,  length: 0.25}, {pitch: :d2, length: 0.5},
  {pitch: :c3, length: 1},
  {pitch: :a2, length: 1}

]
define :play_user_canon do |canon|
  canon.map do |note|
    print note[:pitch]
    midi note[:pitch], attack: 0, sustain: note[:length] / 2, release: note[:length] / 2
    sleep note[:length]
  end
end

live_loop :timer do
  use_bpm tempo
  set :click, 3
  sleep 1
end

live_loop :clock do
  4.times do |bar|
    puts "bar no: " + (bar + 1).to_s
    4.times do |beat|
      puts "beat no: " + (beat + 1).to_s
      cue :clock
      sleep 1
    end
  end
end

live_loop :intro, sync: :clock do
  play_user_canon(canon01)
  sleep 1
end

live_loop :helm_bassline, sync: :clock do
  stop
  use_bpm 45

  i = tick
  1.times do
    currentNote = notes.look
    currentDuration = durations.look
    if currentNote != 128 # rest
      my_note = midi currentNote, sustain: currentDuration, channel: 1, release: rel, velocity: 90
    end
    sleep currentDuration
  end
end

live_loop :rcbreak, sync: :clock do
  stop
  use_bpm 45
  sample SOUNDS, :RC_21_95bpm_Break_DurtyC, beat_stretch: 4, onset: (range 0, 4).tick, amp: 0.5
  sleep 0.25
end

live_loop :strings01, sync: :tick do
  stop
  durations01 = (knit 0.25, 8)
  use_bpm 45

  density 1 do
    6.times do
      with_fx :slicer, wave: 2, phase: 1, smooth: 2 do
        sample SOUNDS, :EM_GambriBlues_C_120Bpm_01, pan: 0.6, beat_stretch: 4, onset: (range 0, 8).tick, amp: 2.25, rpitch: 1
        sleep durations01.look
      end
    end
  end
end

live_loop :strings02, sync: :tick do
  stop
  use_bpm 45
  use_random_seed 8982

  durations02 = (knit 0.25, 8)

  8.times do
    sample SOUNDS, :EM_GambriBlues_C_120Bpm_04, pan: -0.6, beat_stretch: 8, onset: (range 3, 8).choose, amp: 2.25, rpitch: 0
    sleep durations02.look
  end
end
