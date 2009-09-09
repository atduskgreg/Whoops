require 'rubygems'
require 'bloops'
require 'whoops'

b = Bloops.new

b.tempo = 180

snare = b.sound Bloops::NOISE
snare.punch   =  0.8
snare.volume = 0.7
snare.sustain =  0.03
snare.decay   =  0.3
snare.freq    =  0.1

base = b.sound Bloops::SQUARE
base.volume = 0.95
base.punch = 0.3
base.sustain = 0.27
base.freq = 0.1
base.decay = 0.3
base.phase = 0.2
base.lpf = 0.115
base.resonance = 0.55
base.slide = -0.4

hat = b.sound Bloops::NOISE
hat.punch   =  0.724
hat.sustain =  0.01
hat.decay   =  0.12
hat.freq    =  0.99

hat2 = b.sound Bloops::NOISE
hat2.punch   =  0.724
hat2.sustain =  0.01
hat2.decay   =  0.12
hat2.freq    =  0.99

g = b.sound Bloops::SAWTOOTH
g.sustain = 0.306
g.decay   = 0.477
g.freq    = 0.429
g.volume = 0.4

g2 = b.sound Bloops::SAWTOOTH
g2.sustain = 0.306
g2.decay   = 0.7
g2.freq    = 0.429
g2.volume = 0.2



hat_detail = Whoops::Sequence.generate(:length => 64, :pitches => ["C", " ", " ", " ", " "], :durations => [16, 16, 16, 32, 32, 18, 9])
snare_beat = Whoops::Sequence.generate(:length => 64, :pitches => ["C"], :durations => [2,2,4])
bdum_beat = Whoops::Sequence.generate(:length =>  64, :pitches => ["C"], :durations => [4,4,4,8])
hat_beat = Whoops::Sequence.generate(:length =>   64, :pitches => ["C"], :durations => [4,4,4,4,4])



a_melody = Whoops::Sequence.generate(:length => 32, :pitches => ["A", "A", "C#", "C#", "A", "E", "A", "E", "D", "G"], :durations => [1, 2, 2, 1, 1, 2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 9])
                                                                 
d_melody = Whoops::Sequence.generate(:length => 16, :pitches => ["D", "A", "D", "F", "G", "D", "A", "F", "B", "G", "E"], :durations => [1, 1, 1, 1, 2, 2, 2, 9, 4, 4, 4, 4, 4, 8, 8, 9])
                                                                 
e_melody = Whoops::Sequence.generate(:length => 16, :pitches => ["E", "E", "E", "E", "B", "B",  "G#", "G#", "G#", "F", "A"], :durations => [1, 1, 1, 4, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 9])



intro_base = Whoops::Sequence.generate(:length => 9, :pitches => ["A", "C#", "A", "E", "A"], :durations => [1, 1, 2, 2, 2, 2, 4, 4])


a_base = Whoops::Sequence.generate(:length => 32, :pitches => ["A", "C#", "A", "E", "A"], :durations => [1, 1, 2, 2, 2, 2, 4, 4])
d_base = Whoops::Sequence.generate(:length => 16, :pitches => ["D", "D", "A", "F", "A"], :durations =>  [1, 1, 2, 2, 2, 2, 4, 4, 8])
e_base = Whoops::Sequence.generate(:length => 16, :pitches => ["E", "E", "B", "G#", "G#"], :durations =>[4])


# A A D E

b.tune hat, hat_beat.to_s
b.tune snare, snare_beat.to_s
b.tune base, bdum_beat.to_s
b.tune hat, hat_detail.to_s

b.tune g,  "#{a_melody} #{d_melody} #{e_melody}"
b.tune g2, "#{a_melody} #{d_melody} #{e_melody}"

b.tune g, "- #{a_base} #{d_base} #{e_base}"
b.tune g, "- - #{a_base} #{d_base} #{e_base}"

while true do
  b.play
  sleep 0.01 while not b.stopped?
end