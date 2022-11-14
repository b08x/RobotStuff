# key: header
# point_line: 1
# point_index: 0
# --
set_volume! 0.66
set_mixer_control! hpf: 21
use_sched_ahead_time 1
#use_real_time

use_bpm :link
set_link_bpm! 60

# syncronize to bar or beat
live_loop :met do
  puts "current bpm " + current_bpm.to_s
  4.times do |bar|
    puts "bar no: " + (bar + 1).to_s
    cue :bar
    4.times do |beat|
      puts "beat no: " + (beat + 1).to_s
      cue :beat
      sleep 1
    end
  end
end
