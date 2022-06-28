=begin
The Range#step method lets you iterate over a range of values where each value in the iteration is the previous value plus a "step" value. It returns the original range.

Write a method that does the same thing as Range#step, but does not operate on a range. Instead, your method should take 3 arguments: the starting value, the ending value, and the step value to be applied to each iteration. Your method should also take a block to which it will yield (or call) successive iteration values.

Ex:
step(1, 10, 3) { |value| puts "value = #{value}" }

value = 1
value = 4
value = 7
value = 10

=> opted to return an array of every value found, which would allow methods
to be chained with the result array.

At first, set this up to accept a negative increment, but omitted this
because the Range#step method will not accept a negative increment.
=end
def step (start_value, end_value, increment)
  current_value = start_value
  result = []

  until current_value >= end_value
    yield(current_value)
    result << current_value
    current_value += increment
  end

  result
end

p step(1, 10, 3) { |value| puts "value = #{value}" }

value = 1
value = 4
value = 7
value = 10

