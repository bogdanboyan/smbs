class Shortener
  
  class << self
  
    def get_random_code(length)
      chars, rval = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a, ''
      1.upto(length) {|i| rval << chars[rand(chars.size - 1)]}
    
      rval
    end
  
    def get_basemade_value(i)
      sixtytwo, value = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a, ''
  
      while i > 0
        i,r = i.divmod(62)
        value = (sixtytwo[r]) + value
      end
    
      value
    end
  
  end # end class << self
end # end class