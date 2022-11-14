def get_notes(root, type, lambda_arg)

  notes = lambda_arg.call(root, type)
  print notes
  4.times do
    play notes.tick, amp: 0.8
    sleep 0.25
  end

end

forward_lambda = lambda do |root, type|
  return scale(root.to_sym, type.to_sym)
end

backwards_lambda = lambda do |root, type|
  return scale(root.to_sym, type.to_sym).reverse
end



get_notes "C", "major", forward_lambda
sleep 1
get_notes "C", "major", backwards_lambda


------------------------------------------------------------------------

set_mixer_control! hpf: 21
use_sched_ahead_time 1

set :tempo, 45

live_loop :timer do
  cue :clock
  use_bpm get[:tempo]
  sleep bt(1)
end

# Sync 2-bar patterns
live_loop :half, autocue: false do
  sync :clock
  cue :halfnote
  sleep bt(0.5)
end

# Synch 4-bar patterns
live_loop :quarter, autocue: false do
  sync :clock
  cue :quarternote
  sleep bt(0.25)
end

forward_lambda = lambda do |root, type|
  return scale(root.to_sym, type.to_sym)
end

backwards_lambda = lambda do |root, type|
  return scale(root.to_sym, type.to_sym).reverse
end

def get_notes(root, type, lambda_arg)
  use_synth :piano
  notes = lambda_arg.call(root, type)

  4.times do
    play notes.tick, amp: 0.8
    sleep 0.25
  end

end

live_loop :test, sync: :clock do
  get_notes "C2", "major", forward_lambda
  sleep 4
end

live_loop :test2, sync: :quarter do
  get_notes "a2", "major", backwards_lambda
end
