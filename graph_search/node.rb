require 'set'

class Node
  # @param [String] name cannot be nil
  def initialize(name = 'Default node')
    @adjacent = Set.new
    @name = name
  end

  attr_accessor :adjacent

  def to_s
    @name.to_s
  end
end