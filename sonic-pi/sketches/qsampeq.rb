set_mixer_control! hpf: 21

#for decent bass just set the low values to postive, for less bass just set them to negative. it sounds fine
#the way it is now, dont fuck with it. (guitarix isn't necessary for this)
with_fx :eq, low_shelf: 0, low_shelf_note: 31, low_shelf_slope: 0.9, low: 0, low_note: 42, low_q: 0.8,
             mid: 0, mid_note: 70, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 119, high_shelf_slope: 0.5, pre_amp: 4 do



                    live_audio :qsamp, stereo: true, input: 5

                    live_audio :yosh, input: 3, stereo: true



end #end of eq fx

#use with /home/b08x/studio/sessions/newest_favorite.carxp

#this was setup using headphones connected to hw:PCH
#it should have more volume when played back over hw:PCH,1 (stero speakers)
