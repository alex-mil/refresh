class Stack
  def initialize
    @list = []
  end

  def is_empty?
    @list.length.zero?
  end

  def peek
    return 'None' if is_empty?

    last_index = @list.length - 1
    @list[last_index]
  end

  def push(data)
    @list << data
  end

  def pop
    raise 'ERROR: the stack is empty' if is_empty?

    @list.pop
  end
end

stack = Stack.new
puts "The stack is empty? #{stack.is_empty?}"
puts "Peek at the top: #{stack.peek}"
(100..110).each { |n| stack.push n }
begin
  loop { puts stack.pop }
rescue StandardError => e
  puts e.message
end
