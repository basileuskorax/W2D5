require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :max, :store, :map
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map.get(key)
      value = node.val
      update_node!(key)
      value
    else
      if count >= @max
        eject!
      end
      value = calc!(key)
      @store.append(key, value)
      i = @max - 1
      node = @store[i]
      @map.set(key, node)
      # if count > @max
      #   eject!
      # end
      value
    end

  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  # private

  def calc!(key)
    @prc.call(key)
  end

  def update_node!(key)
    value = @store.get(key)
    @store.remove(key)
    @store.append(key, value)
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end
end
