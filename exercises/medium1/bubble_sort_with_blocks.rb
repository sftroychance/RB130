=begin
In an earlier exercise, you were asked to construct a #bubble_sort! method that used the bubble sort algorithm to sort Arrays in place.

The problem with this solution is that it doesn't give you any freedom in terms of the criteria used for the sort. For example, perhaps you want to sort the Array in reverse order from usual, or perhaps you want to sort a list of names in a case-insensitive manner.

Your task in this assignment is to modify #bubble_sort! so it takes an optional block that determines which of two consecutive elements will appear first in the results.

If you still have a copy of your #bubble_sort! method, you may use that method as the basis for this exercise. Otherwise, you can use the above solution.
=end

def bubble_sort!(arr)
  loop do
    swapped = false
    final = arr.size - 1 # optimization

    (1..final).each do |idx| # optimization
      if block_given?
        next if yield(arr[idx - 1], arr[idx])
      else
        next if arr[idx - 1] <= arr[idx]
      end

      arr[idx - 1], arr[idx] = arr[idx], arr[idx - 1]
      swapped = true

      final -= 1 # optimization
    end

    break unless swapped
  end

  nil
end

def bubble_sort_fe!(arr)
  loop do
    swapped = false
    final = arr.size - 1 # optimization

    (1..final).each do |idx| # optimization
      if block_given?
        next if yield(arr[idx - 1]) <= yield(arr[idx])
      else
        next if arr[idx - 1] <= arr[idx]
      end

      arr[idx - 1], arr[idx] = arr[idx], arr[idx - 1]
      swapped = true

      final -= 1 # optimization
    end

    break unless swapped
  end

  nil
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

puts "further exploration"
array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort_fe!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)