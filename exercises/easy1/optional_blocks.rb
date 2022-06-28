=begin
Write a method that takes an optional block. If the block is specified, the method should execute it, and return the value returned by the block. If no block is specified, the method should simply return the String 'Does not compute.'.

Examples:

compute { 5 + 3 } == 8
compute { 'a' + 'b' } == 'ab'
compute == 'Does not compute.'

=>
- use block_given? and branch to (a) yield or (b) the return string

further exploration: same, sending an argument to the method and yielding
with that argument
=end

def compute
  if block_given?
    yield
  else
    'Does not compute.'
  end
end

def new_compute(name)
  if block_given?
    yield(name)
  else
    'Does not compute.'
  end
end

p compute { 5 + 3 } == 8
p compute { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'

p new_compute('Troy') { |n| "Howdy, #{n}!" }
p new_compute('Jason') {|n| "I like #{n}!" }
p new_compute('Jane')
