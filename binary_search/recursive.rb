# @param [Array<Integer>] list
# @param [Integer] num
# @param [Integer] left_index
# @param [Integer] right_index
def binary_search(list, num, left_index, right_index)
  return false if left_index > right_index

  # a nit trick to prevent Integer overflow
  middle_index = left_index + ((right_index - left_index) / 2)
  return true if num == list[middle_index]

  if num > list[middle_index]
    binary_search list, num, middle_index + 1, right_index
  else
    binary_search list, num, left_index, middle_index - 1
  end
end

# @param [Array<Integer>] list
# @param [Integer] num
def list_includes_number?(list, num)
  binary_search list, num, 0, list.length - 1
end

a = [1, 3, 4, 5, 13, 20, 25, 40, 42, 44, 53]
p list_includes_number? a, 25