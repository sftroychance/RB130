=begin
Write some code that converts modern decimal numbers into their Roman number equivalents.

P: Create a roman numeral class that stores an integer given at instantiation.
Write a method that returns a string value that is the roman numeral
equivalent of that integer.

corresponding values:
1: I      10: X   100: C    1000: M
4: IV     40: XL  400: CD
5: V      50: L   500: D
9: IX     90: XC  900: CM

E:

D: hash to link values and roman numerals

A:
- Class: initialize with integer
  - assign number to instance variable

  constants: hash (values: roman_numerals)

- method to_roman
  - split the integer into digits (note #digits reverses digit order)
  - map each digit to its total value => [1, 2, 3] - [100, 20, 3]
  - initialize output string to empty
  - iterate over total_values
    - set current value
    - until current value == 0
      - select all hash keys <= current value
      - get maximum of selected keys
      - append to output string the hash value at that key
      - subtract that key from current value
  - return output string
=end

class RomanNumeral
  DEC_TO_ROMAN = { 1 => 'I', 4 => 'IV', 5 => 'V', 9 => 'IX',
                   10 => 'X', 40 => 'XL', 50 => 'L', 90 => 'XC',
                   100 => 'C', 400 => 'CD', 500 => 'D', 900 => 'CM',
                   1000 => 'M' }

  def initialize(number)
    @number = number
  end

  def to_roman
    output = ''

    current = @number

    until current == 0
      key = DEC_TO_ROMAN.keys.select { |k| k <= current }.max
      output << DEC_TO_ROMAN[key]
      current -= key
    end

    output
  end
end
