=begin
P: Given a natural number and set of one or more other numbers, find sum of
all numbers that are multiples of the numbers in the set.

- natural numbers up to (not including) the given number
- if a set of numbers is not given, use 3 and 5

E: Per test cases
  - note we call class method Sum::to without including multiples set
  - we call Sum#to as well (tests do not indicate instantiating objects
without sending the set)

D: arrays for processing

A:
- define class Sum
  - initializer that takes an optional set of numbers
    - if a set is provided, initialize @multiple_set to that set
    - else set @multiple_set = [3, 5]

- define class method ::to that takes an integer argument
  - instantiate object and call Sum#to on that object

- define instance method #to that takes an integer argument
  - initialize @multiples = []
  - iterate 1 to given target -> number
    - iterate over @multiple_set -> mult
      - append to @multiples if number % mult == 0
  - remove duplicate values from @multiples
  - sum @multiples
=end

class SumOfMultiples
  def initialize(*args)
    @multiple_set = args.empty? ? [3, 5] : args
  end

  def to(target)
    (1...target).inject(0) do |total, num|
      total += num if @multiple_set.any? { |mult| num % mult == 0 }
      total
    end
  end

  def self.to(target)
    SumOfMultiples.new.to(target)
  end
end