class BinarySearchTree
  class Node
    # @param [Numeric] data
    def initialize(data)
      @left_child = nil
      @right_child = nil
      @parent = nil
      @data = data
    end

    # @return [BinarySearchTree::Node]
    attr_accessor :left_child, :right_child, :parent
    # @return [Numeric]
    attr_accessor :data

    # @param [Numeric] value
    def insert(value)
      if value <= @data
        if @left_child.nil?
          @left_child = Node.new(value)
          @left_child.parent = self
        else
          @left_child.insert(value)
        end
      else
        if @right_child.nil?
          @right_child = Node.new(value)
          @right_child.parent = self
        else
          @right_child.insert(value)
        end
      end
    end
  end

  def initialize
    @size = 0
    @root = nil
  end

  # @param [Numeric] value
  def insert(value)
    if @root.nil?
      @root = Node.new value
      @size += 1
    else
      @root.insert value
      @size += 1
    end
  end

  # @param [Numeric] value
  # @return [FalseClass, TrueClass]
  def remove(value)
    node = search value

    if node == @root
      @root = nil
      @size -= 1
      return true
    end

    if leaf? node
      if node&.parent&.left_child == node
        node&.parent&.left_child = nil
      elsif node&.parent&.right_child == node
        node&.parent&.right_child = nil
      end

      @size -= 1
      return true
    end

    if with_left_child_only? node
      if node&.parent&.left_child == node
        node&.parent&.left_child = node&.left_child
      end

      if node&.parent&.right_child == node
        node&.parent&.right_child = node&.left_child
      end

      @size -= 1
      return true
    end

    if with_right_child_only? node
      if node&.parent&.left_child == node
        node&.parent&.left_child = node&.right_child
      end

      if node&.parent&.right_child == node
        node&.parent&.right_child = node&.right_child
      end
      @size -= 1
      return true
    end

    if with_both_children? node
      smallest_node = search_smallest_node node&.right_child
      node&.data = smallest_node.data
      @size -= 1
      return remove_node smallest_node
    end

    false
  end

  # @param [Numeric] value
  # @return [FalseClass, TrueClass]
  def contains?(value)
    return true if search value

    false
  end

  # @param [BinarySearchTree::Node] node
  # @yieldparam [BinarySearchTree::Node]
  def traverse_in_order(node = @root, &block)
    return if node.nil?

    traverse_in_order node.left_child, &block
    yield node
    traverse_in_order node.right_child, &block
  end

  private

  # @param [Numeric] value
  # @param [BinarySearchTree::Node] node
  # @return [BinarySearchTree::Node]
  def search(value, node = @root)
    return nil if node.nil?

    return node if node.data == value

    value < node.data ? search(value, node.left_child) : search(value, node.right_child)
  end

  # @param [BinarySearchTree::Node] node
  # @return [BinarySearchTree::Node]
  def search_smallest_node(node = @root)
    return node if node&.left_child.nil?

    search_smallest_node node&.left_child
  end

  # @param [BinarySearchTree::Node] node
  # @return [FalseClass, TrueClass]
  def remove_node(node)
    return false if node.nil?

    if leaf? node
      node.parent.left_child = nil if node.parent.left_child == node
      node.parent.right_child = nil if node.parent.right_child == node
      return true
    end

    node.parent.right_child = node.right_child
    true
  end

  # @param [BinarySearchTree::Node] node
  # @return [TrueClass, FalseClass]
  def leaf?(node = @root)
    node&.left_child.nil? && node&.right_child.nil?
  end

  # @param [BinarySearchTree::Node] node
  def with_left_child_only?(node = @root)
    !node&.left_child.nil? && node&.right_child.nil?
  end

  # @param [BinarySearchTree::Node] node
  def with_right_child_only?(node = @root)
    node&.left_child.nil? && !node&.right_child.nil?
  end

  # @param [BinarySearchTree::Node] node
  def with_both_children?(node = @root)
    !node&.left_child.nil? && !node&.right_child.nil?
  end
end

# @param [BinarySearchTree] tree
def print_tree(tree)
  print 'In order: '
  tree.traverse_in_order do |node|
    print "#{node.data} "
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