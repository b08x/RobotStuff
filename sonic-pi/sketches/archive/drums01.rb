use_bpm 45
def drums_mid02

   #               1 e & a  2 e & a  3 e & a  4 e & a
   cymbals = bools(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,1)
   hard    = bools(1,0,1,0, 0,0,0,0, 1,0,1,0, 0,0,0,0)
   soft    = bools(0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,0,0)
   kick    = bools(1,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,1,0)


CONSTANT


  with_fx :reverb, room: 0.6 do

       16.times do
         tick
         if cymbals.look then
           if one_in(8) then
             sample DRUMKITS, "64conga_low", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, pan: rrand(-0.9,0.9)
           else
             sample DRUMKITS, "63conga_high", attack: 0.01, sustain: 0.2, release: 0.02, amp: 0.3, rate: -1, pan: rrand(-0.9,0.9)
           end
         else

           sample SOUNDS, "EE_Hat_Cl_Dirty", amp: 0.5
        end

        with_fx :band_eq, freq: 38, db: 1.5, res: 0.3 do
          sample DRUMKITS, "35kick", pan: 0, amp: 0.6, on: hard.look

          sample DRUMKITS, "99931__menegass__noise-tom1", pan: 0, amp: 0.6, on: soft.look

          sample DRUMKITS, "41_dropbass", lpf: 60, pan: 0, amp: 0.5, on: kick.look
        end

         sleep 0.25
       end

  end

end

live_loop :drums do
  drums_mid02
  sleep 0.5
end
