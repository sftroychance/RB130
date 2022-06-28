=begin
Write a method that returns a list of all of the divisors of the positive integer passed in as an argument. The return value can be in any sequence you wish.

Examples
divisors(1) == [1]
divisors(7) == [1, 7]
divisors(12) == [1, 2, 3, 4, 6, 12]
divisors(98) == [1, 2, 7, 14, 49, 98]
divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
=end

def divisors(number)
  results = []

  # (1..number).each { |num| results << num if number % num == 0 }

  # (2..number).inject([1]) do |result, num|
  #   result << num if number % num == 0
  #   result
  # end

  # optimized
  (2..Math.sqrt(number)).inject([1, number]) do |result, num|
    if number % num == 0
      result << num << number / num
    end

    result
  end.sort
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
p divisors(999962000357)