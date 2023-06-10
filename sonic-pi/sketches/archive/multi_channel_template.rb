use_bpm 90

in_thread do
  loop do
    cue :tick
    sleep 0.5
  end
end


#low 0 - 250Hz | c0(12) - c4(60)
with_fx :sound_out_stereo, output: 1, amp: 0 do



end #end of sound_out_stereo 1


#mid_low 250Hz - 1000Hz | c4(60) - c6(84)
with_fx :sound_out_stereo, output: 3, amp: 0 do

end #end of sound_out_stereo 3

#mid_high 1000Hz - 4186Hz | c6(84) - c8(108)
with_fx :sound_out_stereo, output: 5, amp: 0 do

end #end of sound_out_stereo 5

#high 4186Hz - 1250Hz |c8(108) - g9(127)
with_fx :sound_out_stereo, output: 7, amp: 0 do
end #end of sound_out_stereo 7
