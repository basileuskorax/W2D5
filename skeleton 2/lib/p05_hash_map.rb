require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.each do |bucket|
      return true if bucket.include?(key)
    end
    false
  end

  def set(key, val)
    bucket_list = @store[bucket(key)]
    if bucket_list.include?(key)
      bucket_list.update(key, val)
    else
      resize! if @count >= @store.length
      bucket_list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket_list = @store[bucket(key)]
    bucket_list.get(key)
  end

  def delete(key)
    @store.each do |bucket|
      if bucket.include?(key)
        bucket.remove(key)
        @count -= 1
      end
    end
    # nil
  end

  def each
    @store.each do |bucket|
      unless bucket.empty?
        bucket.each do |node|
          yield(node.key, node.val)
        end
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_arr = []
    each do |key, value|
      temp_arr << [key, value]
      delete(key)
    end
    @store += Array.new(num_buckets) { LinkedList.new }
    temp_arr.each {|array| self.set(array.first, array.last)}
  end

  def bucket(key)
    hashed = key.hash
    hashed % num_buckets
  end
end
