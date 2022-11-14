

def startrecord(num)

  num.times do |x|
    with_fx :slicer, wave: 3, smooth: 0.50 do
      with_fx :tremolo, depth: 0.5 do

        well = sample_duration :vinyl_hiss, rate: 0.5, attack: 3, sustain: 4, release: 1

        sample :vinyl_hiss, amp: 0.85, amp_slide: 8, rate: 0.5, attack: 3, sustain: 4, sustain_level: 0.8, release: 1, pan: rrand(-0.9, -0.5), pan_slide: 8 do |hiss|
          control hiss, pan: rrand(0.9, 0.5)
        end
        sleep well / 1.5
      end
    end
  end

end

startrecord(4)
