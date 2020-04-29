class RabinKarpSearch
  def initialize
    @prime = 101
  end

  # @param [String] text
  # @param [String] pattern
  # @return [Fixnum] start index of the pattern or -1
  def pattern_search(text, pattern)
    p_len = pattern.length
    t_len = text.length
    p_hash = make_hash pattern, p_len - 1
    t_hash = make_hash text, p_len - 1
    1.upto(t_len - p_len + 1) do |i|
      if p_hash == t_hash && equal?(text, i - 1, i + p_len - 2, pattern, 0, p_len - 1)
        return i - 1
      end

      if i < t_len - p_len + 1
        t_hash = recalculate_hash text, i - 1, i + p_len - 1, t_hash, p_len
      end
    end
    -1
  end

  private

  # @param [String] str
  # @param [Fixnum] to
  # @return [Fixnum]
  def make_hash(str, to)
    hash = 0
    0.upto(to) do |i|
      hash += str[i].bytes.pop * @prime ** i
    end
    hash
  end

  # @param [String] txt1
  # @param [Fixnum] start1
  # @param [Fixnum] end1
  # @param [String] txt2
  # @param [Fixnum] start2
  # @param [Fixnum] end2
  # @return [TrueClass, FalseClass]
  def equal?(txt1, start1, end1, txt2, start2, end2)
    return false if end1 - start1 != end2 - start2

    while start1 <= end1 && start2 <= end2 do
      return false if txt1[start1] != txt2[start2]

      start1 += 1
      start2 += 1
    end
    true
  end

  # @param [String] txt
  # @param [Fixnum] old_idx
  # @param [Fixnum] new_idx
  # @param [Fixnum] old_hash
  # @param [Fixnum] pattern_len
  # @return [Fixnum]
  def recalculate_hash(txt, old_idx, new_idx, old_hash, pattern_len)
    new_hash = old_hash - txt[old_idx].bytes.pop
    new_hash = new_hash / @prime
    new_hash + txt[new_idx].bytes.pop * @prime ** (pattern_len - 1)
  end
end

# O(n + m) - average and best cases
# O(n * m) - worst case
rks = RabinKarpSearch.new
puts rks.pattern_search "RabinKarpAlgorithm", "arpAlgo"
puts rks.pattern_search "RabinKarpAlgorithm", "Karp"
puts rks.pattern_search "RabinKarpAlgorithm", "rithm"
puts rks.pattern_search "RabinKarpAlgorithm", "binn"
puts rks.pattern_search "RabinKarpAlgorithm", "abi"