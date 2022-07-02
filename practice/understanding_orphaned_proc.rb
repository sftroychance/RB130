=begin
trying to understand 'orphaned proc' as discussed in the Ruby documentation,
using their examples

review of concepts:
- procs and blocks return and break from the context in which the are
created; if they are created in 'main', the program ends because it returns
from main

official description of orphaned proc:
return and break in a block exit a method. If a Proc object is generated from the block and the Proc object survives until the method is returned, return and break cannot work. In such case, return and break raises LocalJumpError. A Proc object in such situation is called as orphaned Proc object.

Note that the method to exit is different for return and break. There is a situation that orphaned for break but not orphaned for return.

=> A systematic walkthrough of these methods revealed what is happening.

An important distinction between return and break:
return exits the context where the block was created
break exits the context that has received the block

if the block is executed after that context has already ended, that results
in an orphaned proc. this happens when a proc is returned from that context
and then executed.
=end

# The block is created in m2. m2 calls m1 with the block; m1 turns the block
# into a proc and calls it. This causes a return from the context where the
# block was created--> return from m2; puts statement will not execute.
def m1(&b)
  b.call
  puts 'will not print'
end

def m2()
  m1 { return }
  puts 'will not print'
end

m2 # ok

# block is created in m2 with a break instead of a return; break exits the
# method that is called with the block--here it exits m1. This is similar to
# the #each method; if we break inside the block, the #each method is exited
# but the code after the #each method continues.
def m1(&b)
  b.call
  puts 'will not print'
end

def m2()
  m1 { break }
  puts 'will print'
end

m2 # ok
# a block is created in m2 and sent to m1; m1 turns the block into a proc and
# returns the proc; then in m1 #call is called on the proc; the return is
# defined in m2, but that is where the proc is being executed anyway, so it
# returns from m2
def m1(&b)
  b
end

def m2()
  m1 { return }.call
  puts 'will not print'
end

m2 # ok
# the block is created in m2 and sent to m1; at m1 the block is turned into a
# proc, and that proc is returned to m2. #call is called on that proc. break
# exits from the method that is receiving the block (m1), but here the block is
# not executed until after that method (m1) has already been executed, so
# there is nowhere to break from.
def m1(&b)
  b
end

def m2()
  m1 { break }.call
  puts 'will not print'
end

m2 # LocalJumpError
# block is created in m2 and passed to m1; m1 turns the block into a proc and
# returns the proc, and then m2 in turn returns the proc. The proc is called
# outside either method. With a proc or block, return exits the context where
# it was created--in this case, m2--but m2 has already executed when the proc
# is called, so it can't return from there.
def m1(&b)
  b
end

def m2()
  m1 { return }
end

m2.call # LocalJumpError
# block is created in m2. m1 is called with the block. m1 turns the block
# into a proc and returns it. m2 in turn returns that proc. The proc is then
# called from outside either method. In a proc or block, break exits the
# method that is called with the block--in this case m1. However, m1 has
# already exited by the time the proc is called, so there is nowhere to break
# from.
def m1(&b)
  b
end

def m2()
  m1 { break }
end

m2.call # LocalJumpError