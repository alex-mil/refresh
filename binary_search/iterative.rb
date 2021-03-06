# @param [Array<Integer>] list
# @param [Integer] num
def binary_search(list, num)
  left_index = 0
  right_index = list.length - 1

  while left_index <= right_index do
    # a nit trick to prevent Integer overflow
    middle_index = left_index + ((right_index - left_index) / 2)
    return true if num == list[middle_index]

    if num > list[middle_index]
      left_index = middle_index + 1
    else
      right_index = middle_index - 1
    end
  end
  false
end

# @param [Array<Integer>] list
# @param [Integer] num
def list_includes_number?(list, num)
  binary_search list, num
end

a = [1, 3, 4, 5, 13, 20, 25, 40, 42, 44, 53]
p list_includes_number? a, 20