require_relative 'graph'
require_relative 'node'
require 'thread'

class BreadthFirstSearch
  # @param [Graph] graph
  def initialize(graph)
    @graph = graph
    @visited = Set.new
    @queue = Queue.new
  end

  # @param [Node] source
  # @param [Node] destination
  # @return [TrueClass, FalseClass]
  def has_path_between?(source, destination)
    @queue.clear
    @visited.clear
    connected? source, destination
  end

  private

  # @param [Node] source
  # @param [Node] destination
  # @return [Boolean]
  def connected?(source, destination)
    return true if source == destination

    @visited.add source.to_s
    source.adjacent.each do |node|
      @queue.enq node unless @visited.include? node.to_s
    end
    return false if @queue.empty?

    return true if connected? @queue.deq, destination

    false
  end
end