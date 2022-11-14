# Welcome to Sonic Pi

use_midi_defaults channel: 1, port: "midi_through_midi_through_port-0_14_0"


def osc1_trans(value)
  #63 = 0 semitones
  midi_cc 100, value
end

def osc1_tune(value)
  midi_cc 101, value
end

def osc1_vol(value)
  midi_cc 102, value
end

#osc1_vol(0.5 * 100)

def osc2_trans(value)
  midi_cc 103, value
end

def osc2_tune(value)
  midi_cc 104, value
end

def osc2_vol(value)
  midi_cc 105, value
end

def cross_mod(value)
  midi_cc 106, value
end

def osc_feedback_trans(value)
  midi_cc 107, value
end

def osc_feedback_tune(value)
  midi_cc 108, value
end

def osc_feedback_amount(value)
  midi_cc 109, value
end

def sub_vol(value)
  midi_cc 110, value
end

def sub_shuffle(value)
  midi_cc 111, value
end

def sub_oct(bool)
  midi_note_on :c0 if bool == 1
  midi_note_off :c0 if bool == 0
end

sub_oct(1)

def arp_frequency

end

def arp_gate
end

def arp_octaves
end

def arp_pattern
end

def delay
  #on/off
end

def delay_freq
end

def delay_feedback
end

def delay_mix
end

def reverb
  #on/off
end

def distortion
  #on/off
end

def distortion_type
end

def distortion_drive
end

def distortion_mix
end

def stutter
  #on/off
end

def stutter_freq
end

def stutter_resample
end

def amp_env
end

def filter
  #on/off
end

def filter_cutoff
end

def filter_resonance
end

def filter_blend
end

def filter_drive
end

def filter_depth
end

def filter_keytrack
end


def filter_env
end

def mod_env
end

def mono_lfo1
end

def mono_lfo2
end

def poly_lfo
end

def steps
end

def step_freq
end

def step_slide
end

def voices
end

def pitch_bend
end

def vel_track
end

def porta
end

def porta_type
end

def legato
end



def noise_vol(value)
  midi_cc 106, value
end
