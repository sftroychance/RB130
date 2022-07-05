=begin
Write a program that manages robot factory settings.

When robots come off the factory floor, they have no name. The first time you boot them up, a random name is generated, such as RX837 or BC811.

Every once in a while, we need to reset a robot to its factory settings, which means that their name gets wiped. The next time you ask, it will respond with a new random name.

The names must be random; they should not follow a predictable sequence. Random names means there is a risk of collisions. Your solution should not allow the use of the same name twice when avoidable.

P: A program that generates a random name on object instantiation, allows the
 name to be reset.

- name must be two uppercase alpha plus three digits
- do not allow the same name to be used more than once

E: per test suite

D: arrays to hold values to sample, possibly an array class variable to
maintain a list of used robot names (otherwise an external file)

A:
- define class Robot
  - no constructor - name does not need to be generated until #name is called
  - @@taken_names class variable - array to hold names in use

- define method name_generator
  loop
  - set @name to ('AA'..'ZZ').to_a.sample + ('000'..'999').to_a.sample
  - next if @@taken_names.include(@name)
  - @@taken_names << name
  - break loop

- define method reset
  - set @name to nil
  - remove @name from @@taken_names

- define name getter method
  - if @name is nil, generate new name and return, else return name

=end

class Robot
  LETTERS = ('A'..'Z').to_a
  NUMBERS = ('0'..'9').to_a

  @@taken_names = []

  def initialize
    @name = generate_name
  end

  def reset
    @@taken_names.delete(@name)
    @name = nil
  end

  def name
    @name ? @name : @name = generate_name
  end

  private

  def generate_name
    loop do
      @name = ''
      2.times { @name << LETTERS.sample }
      3.times { @name << NUMBERS.sample }

      next if @@taken_names.include?(@name)

      @@taken_names << @name
      break
    end

    @name
  end
end