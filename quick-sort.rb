# O(n*log(n)) time on average
# O(n^2) time in worst case

# @param [Array<Fixnum>] array
# @param [Fixnum] i
# @param [Fixnum] j
def swap(array, i, j)
  return if i == j

  temp = array[i]
  array[i] = array[j]
  array[j] = temp
end

def quick_sort(array, from = 0, to = nil)
  to = array.size - 1 unless to
  length = to - from + 1

  return if from >= to # done sorting
  return if length == 2 && array[from] <= array[to] # done sorting

  pivot_idx = from + (length / 2)
  pivot = array[pivot_idx]
  swap array, pivot_idx, to
  left_idx = from
  right_idx = to

  while left_idx < right_idx
    if array[left_idx] > pivot && array[right_idx] < pivot
      swap array, left_idx, right_idx
      left_idx += 1
    elsif array[left_idx] > pivot
      right_idx -= 1
    elsif array[right_idx] < pivot
      left_idx += 1
    else
      left_idx += 1
    end
  end
  swap array, left_idx, to
  quick_sort array, from, left_idx
  quick_sort array, left_idx + 1, to
end

arr = [15, 3, 2, 1, 9, 5, 7, 8, 6]
quick_sort arr
p arr

arr = [2, 6, 5, 3, 8, 7, 1, 0]
quick_sort arr
p arr