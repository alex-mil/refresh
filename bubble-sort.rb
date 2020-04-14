# @param [Array<Fixnum, Float>] list
# @return [Array<Fixnum, Float>]
def bubble_sort(list)
  sorted = false
  last_unsorted = list.length - 1
  until sorted do
    sorted = true
    (0...last_unsorted).each do |i|
      if list[i] > list[i + 1]
        begin # swap
          temp = list[i]
          list[i] = list[i + 1]
          list[i + 1] = temp
        end
        sorted = false
      end
    end
    last_unsorted -= 1
  end
  list
end

arr = [10, 3, 5, 12, 9, 20]
puts bubble_sort(arr).inspect