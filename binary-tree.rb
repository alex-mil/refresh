class Node
  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def data
    @data.to_s
  end

  def insert(value)
    if value <= @data
      if @left_child.nil?
        @left_child = Node.new value
        return
      end
      @left_child.insert value
    else
      if @right_child.nil?
        @right_child = Node.new value
        return
      end
      @right_child.insert value
    end
  end

  def contains?(value)
    return true if value == @data

    if value < @data
      return false if @left_child.nil?

      return @left_child.contains? value
    end

    return false if @right_child.nil?

    return @right_child.contains? value
  end

  def print_in_order
    @left_child.print_in_order unless @left_child.nil?
    print "#{data} "
    @right_child.print_in_order unless @right_child.nil?
  end

  def print_pre_order
    print "#{data} "
    @left_child.print_in_order unless @left_child.nil?
    @right_child.print_in_order unless @right_child.nil?
  end

  def print_post_order
    @left_child.print_in_order unless @left_child.nil?
    @right_child.print_in_order unless @right_child.nil?
    print "#{data} "
  end

  def debug
    "#{@left_child.data} <- #{data} -> #{@right_child.data}"
  end
end

tree_root = Node.new 10
tree_root.insert 5
tree_root.insert 15
tree_root.insert 8
tree_root.insert 12
tree_root.print_in_order
