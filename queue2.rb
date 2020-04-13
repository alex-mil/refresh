=begin
This implementation uses a cyclic array
=end

class Queue
  def initialize
    @capacity = 10
    @size = 0
    @read_index = 0
    @write_index = 0
    @list = Array.new(@capacity)
  end

  def is_empty?
    @size.zero?
  end

  def peek
    return 'None' if is_empty?

    @list[@start]
  end

  def add(data)
    increase_capacity if @size == @capacity

    @list[@write_index] = data
    puts "Index: #{@write_index}, Queue: #{@list.inspect}"
    @size += 1
    @write_index += 1
    @write_index = @write_index % @capacity if @write_index >= @capacity && @read_index > 0
  end

  def remove
    raise 'ERROR: the queue is empty' if is_empty?

    removed_data = @list[@read_index]
    @read_index = (@read_index + 1) % @capacity
    @size -= 1
    removed_data
  end

  private

  def increase_capacity
    new_list = Array.new @capacity * 2
    i = 0
    (@read_index...@size).each do |idx|
      new_list[i] = @list[idx]
      i += 1
    end
    if @write_index <= @read_index
      (0...@write_index).each do |idx|
        new_list[i] = @list[idx]
        i += 1
      end
    end
    @list = new_list
    @capacity *= 2
    @write_index = i
  end
end

q = Queue.new
puts "The queue is empty? #{q.is_empty?}"
puts "Data at the queue start: #{q.peek}"
'hello world!'.each_char { |ch| q.add ch }
begin
  loop { puts q.remove }
rescue StandardError => e
  puts e.message
end
