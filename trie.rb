class Node
  def initialize(value)
    @value = value
    @children = {} # {char => Node}
    @is_word = false
  end

  attr_reader :value, :children

  def end_of_word?
    @is_word
  end

  def end_of_word!
    @is_word = true
  end
end

class Trie
  def initialize
    @root = Node.new('*')
  end

  def add_word(value)
    base = @root
    value.each_char { |chr| base = add_character chr, base.children }
    base.end_of_word!
  end

  def include?(word)
    find_word(word) { |found, base| return found }
  end

  private

  def add_character(chr, trie)
    trie[chr] || Node.new(chr).tap { |new_node| trie[chr] = new_node }
  end

  def find_word(value)
    base = @root
    found = value.chars.all? { |chr| base = base.children[chr] }

    yield found, base if block_given?

    base
  end
end

trie = Trie.new
trie.add_word 'car'
trie.add_word 'card'
trie.add_word 'cards'
trie.add_word 'call'
trie.add_word 'trie'
trie.add_word 'tried'
trie.add_word 'tries'
trie.add_word 'try'

p trie.include? 'card'
p trie.include? 'calp'
