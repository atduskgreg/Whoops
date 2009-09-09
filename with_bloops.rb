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


s0 = Whoops::Sequence.generate(:length => 48, :pitches => ["C", " ", " ", " ", " "], :durations => [16, 16, 16, 32, 32, 18, 9])


s1 = Whoops::Sequence.generate(:length => 64, :pitches => ["C"], :durations => [2,2,4])

s2 = Whoops::Sequence.generate(:length => 64, :pitches => ["C"], :durations => [4,4,4,8])

s3 = Whoops::Sequence.generate(:length => 64, :pitches => ["C"], :durations => [4,4,4,4,4])

s4 = Whoops::Sequence.generate(:length => 64, :pitches => [" ", " ", " ",  "A", "G", "C", "C", "E", "C", "A", "A", "E", "E", "B"], :durations => [1, 1, 2, 2, 4, 1, 4, 4, 4, 4, 4, 4, 8, 8, 9])

s5 = Whoops::Sequence.generate(:length => 8, :pitches => ["C", "C", "E", "C", "A", "A", "E", "E"], :durations => [32, 64, 64])
                                                                                                                  
                                                                                                                  
s7 = Whoops::Sequence.generate(:length => 8, :pitches => ["G", "G", "D", "G", "A#", "A#", "D", "D"], :durations => [32, 64, 64])

s6 = Whoops::Sequence.generate(:length => 64, :pitches => ["C", "E", "C", "A", "E"], :durations => [1, 1, 2, 2, 2, 2, 4, 4])


puts "SNARE:"
puts "#{s1}"

puts "BASE:"
puts "#{s2}"

puts "HAT:"
puts "#{s3}"


# b.tune g, "- #{s4.to_s}"

b.tune g, s4.to_s
b.tune g2, s4.to_s

# b.tune g2, " 1 1 1 1 #{s5} 1 1 #{s7} 1 1 #{s5} 1 1"
# # b.tune g, "- 1 1 1 1 1 1 1 1 #{s7} 1 1 1 1  1 1"
# # b.tune g, "+ 1 1 1 1 #{s5} 1 1 #{s7} 1 1 #{s5} 1 1"
# b.tune g2, "+ + 1 1 1 1 #{s5} 1 1 #{s7} 1 1 #{s5} 1 1"


b.tune hat2, "1 1 1 1 #{s0}"

b.tune g, <<-Q
- #{s6}
Q

b.tune g, <<-Q
- - #{s6}
Q

b.tune snare, <<-Q
  #{s1}
Q

b.tune base, <<-Q
  #{s2}
Q

b.tune hat, <<-Q
  #{s3}
Q

while true do
  b.play
  sleep 0.01 while not b.stopped?
end