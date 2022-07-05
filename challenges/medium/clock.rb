=begin
Create a clock that is independent of date.

You should be able to add minutes to and subtract minutes from the time represented by a given clock object. Two clock objects that represent the same time should be equal to each other.

You may not use any built-in date or time functionality; just use arithmetic operations.

P: A clock that tracks hours and minutes only. A class with a class method to
 set a time, with an instance method to set time, and instance methods to add
 and subtract minutes from that time.

- 24-hour clock

E: per test suite

D: None expected.

A:
- class Clock with instance variables @hour, @minute
  - initialize(hour, minute = 0)

- class method at, takes two parameters, second optional
  - instantiate new clock object with parameters
  - return object

- instance method to_s
  - prints time in format HH:MM

- instance method +, takes one parameter (minutes)
  - convert @hour and @minute to total minutes
  - add minutes
  - normalize minute value to 0 to 1440 (add/subtract 1440 until within this
range)
  - convert back to @hour and @minute (divmod)
  - return self

- instance method -, takes one parameter (minutes)
  - call + with -minutes

- instance method ==
  compare hour and minute value
=end

class Clock
  MINS_PER_HOUR = 60
  MINS_PER_DAY = 1440

  def self.at(hour, minute = 0)
    Clock.new(hour, minute)
  end

  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def to_s
    format("%02d:%02d", hour, minute)
  end

  def +(other_minutes)
    minutes = minutes_past_midnight + other_minutes

    @hour, @minute = calculate_hour_and_minute(minutes)

    self
  end

  def -(other_minutes)
    self + -other_minutes
  end

  def ==(other)
    hour == other.hour && minute == other.minute
  end

  protected

  attr_reader :hour, :minute

  private

  def minutes_past_midnight
    hour * MINS_PER_HOUR + minute
  end

  def calculate_hour_and_minute(minutes)
    minutes += MINS_PER_DAY until minutes >= 0
    minutes -= MINS_PER_DAY until minutes <= MINS_PER_DAY

    minutes.divmod(60)
  end
end
