=begin
P: Given a string of digits, return all consecutive number series of a
specified length in that string.

- ArgumentError if specified length > size of string
- return array of subarrays

E: per test suite

D: arrays

A:
- class Series
  - constructor takes one string argument
    - assign argument to @series

- instance method slices takes one integer argument
  - break string into characters
  - map characters to integers
  - get subarrays of each consecutive 2 integers (each_cons)
  - each_cons returns an enumerator -> call to_a to return array

  => @series.chars.map(&:to_i).each_cons(slice).to_a
=end

class Series
  def initialize(str)
    @series = str
  end

  def slices(slice)
    raise ArgumentError, 'Slice larger than string' if slice > @series.length

    @series.chars
           .map(&:to_i)
           .each_cons(slice)
           .to_a
  end
end