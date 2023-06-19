load_sample RIB_JAZZ_SAMPS, "110FollowtheLine"

sample RIB_JAZZ_SAMPS, "110FollowtheLine", slice: 4, num_slices: 10, attack: 0.5, release: 0.5
sleep 1
sample RIB_JAZZ_SAMPS, "110FollowtheLine", slice: 5, num_slices: 10, attack: 0.5, release: 1

sample RIB_JAZZ_SAMPS, "110FollowtheLine", start: 0.6, finish: 0.72, attack: 2, release: 2.5

###############################################################################


at 240 do

  # in_thread(name: :drumsmid) do
  #   16.times do
  #     sync :drumsmid
  #     drums_mid01
  #   end
  # end
  in_thread do
    sync :kick
    loop do
        #wtih rlpf between 30-45 will produce deep thumps
        #45 and and above and you start to get more rubber bouncy ball like
        #sync :heartbeat
        2.times do
          with_fx :rlpf, cutoff: 40 do
            sample HYDRO_KITS, "808_Kick_long", attack: 0.05,  pre_amp: 1.25
            sleep 1
          end
        end
      end
  end


  with_fx :echo, phase: 1, decay: 1, max_phase: 6, mix: 0.3 do
    with_fx :reverb, room: 0.5, mix: 0.5 do
      with_fx :level, amp: 0, amp_slide: 16 do |a|
        control a, amp: 0.4
        in_thread do
          64.times do
            tick
            sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos", onset: look
            cue :kick if look == 32
            control a, amp: 0.2 if look == 58
            control a, amp: 0.1 if look == 62
            control a, amp: 0 if look == 64
            sleep 1
          end
        end
      end
    end
  end


end

with_fx :level, amp: 0, amp_slide: 16 do |a|
  control a, amp: 0.8
  in_thread do
    loop do
      sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos",
      slice: 0, num_slices: 16, attack: 2, release: 2, amp: 1.5

      sleep sample_duration RIB_JAZZ_SAMPS, "0001SummerOverturekronos",
      slice: 0, num_slices: 16, attack: 2, release: 2
    end
  end
end

#################################
#good for subtle background at some point....
loop do
    sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos", onset: (range 20, 30, inclusive: true).tick
    sleep 1
end
######################################################


#
loop do
    sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos", onset: (range 30, 30, inclusive: true).tick
    sleep 1
end
#
loop do
  with_fx :panslicer, pan_min: -0.8, pan_max: 0.8, phase: 0.5, wave: 3, smooth_up: 0.8, smooth_down: 0.8 do
    sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos", amp: 0.5, lpf: 100, onset: (range 34, 60, inclusive: true).tick
  end
  sleep 1
end
#
# with_fx :level, amp: 0.8, amp_slide: 16 do |a|
#   control a, amp: 0.0
#   in_thread do
#     loop do
#       sample RIB_JAZZ_SAMPS, "0001SummerOverturekronos",
#       slice: 12, num_slices: 16, amp: 1.5
#
#       sleep sample_duration RIB_JAZZ_SAMPS, "0001SummerOverturekronos",
#       slice: 12, num_slices: 16
#     end
#   end
# end
#################################################
