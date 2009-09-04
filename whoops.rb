module Whoops
  class Beat
    attr_accessor :duration, :pitch
    
    def initialize(d, p)
      @duration = d
      @pitch    = p
    end
    
    def generate
      # deal with octave?
      "#{duration}#{pitch}"
    end
    
    def quarter_note_value
      4 / duration.to_f
    end
  end
  
  class Sequence
    attr_accessor :target_length, :beats
    
    def initialize(opts)
      @target_length  = opts[:target_length]
      @beats          = []
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
      current_length < target_length
    end
    
    def close
      silent_duration = target_length - current_length
      self.append_beat(Beat.new( silent_duration.to_i * 4, nil ))
    end
  end
end