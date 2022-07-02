=begin
P: Per test suite, write a class method that classifies a number based on the
 sum of its positive divisors.

classification:
perfect -> sum of divisors == number
abundant -> sum of divisors > number
deficient -> sum of divisors < number

rules: natural numbers (1 and higher) only, raise StandardError otherwise
divisors do not include number itself

E: per test cases

D: array to hold divisors

A:
- class method classify that takes one parameter, number
- return StandardError if number < 1
- initialize divisors array to [1] (1 is included but not the number itself)
- find divisors
  - iterate 2 to sqrt of number, if number % x == 0, append x and number/x to
 divisors array
- sum divisors
- classify according to sum
  - case statement on number <=> sum

=end

class PerfectNumber
  class << self
    def classify(number)
      raise StandardError if number < 1

      divisors_sum = find_divisors(number).sum

      case divisors_sum <=> number
      when 0 then 'perfect'
      when -1 then 'deficient'
      when 1 then 'abundant'
      end
    end

    private

    def find_divisors(number)
      divisors = [1]

      (2..Math.sqrt(number)).each do |num|
        divisors << num << number / num if number % num == 0
      end

      divisors
    end
  end
end
