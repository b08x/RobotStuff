# Welcome to Sonic Pi
set_volume! 0.36
set_mixer_control! hpf: 21

with_fx :reverb, room: 0.25, damp: 0.5 do
  
  live_loop :test do
    use_random_seed 3657
    
    #notes = chord :d, :major
    
    notes = scale :e3, :iwato
    
    with_fx :mono do
      with_fx :reverb, room: 0.1, damp: 0.2 do
        4.times do
          use_synth :piano
          play notes.choose, sustain: 0.5
          
          sleep 0.45
          
        end
        
        2.times do
          use_synth :pluck
          play notes.tick, release: 1
          sleep 0.125
        end
        
      end
    end
    
    #x = dice 6
    print rand_i_look(5)
    
    #if x == 3
    with_fx :reverb, room: 1, damp: 0.5 do
      with_fx :pan, pan: rrand(-0.5,0.5) do
        with_fx :echo, decay: 8, phase: 0.25, mix: 0.25 do
          2.times do
            sample :tabla_dhec
            sleep 0.5
          end
        end
      end
    end
    
  end
  
end