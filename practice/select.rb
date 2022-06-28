def my_select(arr)
  # counter = 0
  results = []

  # while counter < arr.size
  #   results << arr[counter] if yield(arr[counter])
  #   counter += 1
  # end

  arr.each do |ele|
    results << ele if yield(ele)
  end

  results
end

array = [1, 2, 3, 4, 5]

array2 = my_select(array) do |num|
  num.odd?
end

p array2