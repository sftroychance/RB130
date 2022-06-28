def call_this
  yield(2)
end

to_s = Proc.new { |x| x.to_i }
to_i = Proc.new { |x| x.to_s }

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"

def call_me(some_code)
  some_code.call
end

name = "Robert"

def name
  "Joe"
end

chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)

def some_method
  block_given?
end

bl = proc { puts "hi" }

p some_method(&bl)

def some# (&block) # => & here turns block into a proc, so we use `call`
  yield
  # block.call
end

bloc = proc { p "hi" } # do not alter

some(&bloc) # => & here turns proc into block

def retained_array
  arr = []
  Proc.new do |el|
    arr << el
    arr
  end
end

p arr = retained_array
p arr.call('one')
p arr.call('two')
p arr.call('three')

bloc = lambda { p "hi" }

p bloc.class # => Proc
p bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda

#
#

def my_method(&)
  my_method2(&)
end

def my_method2
  yield
end

my_method { puts 'hi from block'}