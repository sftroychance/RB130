require 'simplecov'
require 'minitest/autorun'
require "minitest/reporters"
SimpleCov.start

Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@list.size, 3)
  end

  def test_first
    assert_equal(@list.first, @todo1)
  end

  def test_last
    assert_equal(@list.last, @todo3)
  end

  def test_shift
    shifted = @list.shift
    assert_equal(shifted, @todo1)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    popped = @list.pop
    assert_equal(popped, @todo3)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done
    assert_equal(false, @list.done?)
  end

  def test_add_not_todo
    assert_raises(TypeError) { @list.add('not a todo') }
  end

  def test_concat_not_todo
    assert_raises(TypeError) { @list << 3 }
  end

  def test_add_todo
    todo4 = Todo.new('test')
    @list.add(todo4)
    assert_equal(@list.last, todo4)
  end

  def test_concat_todo
    todo4 = Todo.new('test')
    @list.add(todo4)
    assert_equal(@list.last, todo4)
  end

  def test_item_at
    assert_equal(@list.item_at(0), @todo1)
    assert_raises(IndexError) { @list.item_at(4) }
  end

  def test_mark_done_at
    @list.mark_done_at(2)
    assert_equal(true, @todo3.done?)
    assert_raises(IndexError) { @list.mark_done_at(7) }
  end

  def test_mark_undone_at
    @todo1.done!
    @list.mark_undone_at(0)
    assert_equal(false, @todo1.done?)
    assert_raises(IndexError) { @list.mark_undone_at(10) }
  end

  def test_all_done
    @list.done!
    assert_equal(true, @todos.all?(&:done?))
  end

  def test_remove_at
    removed = @list.remove_at(0)
    assert_equal(removed, @todo1)
    assert_raises(IndexError) { @list.remove_at(5) }
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(@list.to_s, output)
  end

  def test_to_s_one_done
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    @todo1.done!

    assert_equal(@list.to_s, output)
  end

  def test_to_s_all_done
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!

    assert_equal(@list.to_s, output)
  end

  def test_each
    output = ''
    @list.each { |_| output << '1' }

    assert_equal('111', output)
  end

  def test_each_return_value
    x = @list.each { |_| nil }

    assert_equal(@list, x)
  end

  def test_select
    @list.mark_done_at(0)

    arr = @list.select(&:done?)

    assert_equal(arr.first, @todo1)
  end
end
