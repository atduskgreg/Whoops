module Whoops
  class Beat
    PITCHES   = %W{C C# D D# E F F# G G# A A# B B#}
    DURATIONS = [1, 2, 3, 4, 9, 8]
    
    attr_accessor :duration, :pitch
    
    def initialize(d, p)
      @duration = d
      @pitch    = p
    end
    
    def generate
      # deal with octave?
      "#{duration}#{pitch || " "}"
    end
    
    def quarter_note_value
      4 / duration.to_f
    end
  end
  
  class Sequence
    attr_accessor :target_length, :beats, :closed
    
    # Sequence.generate :pitches => ["A", "B"],
    #                   :durations => [1, 3, 4],
    #                   :length => 64
    def self.generate(opts)
      sequence = Sequence.new :target_length => opts[:length]
      pitches = opts[:pitches] || Beat::PITCHES
      durations = opts[:durations] || Beat::DURATIONS

      while sequence.open?
        beat = Beat.new pick_from( durations ), pick_from( pitches )
        sequence << beat
      end
      
      sequence
    end
    
    def self.pick_from(list)
      list[rand(list.length)]
    end
    
    def initialize(opts)
      @target_length  = opts[:target_length]
      @beats          = []
    end
    
    def to_s
      result = ""
      beats.each{|b| result << "#{b.generate} "}
      result
    end
    
    def <<(beat)
      if room_for?(beat)
        append_beat(beat)
      else
        close
      end
      self
    end
    
    def append_beat(beat)
      beats << beat
    end
    
    def current_length
      result = 0
      beats.each{|b| result += b.quarter_note_value }
      result
    end
    
    def room_for?(beat)
      current_length + beat.quarter_note_value <= target_length
    end
    
    def open?
      !@closed
    end
    
    def close
      @closed = true
    end
  end
end