require 'rubygems'
require 'bloops'
require 'whoops'

b = Bloops.new

b.tempo = 180

snare = b.sound Bloops::NOISE
snare.punch   =  0.8
snare.volume = 0.6
snare.sustain =  0.03
snare.decay   =  0.3
snare.freq    =  0.1

base = b.sound Bloops::SQUARE
base.volume = 0.9
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

s1 = Whoops::Sequence.generate(:length => 64, :pitches => ["C"], :durations => [1,2,4,8,6])

s2 = Whoops::Sequence.generate(:length => 64, :pitches => ["C"], :durations => [1,2,4,8,6])

s3 = Whoops::Sequence.generate(:length => 64, :pitches => ["C"], :durations => [1,2,4,8,6])

b.tune snare, <<-Q
  #{s1}
Q

b.tune base, <<-Q
  #{s2}
Q

b.tune hat, <<-Q
  #{s3}
Q



b.play
sleep 0.01 while not b.stopped?