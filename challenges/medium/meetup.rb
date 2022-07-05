=begin
Meetups are a great way to meet people who share a common interest. Typically, meetups happen monthly on the same day of the week. For example, a meetup's meeting may be set as:

The first Monday of January 2021
The third Tuesday of December 2020
The teenth wednesday of December 2020
The last Thursday of January 2021
In this program, we'll construct objects that represent a meetup date. Each object takes a month number (1-12) and a year (e.g., 2021). Your object should be able to determine the exact date of the meeting in the specified month and year. For instance, if you ask for the 2nd Wednesday of May 2021, the object should be able to determine that the meetup for that month will occur on the 12th of May, 2021.

The descriptors that may be given are strings: 'first', 'second', 'third', 'fourth', 'fifth', 'last', and 'teenth'. The case of the strings is not important; that is, 'first' and 'fIrSt' are equivalent. Note that "teenth" is a made up word. There was a meetup whose members realised that there are exactly 7 days that end in '-teenth'. Therefore, it's guaranteed that each day of the week (Monday, Tuesday, ...) will have exactly one date that is the "teenth" of that day in every month. That is, every month has exactly one "teenth" Monday, one "teenth" Tuesday, etc. The fifth day of the month may not happen every month, but some meetup groups like that irregularity.

The days of the week are given by the strings 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', and 'Sunday'. Again, the case of the strings is not important.

P: Given a month and year and a meetup day (e.g., first Monday, last Friday),
 return the date of that meetup day.

E: per test suite

D: arrays for ordinals

A:
- define class Meetup
  - constant ORDINALS = %w(first, second, third, fourth, fifth)
  - constructor takes two arguments, year and month
    - @start_date = Date.civil(year, month)
- define instance method day with two parameters - dayname and descriptor
  - dayname to downcase
  - get candidates: (date range).select(&:dayname?)
  - case descriptor
    - when 'last' then candidates.last
    - when 'teenth' then candidates.select { |d| d.day.between?(13, 19) }
    - else candidates[ORDINALS.index(descriptor)]
=end

class Meetup
  require 'date'

  ORDINALS = %w(first second third fourth fifth)

  def initialize(year, month)
    @start_date = Date.civil(year, month)
  end

  def day(weekday_name, descriptor)
    weekday = (weekday_name.downcase + '?').to_sym
    candidates = (@start_date...@start_date.next_month).select(&weekday)

    case descriptor.downcase
    when 'last'   then candidates.last
    when 'teenth' then candidates.select { |d| d.day.between?(13, 19) }.first
    else               candidates[ORDINALS.index(descriptor.downcase)]
    end
  end
end
