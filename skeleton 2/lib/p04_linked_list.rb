class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |node|
      next if node.val.nil?
      return node.val if node.key == key
    end
  end

  def include?(key)
    each do |node|
      next if node.key.nil?
      return true if node.key == key
    end

    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = last
    last.next = new_node
    @tail.prev = new_node
    new_node.next = @tail
  end

  def update(key, val)
    return nil if empty?
    each{ |node| node.val = val if node.key == key}
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.next.prev = node.prev
        node.prev.next = node.next
        node.key = nil
        node.val = nil
      end
    end
  end

  def each
    node = first

    until node == @tail
      yield(node)
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
