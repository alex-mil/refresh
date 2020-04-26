# Memoization approach
# @param [Fixnum] n
# @param [Hash{Fixnum->Fixnum}] memo
def fib(n, memo = {})
  return memo[n] if memo.key?(n)

  return 1 if n <= 2

  memo[n] = fib(n - 1, memo) + fib(n - 2, memo)
end

# Bottom-UP approach
# @param [Fixnum] n
def fib2(n)
  answers = []
  (1..n).each do |i|
    if i <= 2
      ans = 1
    else
      ans = answers[i - 1] + answers[i - 2]
    end
    answers[i] = ans
  end
  answers[n]
end