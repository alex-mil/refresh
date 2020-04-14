require_relative 'node'

class Graph
  # @param [Node] node_a
  # @param [Node] node_b
  def add_edge(node_a, node_b)
    node_a.adjacent << node_b
    node_b.adjacent << node_a
  end
end