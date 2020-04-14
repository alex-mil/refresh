class BinarySearchTree
  def initialize
    @size = 0
    # @type [Array<Fixnum, Float, NilClass>]
    @nodes = []
  end

  # @return [Fixnum]
  def height
    calculate_height
  end

  # @param [Fixnum, Float] value
  def insert(value)
    if empty?
      @nodes.push value
      @size += 1
      return
    end

    index = 0
    loop do
      # out of bounds
      if @nodes.length < index
        # push empty values to fill children of leaf nodes
        (index - @nodes.length).times { @nodes.push nil }
        @nodes.push value
        break
      end

      if @nodes[index].nil?
        @nodes[index] = value
        break
      end

      index = value < @nodes[index] ? left_child_index(index) : right_child_index(index)
    end
  end

  # @param [Fixnum, Float] value
  # @return [FalseClass,TrueClass]
  def remove(value)
    index = search value
    if remove_by_index index
      @size -= 1
      true
    end
    false
  end

  # @param [Fixnum, Float] value
  # @return [FalseClass, TrueClass]
  def contains?(value)
    return true if search value

    false
  end

  # @param [Fixnum] index
  # @param [Proc] block
  # @yieldparam [Fixnum, Float]
  def traverse_in_order(index = 0, &block)
    return unless @nodes.at(index)

    traverse_in_order left_child_index(index), &block
    yield @nodes[index]
    traverse_in_order right_child_index(index), &block
  end

  private

  # @param [Fixnum] index
  # @return [Fixnum]
  def left_child_index(index)
    2 * index + 1
  end

  # @param [Fixnum] index
  # @return [Fixnum]
  def right_child_index(index)
    2 * index + 2
  end

  # @return [TrueClass, FalseClass]
  def empty?
    @size.zero?
  end

  # @param [Fixnum] index
  # @return [Fixnum]
  def calculate_height(index = 0)
    return 0 unless @nodes[index]

    left = left_child_index index
    right = right_child_index index
    Math.max(calculate_height(left), calculate_height(right)) + 1
  end

  # @param [Fixnum, Float] value
  # @param [Fixnum] index
  # @return [Fixnum, NilClass] index of a node if found
  def search(value, index = 0)
    return nil unless @nodes.at index

    return index if @nodes[index] == value

    value < @nodes[index] ? search(value, left_child_index(index)) : search(value, right_child_index(index))
  end

  # @param [Fixnum] index cannot be nil
  # @return [FalseClass, TrueClass]
  def leaf_node?(index)
    no_left_child = @nodes.at(left_child_index(index)).nil?
    no_right_child = @nodes.at(right_child_index(index)).nil?
    no_left_child && no_right_child
  end

  # @param [Fixnum] index cannot be nil
  # @return [FalseClass, TrueClass]
  def has_left_sub_tree?(index)
    !@nodes.at(left_child_index(index)).nil?
  end

  # @param [Fixnum] index cannot be nil
  # @return [FalseClass, TrueClass]
  def has_right_sub_tree?(index)
    !@nodes.at(right_child_index(index)).nil?
  end

  # @param [Fixnum] i source index
  # @param [Fixnum] j destination index
  def swap(i, j)
    temp = @nodes[i]
    @nodes[i] = @nodes[j]
    @nodes[j] = temp
  end

  # @param [Fixnum] index
  # @return [Fixnum] index of a node
  def search_smallest_node(index)
    return index unless @nodes.at left_child_index index

    search_smallest_node left_child_index index
  end

  # @param [Fixnum] index cannot be nil
  # @return [FalseClass, TrueClass]
  def remove_by_index(index)
    if leaf_node? index
      @nodes[index] = nil
      return true
    elsif has_left_sub_tree?(index) && has_right_sub_tree?(index)
      smallest_idx = search_smallest_node right_child_index index
      swap index, smallest_idx
      remove_by_index smallest_idx
      return true
    elsif has_left_sub_tree? index
      left_idx = left_child_index(index)
      swap(index, left_idx)
      remove_by_index left_idx
      return true
    elsif has_right_sub_tree? index
      right_idx = right_child_index(index)
      swap(index, right_idx)
      remove_by_index right_idx
      return true
    end
    false
  end
end

# @param [BinarySearchTree] tree
def print_tree(tree)
  print 'In order: '
  tree.traverse_in_order do |data|
    print "#{data} "
  end
  puts
end

bst = BinarySearchTree.new
bst.insert 5
bst.insert 2
bst.insert 20
bst.insert -5
bst.insert -3
bst.insert 10
bst.insert 30
bst.insert 8
bst.insert 12
bst.insert 25
bst.insert 35
bst.insert 6
bst.insert 22
bst.insert 7
bst.insert -10
print_tree bst
puts "\nRemove 7 ==> #{bst.remove 7}"
print_tree bst
puts "\nRemove 2 ==> #{bst.remove 2}"
print_tree bst
puts "\nRemove 20 ==> #{bst.remove 20}"
print_tree bst
puts "\nRemove 22 ==> #{bst.remove 22}"
print_tree bst
puts "\nRemove 25 ==> #{bst.remove 25}"
print_tree bst