require 'minitest/autorun'

require_relative 'transaction.rb'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    input = StringIO.new("30\n")
    output = StringIO.new

    transaction = Transaction.new(30)

    # transaction.prompt_for_payment
    # transaction.prompt_for_payment(input: input, output: output)
    capture_io { transaction.prompt_for_payment(input: input) }

    assert_equal(30, transaction.amount_paid)
  end
end