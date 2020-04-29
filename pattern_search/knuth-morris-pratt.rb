# @param [String] pattern
# @return [Array<Fixnum>]
# @example pattern: "abcabd", dfa: [0, 0, 0, 1, 2, 0]
def build_dfa(pattern)
  dfa = [0] # deterministic finite state automation
  j = 0
  i = 1
  while i < pattern.length do
    if pattern[i] == pattern[j]
      dfa[i] = j + 1
      i += 1
      j += 1
    elsif j == 0 # pattern[i]!=pattern[j]
      dfa[i] = 0
      i += 1
    else # pattern[i]!=pattern[j] AND j!=0
      j = dfa[j - 1]
    end
  end
  dfa
end

# @param [String] pattern
# @param [String] txt
# @return [TrueClass, FalseClass]
# @example txt: "abcabeabcabcabd", pattern: "abcabd"
def substring?(txt, pattern)
  dfa = build_dfa pattern
  i = 0
  j = 0
  while i < txt.length do
    if txt[i] == pattern[j]
      i += 1
      j += 1
      return true if j == pattern.length
    elsif j == 0 # txt[i]!=pattern[j]
      i += 1
      return false if i == txt.length
    else # txt[i]!=pattern[j] AND j!=0
      j = dfa[j - 1]
    end
  end
end

# O(n + m) where n is pattern length and m is txt length

puts "Substring? #{substring? "abcabeabcabcabd", "abcabd"}"