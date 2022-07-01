=begin
P - A program that, given a word, determines if any of a given list of words
is an anagram of that word.

anagram: all the same letters in a different order

E: Given in test cases

D: given an array

A:
- class Anagram
  - initialize with a string, set instance variable `word` to string value

- method match
  - given array
  - select from that array those elements in which:
      word.chars.sort == element.chars.sort
  - return the selected array
=end

class Anagram
  def initialize(word)
    @word = word
  end

  def match(arr)
    arr.select { |ele| anagram(@word, ele) }
  end

  private

  def anagram(word1, word2)
    word1.downcase.chars.sort == word2.downcase.chars.sort &&
      word1.downcase != word2.downcase
  end
end