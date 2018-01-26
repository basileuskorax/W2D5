class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = self.length
    return sum if sum == 0
    self[0...-1].each_with_index do |el, i|
      sum += ((el.to_i ^ 31).abs)**(Math.sin(self[i+1]) + 10)
    end

    sum.to_i
  end
end

class String
  def hash
    str_arr = self.chars

    int_arr = str_arr.map {|el| el.ord }

    int_arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted_arr = self.to_a.sort_by {|el| el.first.to_s}

    int_arr = sorted_arr.flatten.map do |el|
      if el.is_a?(Symbol)
        el.to_s.hash
      else
        el.hash
      end
    end

    int_arr.hash
  end
end
