=begin
P: Implement octal to decimal conversion. Given an octal input string, your
program should produce a decimal output. Treat invalid input as octal 0.

per test suite: use instance method `Octal#to_decimal` for the conversion

E: per test suite

D: array to process digits

A:
- define class Octal
  - constructor takes one string argument, store as @number
  - the constructor will accept an invalid octal number (per suite, checking
is done in #to_decimal)

- define method to_decimal
  - return 0 if the octal number is invalid -> if number.to_s =~ /[^0-7]/
  - get digits: number.to_i.digits
  - iterate over digits with index (inject?) -> sum += digit * 8**index
  - return sum

=end

class Octal
  def initialize(str)
    @octal = str
  end

  def to_decimal
    return 0 if @octal =~ /[^0-7]/

    @octal.to_i
          .digits
          .map.with_index { |digit, idx| digit * 8**idx }
          .sum
  end
end