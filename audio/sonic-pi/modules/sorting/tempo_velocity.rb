tempo = 60
case tempo
when 60
  thirtysecond = 0.125
  sixteenth = 0.25
  eighth = 0.5
  quarter = 1.0
  half = 2.0
  whole = 4.0
  breve = 8.0
when 120
  thirtysecond = 0.062
  sixteenth = 0.125
  eighth = 0.25
  quarter = 0.5
  half = 1.0
  whole = 2.0
  breve = 4.0
when 240
  thirtysecond = 0.031
  sixteenth = 0.062
  eighth = 0.125
  quarter = 0.25
  half = 0.5
  whole = 1.0
  breve = 2.0
end

pp = {velocity: 13, amp: 0.10}
p = {velocity: 32, amp: 0.25}
mp = {velocity: 51, amp: 0.40}
mf = {velocity: 76, amp: 0.60}
f = {velocity: 95, amp: 0.75}
fff = {velocity: 114, amp: 0.90}
