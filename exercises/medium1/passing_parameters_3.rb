# complete the given method calls

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

def join_list(list)
  list.join(', ')
end
gather(items) do | *produce, grains |
  puts join_list(produce)
  puts grains
end

gather(items) do | fruit, *veg, grains |
  puts fruit
  puts join_list(veg)
  puts grains
end

gather(items) do | fruit, *non_fruit |
  puts fruit
  puts join_list(non_fruit)
end

gather(items) do | a, b, c, d |
  puts "#{a}, #{b}, #{c} and #{d}"
end