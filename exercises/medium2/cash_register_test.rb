require 'minitest/autorun'

require_relative 'cash_register.rb'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    register = CashRegister.new(1000)
    transaction = Transaction.new(50)
    transaction.amount_paid = 50

    prev_amount = register.total_money
    register.accept_money(transaction)
    new_amount = register.total_money

    assert_equal(prev_amount + 50, new_amount)
  end

  def test_change
    register = CashRegister.new(1000)
    transaction = Transaction.new(50)

    transaction.amount_paid = 70

    assert_equal(20, register.change(transaction))
  end

  def test_give_receipt
    cost = 50
    register = CashRegister.new(1000)
    transaction = Transaction.new(cost)

    assert_output("You've paid $#{cost}.\n") do
      register.give_receipt(transaction)
    end
  end
end