
live_loop :noise do
  play 30, amp: 0.01, attack: 0.75, release: 0.25
  sleep 1
end

sample808 = "/home/b08x/studio/resources/samples/drums/drumkits/Classic-808"

live_loop :ebeat do

#wtih rlpf between 30-45 will produce deep thumps
#45 and and above and you start to get more rubber bouncy ball like
  with_fx :rlpf, cutoff: 45 do
    sample SAMPLES, "808_Kick_long"
  end
  sleep 1
end



