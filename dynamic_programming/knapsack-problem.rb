class WeightValue
  # @param [Fixnum] value
  # @param [Fixnum] weight
  def initialize(value:, weight:)
    @value = value
    @weight = weight
  end

  attr_reader :weight, :value
end

# @param [Fixnum] available_weight
# @param [Array<WeightValue>] items
# @param [Fixnum] items_num
def knapsack_recursive(available_weight, items, items_num)
  max_value = 0
  items_num.times do |i|
    if items[i].weight <= available_weight
      # @type [Fixnum]
      temp_value = knapsack_recursive(available_weight - items[i].weight, items, items_num)
      max_value = temp_value + items[i].value if (temp_value + items[i].value) > max_value
    end
  end
  max_value
end

# @param [Fixnum] available_weight
# @param [Array<WeightValue>] items
# @param [Fixnum] items_num
# @param [Array<Fixnum>] max_values_history
def knapsack_dynamic(available_weight, items, items_num, max_values_history)
  max_value = 0
  return max_values_history[available_weight] if max_values_history[available_weight] > -1

  items_num.times do |i|
    if items[i].weight <= available_weight
      temp_value = knapsack_dynamic(available_weight - items[i].weight, items, items_num, max_values_history)
      max_value = temp_value + items[i].value if (temp_value + items[i].value) > max_value
    end
  end
  max_values_history[available_weight] = max_value
  max_value
end

sack = [WeightValue.new(weight: 2, value: 3),
        WeightValue.new(weight: 3, value: 5),
        WeightValue.new(weight: 4, value: 7),
        WeightValue.new(weight: 5, value: 9),
        WeightValue.new(weight: 7, value: 13)]

# @type [Array<Fixnum>]
knapsack_history = Array.new(100, -1)
45.times do |i|
  knapsack_recursive i, sack, 5
  knapsack_history.map! { |x| x = -1 }
  knapsack_dynamic i, sack, 5, knapsack_history
end