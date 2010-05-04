class Shortener
  
  def self.get_random_code(length)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    rval = String.new
    1.upto(length) {|i| rval << chars[rand(chars.size - 1)]}
    return rval
  end
  
  def self.get_basemade_value(i)
    sixtytwo = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
    tmps = String.new
    while i > 0
      i,r = i.divmod(62)
      tmps = (sixtytwo[r]) + tmps
    end
    return tmps
  end
end