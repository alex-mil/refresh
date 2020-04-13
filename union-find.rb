class UnionFind
  attr_reader :nodes

  def initialize(number_of_nodes)
    @nodes = []
    @tree_heights = []

    number_of_nodes.times do |i|
      @nodes[i] = i # points to itself
      @tree_heights[i] = 1
    end
  end

  def root_of(i)
    parent_of_parent_of_i = nil
    # Loop up the chain until reaching root
    while @nodes[i] != i do
      # path compression for future lookups
      parent_of_parent_of_i = @nodes[@nodes[i]]
      @nodes[i] = parent_of_parent_of_i
      i = parent_of_parent_of_i
    end
    i
  end

  def union(n1, n2)
    root_of_n1 = root_of n1
    root_of_n2 = root_of n2
    # already connected
    return if root_of_n1 == root_of_n2

    # join subtrees by replacing root of smaller to root of larger
    if size_of_subtree(n1) < size_of_subtree(n2)
      @nodes[root_of_n1] = root_of_n2
      increase_subtree_size root_of_n2, root_of_n1
    else
      @nodes[root_of_n2] = root_of_n1
      increase_subtree_size root_of_n1, root_of_n2
    end
  end

  def connected?(n1, n2)
    root_of(n1) == root_of(n2)
  end

  private

  def size_of_subtree(node)
    @tree_heights[node]
  end

  def increase_subtree_size(dest, source)
    @tree_heights[dest] += @tree_heights[source]
  end
end

uf = UnionFind.new 10
p uf.nodes
p "1 and 4 connected? <- #{uf.connected? 1, 4}"
uf.union 1, 2
p uf.nodes
uf.union 2, 3
p uf.nodes
uf.union 3, 4
p uf.nodes
p "1 and 4 connected? <- #{uf.connected? 1, 4}"
