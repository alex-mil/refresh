class ListNode
  def initialize(data = nil)
    @data = data
  end

  attr_accessor :next, :prev

  def to_s
    @data.to_s
  end

  def debug
    "#{@prev.to_s} <- #{to_s} -> #{@next.to_s}"
  end
end

class LinkedList
  def initialize
    @dummy_head = ListNode.new
    @dummy_tail = ListNode.new
    @size = 0
  end

  attr_reader :size

  def head
    @dummy_head.next
  end

  def tail
    @dummy_tail.prev
  end

  def append(data)
    node = ListNode.new data
    if @size.zero?
      node.next = @dummy_tail
      node.prev = @dummy_head
      @dummy_head.next = node
      @dummy_tail.prev = node
    else
      node.next = @dummy_tail
      node.prev = tail
      @dummy_tail.prev.next = node
      @dummy_tail.prev = node
    end
    @size += 1
  end

  def prepend(data)
    node = ListNode.new data
    if @size.zero?
      node.next = @dummy_tail
      node.prev = @dummy_head
      @dummy_head.next = node
      @dummy_tail.prev = node
    else
      node.next = head
      node.prev = @dummy_head
      @dummy_head.next.prev = node
      @dummy_head.next = node
    end
    @size += 1
  end

  def insert_at(position, data)
    if position < 0 || position >= @size
      raise 'ERROR: index out of range'
    end

    node = ListNode.new data
    if position < (@size - position)
      current = head
      while position > 0
        current = current.next
        position -= 1
      end
    else
      current = tail
      while position < @size - 1
        current = current.prev
        position += 1
      end
    end
    node.next = current
    node.prev = current.prev
    current.prev.next = node
    current.prev = node
  end

  def to_s
    arr = []
    current = head
    while current
      arr << current.to_s
      current = current.next
    end
    arr.join
  end
end

list = LinkedList.new
list.append 'l'
list.append 'o'
list.prepend 'e'
list.prepend 'h'
list.insert_at 3, 'l'
list.append '!'
print list.to_s