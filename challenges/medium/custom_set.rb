=begin
Create a custom set type.

Sometimes it is necessary to define a custom data structure of some type, like a set. In this exercise you will define your own set type. How it works internally doesn't matter, as long as it behaves like a set of unique elements that can be manipulated in several well defined ways.

In some languages, including Ruby and JavaScript, there is a built-in Set type. For this problem, you're expected to implement your own custom set type. Once you've reached a solution, feel free to play around with using the built-in implementation of Set.

For simplicity, you may assume that all elements of a set must be numbers.

P: Create a custom set data structure; internal working does not matter
(essentially an array where all elements must be unique).
- assume all elements are numbers

E: per test suite

D: array to hold elements of set

A:
- define class CustomSet
  - constructor takes optional array
    - get unique values of array, assign to @set

- define instance method #empty?
  - @set.empty?

- define instance method #contains?, takes one parameter (number)
  - @set.include?(param)

- define instance method #subset?, takes one parameter (CustomSet object)
  - is self.set subset of param.set?
  - set.all? { |val| param.set.include?(val)}

- define instance method #disjoint? takes one parameter (CustomSet object)
  - disjoint -> true if sets have no elements in common
  - set.none? { |val| param.set.include?(val) }

- define instance method #eql? takes one parameter (CustomSet object)
  - set.sort == param.set.sort

- define instance method #add, takes one parameter (number)
  - @set << number
  - @set.uniq!

- define instance method #intersection, takes one parameter (CustomSet object)
  - CustomSet.new(@set.select { |val| param.set.include?(val) })

- define instance method #difference, takes one parameter (CustomSet object)
  - values in @set but not in param.set
  - CustomSet.new(@set.select { |v| !param.set.include?(v) })

- define instance method #union, takes one parameter (CustomSet object)
  - CustomSet.new((@set + param.set).uniq)

- define instance method ==, takes one parameter (CustomSet object)
  - set.sort == param.set.sort => this is behavior of Set class

=end

class CustomSet
  attr_reader :set

  def initialize(arr = [])
    @set = arr.uniq
  end

  def empty?
    set.empty?
  end

  def contains?(val)
    set.include?(val)
  end

  def subset?(other_set)
    set.all? { |val| other_set.contains?(val) }
  end

  def disjoint?(other_set)
    set.none? { |val| other_set.contains?(val) }
  end

  def eql?(other_set)
    set.sort == other_set.set.sort
  end

  def add(val)
    set << val unless set.include?(val)

    self
  end

  def intersection(other_set)
    CustomSet.new(set.select { |val| other_set.contains?(val) })
  end

  def difference(other_set)
    CustomSet.new(set.select { |val| !other_set.contains?(val) })
  end

  def union(other_set)
    CustomSet.new((set + other_set.set).uniq.sort)
  end

  def ==(other)
    eql?(other)
  end
end
