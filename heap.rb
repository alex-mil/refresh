class MinHeap
  def initialize
    @capacity = 10
    @size = 0
    @items = Array.new(@capacity)
  end

  def insert(value)
    if @size.zero?
      @items[0] = value
      @size += 1
      return
    end
    increase_capacity if @size == @capacity
    @items[@size] = value
    @size += 1
    heapify_up
  end

  def poll
    raise StandardError, 'ERROR: the heap is empty' if @size.zero?

    @items[0] = @items[last_index]
    @items[last_index] = nil
    @size -= 1
    heapify_down
  end

  def peek
    raise StandardError, 'ERROR: the heap is empty' if @size.zero?

    @items[0]
  end

  def print_debug
    puts "Capacity: #{@capacity}, Size: #{@size}, List: #{@items.inspect}"
  end

  private

  def left_child_index(idx)
    2 * idx + 1
  end

  def right_child_index(idx)
    2 * idx + 2
  end

  def parent_index(idx)
    (idx - 1) / 2
  end

  def has_left_child?(idx)
    left_child_index(idx) < @size
  end

  def has_right_child?(idx)
    right_child_index(idx) < @size
  end

  def has_parent?(idx)
    parent_index(idx) >= 0
  end

  def left_child(idx)
    @items[left_child_index(idx)]
  end

  def right_child(idx)
    @items[right_child_index(idx)]
  end

  def parent(idx)
    @items[parent_index(idx)]
  end

  def increase_capacity
    @capacity *= 2
    buffer = Array.new(@capacity)
    @items.each_with_index { |x, idx| buffer[idx] = x }
    @items = buffer
  end

  def last_index
    @size - 1
  end

  def heapify_up(idx = last_index)
    return unless has_parent? idx

    return if @items[idx] > parent(idx)

    swap idx, parent_index(idx)
    heapify_up parent_index(idx)
  end

  def heapify_down(idx = 0)
    while has_left_child?(idx)
      smaller_child_index = left_child_index(idx)
      if has_right_child?(idx) && right_child(idx) < left_child(idx)
        smaller_child_index = right_child_index(idx)
      end

      if @items[idx] < @items[smaller_child_index]
        break
      else
        swap idx, smaller_child_index
      end
      idx = smaller_child_index
    end
  end

  def swap(first_idx, second_idx)
    temp = @items[first_idx]
    @items[first_idx] = @items[second_idx]
    @items[second_idx] = temp
  end
end

heap = MinHeap.new
heap.insert 2
heap.insert 4
heap.insert 8
heap.insert 9
heap.insert 7
heap.insert 10
heap.insert 9
heap.insert 15
heap.insert 20
heap.insert 13
heap.insert 9
heap.insert 14
heap.insert 20
heap.insert 11
heap.insert 19
heap.insert 20
heap.insert 17
heap.insert 3
heap.print_debug
begin
  loop do
    heap.poll
    heap.print_debug
  end
rescue StandardError => e
  puts e.message
end
