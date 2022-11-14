# key: qq
# point_line: 1
# point_index: 2
# --
# | x - - - | x - - - | x - - - | x - - - |
live_loop :hat_4th_onbeat, sync: :bar do
  stop
  at (range 0, 4, step: 1) do # (ring 0.0, 1.0, 2.0, 3.0), no 4, except you set: inclusive: true
    sample
  end
  sleep 4
end
