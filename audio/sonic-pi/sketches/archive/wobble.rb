# Defining standalone wobble

# WOBBLE BASS
define :wob do |note, no_of_wobs, duration|
  # using in_thread so we don't block everything
  in_thread do
    use_synth :sine
    lowcut = note(:E1) # ~ 40Hz
    highcut = note(:G8) # ~ 3000Hz

    duration = duration.to_f || 2.0
    bpm_scale = (60 / current_bpm).to_f
    distort = 0.2

    # scale the note length based on current tempo
    slide_duration = duration * bpm_scale

    # Distortion helps give crunch
    with_fx :distortion, distort: distort do

      # rlpf means "Resonant low pass filter"
      with_fx :rlpf, cutoff: lowcut, cutoff_slide: slide_duration do |c|
        play note, attack: 0, sustain: duration, release: 4

        c.ctl cutoff_slide: ((duration / no_of_wobs.to_f) / 2.0)

        # Playing with the cutoff gives us the wobble!
        # low cutoff    -> high cutoff        -> low cutoff
        # few harmonics -> loads of harmonics -> few harmonics
        # wwwwwww -> oooooooo -> wwwwwwww
        #
        # N.B.
        # * The note is always the same length *
        # * the no_of_wobs just specifies how many *
        # * 'wow's we fit in that space *
        no_of_wobs.times do
          c.ctl cutoff: highcut
          sleep ((duration / no_of_wobs.to_f) / 2.0)
          c.ctl cutoff: lowcut
          sleep ((duration / no_of_wobs.to_f) / 2.0)
        end
      end
    end
  end
end


# first arg is the midi note,
# second is the number
#   of wobs you want to fit in that note
# third is note duration
#wob(36, 2, 8)
# sleep 2
#wob(25, 2, 8)
# sleep 2
# wob(42, 6, 2)
# sleep 2
# wob(24, 16, 2)
