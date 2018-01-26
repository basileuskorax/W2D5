require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    num = el.hash
    unless self.include?(num)
      if @count == num_buckets
        resize!
      end
      self[num] << el #
      @count += 1
    end
  end

  def remove(el)
    num = el.hash
    if self.include?(el)
      self[num].delete(el)
      @count -= 1
    end
  end

  def include?(el)
    num = el.hash
    self[num].include?(el)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_arr = []
    @store.flatten.each do |int|
      self.remove(int)
      temp_arr << int
    end
    @store += Array.new(num_buckets) { Array.new }
    temp_arr.each {|int| self.insert(int)}
  end
end
