=begin
P: Given a number representing number of versus, print the beer song for that
 many verses.

- extra newline between each verse
- each verse two lines
- main lyric:
<num> bottles of beer on the wall, <num> bottles of beer.\n
Take one down and pass it around, <num - 1> bottles of beer on the wall.\n\n
- variations:
2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.

1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.

No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.

- called with no arguments -> verses 99 to 0
  with 1 argument -> that verse only
  with 2 arguments -> loop 1st argument down to 2nd argument

E: per test suite and above

D: none

A:
- Class definition BeerSong
  - no constructor

- class method verse, takes one integer argument num
  - prints num verse

- helper method: bottles_of_beer(num) -> num bottles of beer or 1 bottle of
 beer or no more bottles of beer

- helper method: take_or_go(num) -> Take one down or Take it down or Go to
the store...

- class method verses, takes two integer arguments num1, num2
  - num1.down_to(num2) { |num| verse(num); puts "\n" unless num == 0 }

- class method lyrics
  - verses(99, 0)
=end

class BeerSong
  MAX_BOTTLES = 99

  class << self
    def verse(num)
      validate_range(num)

      output = "#{bottles(num).capitalize} on the wall, #{bottles(num)}.\n"
      output << "#{take_or_go(num)}, "
      output << "#{bottles(num > 0 ? num - 1 : MAX_BOTTLES)} on the wall.\n"
    end

    def verses(start, stop)
      validate_range(start, stop)

      start.downto(stop)
           .each_with_object([]) { |num, output| output << verse(num) }
           .join("\n")
    end

    def lyrics
      verses(MAX_BOTTLES, 0)
    end

    private

    def bottles(num)
      case num
      when 1 then "1 bottle of beer"
      when 0 then "no more bottles of beer"
      else        "#{num} bottles of beer"
      end
    end

    def take_or_go(num)
      case num
      when 1 then "Take it down and pass it around"
      when 0 then "Go to the store and buy some more"
      else        "Take one down and pass it around"
      end
    end

    def validate_range(*args)
      if args.any? { |arg| arg > MAX_BOTTLES || arg < 0 }
        raise ArgumentError, "Argument out of range (0-#{MAX_BOTTLES})."
      end

      if args.size == 2 && args.first < args.last
        raise ArgumentError, "First argument must be larger than the second."
      end
    end
  end
end
