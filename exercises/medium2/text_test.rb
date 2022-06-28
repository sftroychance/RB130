require 'minitest/autorun'
require_relative 'text.rb'

class TextTest < Minitest::Test
  def setup
    text_file = File.open('sample.txt', 'r')
    @str = text_file.read
    text_file.close

    @text = Text.new(@str)
  end

  def test_swap
    orig_char = 'a'
    new_char = 'e'

    # not ideal for creating expected value, as it uses the same method used
    # in the method being tested--what if we are using both of them
    # incorrectly but the same way? the test would pass. The solution
    # proposes manually exchanging the values in the original text and
    # including that changed body of text within this method.
    # test_str = @str.gsub(orig_char, new_char)

    test_str = <<~TEXT.chomp
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal(test_str, @text.swap(orig_char, new_char))
  end

  def test_word_count
    expected = 72

    assert_equal(expected, @text.word_count)
  end

  def teardown

  end
end

=begin
Of note, the solution also utilizes a teardown: opens the file in setup but
then creates the Text object in the test_swap method, then closes the file in
 teardown.
=end
