=begin
Modify the method below so that the display/output of items is moved to a block, and its implementation is left up to the user of the gather method.
=end

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Nice selection of food we have gathered!"
end

gather(items) { |foods| puts "#{foods.join(', ')}" }
