=begin
A mutation is simply a mistake that occurs during the creation or copying of a nucleic acid, in particular DNA. Because nucleic acids are vital to cellular functions, mutations tend to cause a ripple effect throughout the cell. Although mutations are technically mistakes, a very rare mutation may equip the cell with a beneficial attribute. In fact, the macro effects of evolution are attributable by the accumulated result of beneficial microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands taken from different genomes with a common ancestor, we get a measure of the minimum number of point mutations that could have occurred on the evolutionary path between the two strands.

This is called the Hamming distance.

The Hamming distance is only defined for sequences of equal length. If you have two sequences of unequal length, you should compute the Hamming distance over the shorter length.

P: Class DNA that contains one string instance variable representing a strand of
 DNA. A method calculates the hamming distance when comparing this strand of
DNA to another given strand (given as a string). Compared character by
character, the hamming distance is the count of times when the characters in
each string are not equal.

rules:
- if one strand is shorter than the other, assess only the number of
characters in the shorter strand

E:

GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^
The Hamming distance between these two DNA strands is 7.

- edge cases
'' and '' -> count 0
'GAT' and 'GATC' -> count 3

D: convert strings to arrays to aid character comparisons

A:
- class definition with instantiate method that takes one parameter
  - assign instance variable to given string

- method hamming_distance
  - split given string into a new array
  - get the size of the smallest array
  - truncate (a duplicate of) the largest array so they are the same size
  - zip the arrays
  - count the number of subarrays in which the characters are not the same
  - return count

=end
class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_strand)
    strand1, strand2 = [@strand, other_strand].sort_by(&:size)

    strand1.chars.zip(strand2.chars).count { |a, b| a != b }
  end
end