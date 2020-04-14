require_relative 'graph'
require_relative 'node'

class DepthFirstSearch
  # @param [Graph] graph
  def initialize(graph)
    @graph = graph
    @visited = Set.new
  end

  # @param [Node] source
  # @param [Node] destination
  # @return [TrueClass, FalseClass]
  def has_path_between?(source, destination)
    @visited.clear
    connected? source, destination
  end

  private

  # @param [Node] source
  # @param [Node] destination
  # @return [Boolean]
  def connected?(source, destination)
    return false if @visited.include? source.to_s

    @visited.add source.to_s

    return true if source == destination

    source.adjacent.each { |node| return true if connected? node, destination }

    false
  end
end