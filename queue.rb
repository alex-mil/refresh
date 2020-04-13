=begin
This implementation uses a linked list
=end

class Node
  def initialize(data)
    @data = data
  end

  attr_accessor :next
  attr_reader :data
end

class Queue
  def initialize
    @head = nil
    @tail = nil
  end

  def is_empty?
    @head.nil? && @tail.nil?
  end

  def peek
    return 'None' if @head.nil?

    @head.data
  end

  def add(data)
    node = Node.new data
    if @head.nil? && @tail.nil?
      @head = node
      @tail = node
    else
      @tail.next = node
      @tail = node
    end
  end

  def remove
    raise 'ERROR: the queue is empty' if @head.nil? && @tail.nil?

    removed_data = @head.data
    @head = @head.next
    @tail = nil if @head.nil?
    removed_data
  end
end

q = Queue.new
puts "The queue is empty? #{q.is_empty?}"
puts "Data at the queue start: #{q.peek}"
q.add 'h'
q.add 'e'
q.add 'l'
q.add 'l'
q.add 'o'
puts q.remove
puts q.remove
puts q.remove
puts q.remove
puts q.remove
