iter = Enumerator.new do |yielder|
  yielder << 1
  yielder << 1
  counter = 1
  prev = 1

  loop do
    counter += 1
    prev = counter * prev
    yielder << prev
  end
end

# external iteration
line = '-' * 30
7.times { |n| puts "#{n}!: #{iter.next}" }
puts line
3.times { |n| puts "#{n}!: #{iter.next}" }
puts line
iter.rewind
7.times { |n| puts "#{n}!: #{iter.next}" }
puts line

# internal iteration
iter.each_with_index do |num, idx|
  puts "#{idx}!: #{num}"
  break if idx >= 10
end