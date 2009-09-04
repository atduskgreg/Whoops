module Whoops
  class Beat
    attr_accessor :duration, :pitch
  end
  
  class Sequence
    attr_accessor :current_length, :target_length, :beats
    
    def <<(beat)
      if room_for?(beat)
        append_beat(beat)
      else
        close
      end
    end
    
    def append_beat(beat)
      beats << beat
    end
    
    def room_for?(beat)
      # current_length + beat.duration <= target_length
    end
    
    def open?
      # current_length < target_legnth
    end
    
    def close
      # silent_duration = target_length - current_length
      # self.append_beat(Beat.new( :duration => silent_duration, :pitch => nil ))
    end
    
    
    
  end
end