=begin
The diamond exercise takes as its input a letter, and outputs it in a diamond shape. Given a letter, it prints a diamond starting with 'A', with the supplied letter at the widest point.

P: Given a letter, print a diamond in which each row displays a letter from A
 to that letter, in the shape of a diamond.

- top and bottom rows are the letter A centered over the field of width 2 *
given letter index + 1; subsequent rows are two letter separated by spaces (2
 * given letter index -1)

E: per test cases

D: arrays for line processing

A:
- define class Diamond
  - no constructor
  - constant LETTERS ('A'..'Z').to_a

- define class method make_diamond that takes one string parameter
  - verify string is a single uppercase character and assign to @letter
  - set field width = LETTERS.index(@letter) + 1
  - initialize lines array
  - build UL quadrant of diamond:
    iterate 'A' to @letter -> char
    - lines << (char + ' ' * LETTERS.index(char)).right(field width)
  - build top half of diamond
    mirror each line in lines array horizontally
    - map line + line.reverse[1..]
  - build full diamond
    mirror the lines array vertically
    - lines + lines.reverse[1..]
  - print lines.join('\n')

=end

class Diamond
  LETTERS = ('A'..'Z').to_a

  class << self
    def make_diamond(char)
      raise ArgumentError, 'Argument must be an uppercase letter' unless valid_char?(char)

      field_width = LETTERS.index(char) + 1

      lines = []

      ('A'..char).each do |c|
        lines << (c + ' ' * LETTERS.index(c)).rjust(field_width)
      end

      lines.map! { |line| line + line.reverse[1..] }

      lines += lines.reverse[1..]

      lines.join("\n") + "\n"
    end

    private

    def valid_char?(char)
      char =~ /\A[A-Z]{1}\z/
    end
  end
end