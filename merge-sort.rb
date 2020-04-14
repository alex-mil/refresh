# O(n*log(n)) time
# O(n) space

# @param [Array<Fixnum>] left_array
# @param [Array<Fixnum>] right_array
def merge(left_array, right_array)
  sorted = []
  left_offset = 0
  right_offset = 0
  while left_offset < left_array.size && right_offset < right_array.size
    lhs = left_array[left_offset]
    rhs = right_array[right_offset]
    if lhs <= rhs
      sorted << lhs
      left_offset += 1
    else
      sorted << rhs
      right_offset += 1
    end
  end

  # There is at least one element left in either left_array or right_array (not both)
  while left_offset < left_array.size
    sorted << left_array[left_offset]
    left_offset += 1
  end

  while right_offset < right_array.size
    sorted << right_array[right_offset]
    right_offset += 1
  end

  sorted
end

# @param [Array<Fixnum>] array
def merge_sort(array)
  return array if array.size <= 1

  mid = array.size / 2
  # @type [Array<Fixnum>]
  left_sub_array = array[0...mid]
  # @type [Array<Fixnum>]
  right_sub_array = array[mid...array.size]
  merge merge_sort(left_sub_array), merge_sort(right_sub_array)
end

arr = [10, 5, 2, 7, 4, 9, 12, 1, 8, 6, 11, 3]
p merge_sort arr
