set_mixer_control! hpf: 21
# set_volume! 1
# for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
# the way it is now, dont fuck with it. (guitarix isn't necessary for this)

with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.4, low: 0.5, low_note: 40, low_q: 0.8,
             mid: 0, mid_note: 70, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 1 do

  @loopdir = '~/.sonic-pi/store/default/cached_samples/'

  # Count every beat
  live_loop :bar do
    cue :tick
    sleep 1
  end

  # Sync 2-bar patterns
  live_loop :two_bars, autocue: false do
    sync :tick
    cue :every_two_bars
    #puts sample_duration :elec_blip, amp: 0.01, rate: 1
    #sleep 8
    sleep 8.158
  end

  # Synch 4-bar patterns
  live_loop :four_bars, autocue: false do
    sync :tick
    cue :every_four_bars
    #puts sample_duration :elec_blip, amp: 0.01, rate: 2.0
    sleep 16.08
  end

  # Synch 4-bar patterns
  live_loop :eight_bars, autocue: false do
    sync :tick
    cue :every_eight_bars
    #sample :elec_blip, amp: 0.01, rate: 2.0
    sleep 32.08
  end

  at 0 do
    live_loop :rain01 do
      with_fx :level, amp: 0.3 do
        with_fx :mono, pan: -0.9 do
          sample SAMPLES, 'rain', attack: 12, release: 2, amp: 0.3
          sleep sample_duration SAMPLES, 'rain', attack: 12, release: 2
        end
      end
    end

    live_loop :rain02 do
      with_fx :level, amp: 0.3 do
        with_fx :mono, pan: 0.9 do
          sample SAMPLES, 'rain', attack: 12, release: 2, amp: 0.3
          sleep sample_duration SAMPLES, 'rain', attack: 12, release: 2
        end
      end
    end
  end

  at 16 do
    foundation = File.join(@loopdir, 'foundation.wav')
    with_fx :level, amp: 0, amp_slide: 4 do |a|
      live_loop :foundation01, sync: :every_two_bars do
        with_fx :mono, pan: 0 do
          with_fx :band_eq, freq: 45, db: -6, res: 0.6 do
            sample foundation, start: 0.01, finish: 0.99, attack: 0.25, release: 0.125, amp: 0.75, rate: 1
          end
        end
        sleep 8
      end
      control a, amp: 0.8
    end
  end

  at 24 do
    #8 beats
    layerone = File.join(@loopdir, 'layerone.wav')

    with_fx :level, amp: 0, amp_slide: 4 do |a|
      live_loop :layerone, sync: :every_eight_bars do
        with_fx :mono, pan: 0 do
          sample layerone, start: 0, finish: 0.5, attack: 0.25, release: 0.125, amp: 1, rate: 1
        end
        sleep 16
      end

      control a, amp: 1
    end
  end

  at 32 do
    acobass01 = File.join(@loopdir, 'acobass.wav')

    live_loop :ab01, sync: :every_eight_bars do
      stop
      with_fx :reverb, room: 0.4, damp: 0.3, res: 0.6 do
        sample acobass01, start: 0, finish: 1, attack: 1, release: 0.5, amp: 0.8, rate: 1
      end
      sleep 8
    end
  end

  at 40 do
    live_loop :heartbeat, sync: :every_two_bars do
      sample SAMPLES, 'EE_Kick_Dist', attack: 0.125, release: 0.125, amp: 0.8
      sleep 0.25
      sample SAMPLES, 'EE_Kick_Dist', attack: 0.125, release: 0.125, amp: 0.8
      sleep 7.75
    end
  end

  # ############################3

  #   sleep 4
  #
  #  play_pattern_timed [:c2,:c2,:c2,:c2],[1], attack: 0.5, release: 0.5, amp: 0.5
  #
  #  sleep 1
  #
  #  in_thread do
  #    loop do
  #      sample :elec_tick
  #      sleep 1
  #    end
  #  end
  #
  #
  #  with_fx :record, buffer: buffer[:layerone,16] do

  # with_fx :rlpf, cutoff: 95, res: 0.6 do
  #   with_fx :hpf, cutoff: 38, res: 0.8 do
  #     with_fx :pan, pan: 0.8, pan_slide: 12 do |y|
  #       control y, pan: 0.8
  #       live_audio :git01, input: 1, stereo: false
  #     end
  #   end
  # end
  #
  # with_fx :rlpf, cutoff: 95, res: 0.6 do
  #   with_fx :hpf, cutoff: 38, res: 0.8 do
  #     with_fx :pan, pan: -0.8, pan_slide: 12 do |x|
  #       control x, pan: -0.8
  #       live_audio :git02, input: 2, stereo: false
  #     end
  #   end
  # end

  # end
  #
  #  sleep 16
  #  play :c2, attack: 0.25, release: 0.25, amp: 0.25

  # with_fx :record, buffer: buffer[:sitar,8] do
  with_fx :reverb, room: 0.8, damp: 0.5 do
    with_fx :level, amp: 1 do
      # channel 2 (acoustic bass) A#2
      # possibily channel 7 (cello) f2
      # channel 11 (staccato bass)
      # channel 14 (sitar) a3 - a4
      live_audio :qsamp, input: 5, stereo: true
    end
  end
  # end
end # end of eq fx

# e2 d3 e3
# e2 a3 gs3
# e2 fs3 e3

# a gs f e b c  d

# b as gs fs e ds cs (b major)
# use with /home/b08x/studio/sessions/newest_favorite.carxp

# this was setup using headphones connected to hw:PCH - for this use pre_amp: 5
# it should have more volume when played back over hw:PCH,1 (stero speakers) - for this use pre_amp: 1
