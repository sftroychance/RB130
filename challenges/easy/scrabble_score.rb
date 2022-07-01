=begin
P: A program that calculates the scrabble score for a given word

- values
1: A, E, I, O, U, L, N, R, S, T
2: D, G
3: B, C, M, P
4: F, H, V, W, Y
5: K
8: J, X
10: Q, Z

E: test cases given
nil returns 0 score
all whitespace returns 0 score

D: Hash to map letters to scores
Array to process characters of given word

A:
- class Scrabble
  - CONST for letter values (no pattern, so hard-coded)
  - initializer takes a string parameter
    - if nil, set inst variable to ''
    - delete all whitespace

- method score
  - convert word to characters
  - map to replace characters with their scores
  - return sum of scores

=end

class Scrabble
  POINTS = { 'aeioulnrst' => 1,
             'dg' => 2,
             'bcmp' => 3,
             'fhvwy' => 4,
             'k' => 5,
             'jx' => 8,
             'qz' => 10 }

  def initialize(word)
    @word = word ? word.downcase.gsub(/\s+/, '') : ''
  end

  def score
    @word.chars.map do |char|
      key = POINTS.keys.select { |k| k.include?(char) }.first
      POINTS[key]
    end.sum
  end

  def self.score(word)
    Scrabble.new(word).score
  end
end