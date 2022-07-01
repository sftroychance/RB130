=begin
Run and write observations about each group of code:
=end

# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

=begin
observations on Group 1:
1. You can create a new proc with `proc { }` instead of Proc.new
2. Proc#to_s returns the class name (Proc) with an encoding of the object ID,
 as well as an indication of where the proc was defined (file/line#).
3. We use Proc#call to execute the code in a proc.
4. A proc has lenient arity; it will respond to the call method even if there
 are block parameters but the method call does not send the right number of
arguments.
5. To call a proc with arguments, which represent the block parameters:
`my_proc.call(args)`
6. If arguments are not sent to a block that defines parameters, the block
variable is given a value of nil.
=end

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
#my_lambda.call
#my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }

=begin
Group 2 observations:
1. A lambda is declared by `lambda { }`. Lambda.new does not work, because
there is no class Lambda.
2. A lambda can also be declared by stabby notation:
`my_lambda = -> (block_params)  { }`
3. A lambda is an object of class Proc.
4. The to_s method for Proc, for a lambda, will include '(lambda)' in the
inspect string output (after the lambda location).
5. A lambda is called just like a proc, with arguments if required.
6. Lambdas have strict arity, so they must be passed exactly the number of
arguments as are defined by the block_parameters. An ArgumentError will
result if not.
7. Lambdas cannot be created with `Lambda.new` because Lambda is not a class;
 a lambda is of class Proc.
=end

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
#block_method_1('seal') # LocalJumpError

=begin
Group 3 observations:
1. Yield will still call a block even if the correct number of arguments are
not given - lenient arity.
2. The value of the block_parameters will be nil if the arguments are not sent.
3. Recall: puts nil will just print nothing
4. If a method includes a 'yield' statement, that method must be passed a
block, if no block is sent with the method call, this will result in
LocalJumpError.
=end

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
#block_method_2('turtle') { puts "This is a #{animal}."}

=begin
Group 4 observations:
1. An argument sent to a method can be yielded to the block `yield(arg)`.
2. If the wrong number of arguments are sent with the yield (not matching the
 number of block_parameters defined for the block), this will not result in
an error. Any missing arguments will result in the block value being set to
nil, and any extra arguments will be ignored.
3. If the block references a variable that was not in scope at the location
the block is defined, this will result in a NameError (Undefined local
variable or method). In this example, the block references 'animal', but this
 is not listed as a block parameter; the yield call sends an argument, but
this is discarded. Although local variable `animal` is in scope when the
yield is called, it was not in scope when the block was created, so it cannot
 be accessed directly by the block.

Overall notes:
1. Blocks are unnamed closures. Procs are named blocks. Lambdas are Proc objects
with special restrictions (strict arity, different return behavior).
2. Blocks and Procs have lenient arity; methods and lambdas have strict arity.
3. If parameters are defined for blocks or Procs but the method call does not
 send the correct number of arguments, the value of nil will be assigned to
block variables without arguments, and any extra arguments will be ignored.