=begin
P:
A class that represents a triangle. Initialized with values for three side
lengths. A method kind that returns a string indicating the type of triangle.

rules: must be 3 sides, no length can have negative or zero value, the sum of
lengths of any two sides must be greater than the third side.

types: An equilateral triangle is defined as having all three sides of equal
length; an isosceles triangle has two sides of equal length; a scalene
triangle has three sides of all different lengths.

E:
should not work:
Triangle.new(0, 10, 20)
Triangle.new(-5, 10, 20)
Triangle.new(5, 10)
Triangle.new(3, 5, 25)
Triangle.new(10, 10, 20)

D: array for side length values

A:
- Initialize with three arguments taken as one array parameter
- ArgumentError if size of array is not 3, if any value is zero, if any value
  is negative, and if the sum of the smallest two side lengths is not greater
  than the length of the third side.
- If no error, assign values to the instance variable array.
- method kind:
  - Equilateral triangle: The sides array will have only one unique value.
  - Isosceles triangle: The sides array will have only two unique values.
  - Scalene triangle: The sides array will have three unique values
  - test these and return a string indicating the triangle type
=end

class Triangle
  def initialize(*sides)
    raise ArgumentError, 'Wrong number of arguments' if sides.size != 3
    raise ArgumentError, 'Invalid side lengths' if invalid_triangle?(sides)

    @sides = sides
  end

  def kind
    case @sides.uniq.size
    when 1 then 'equilateral'
    when 2 then 'isosceles'
    else        'scalene'
    end
  end

  private

  def invalid_triangle?(sides)
    sides.any?(&:zero?) ||
    sides.any?(&:negative?) ||
    sides.min(2).sum <= sides.max
  end
end