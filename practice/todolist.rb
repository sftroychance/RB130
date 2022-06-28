class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo

    @todos << todo
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos[0]
  end

  def last
    @todos[-1]
  end

  def to_a
    @todos.clone
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def each
    # counter = 0
    #
    # while counter < @todos.size
    #   yield(@todos[counter])
    #   counter += 1
    # end

    # can call #each on array
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    new_list = TodoList.new(title)

    @todos.each do |todo|
      new_list.add(todo) if yield(todo)
    end

    new_list
  end

  def find_by_title(str)
    # @todos.each do |todo|
    #   return todo if todo.title.downcase.include?(str.downcase)
    # end
    #
    # nil

    select { |todo| todo.title.downcase.include?(str.downcase)}.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(str)
    find_by_title(str) && find_by_title(str).done!
  end

  def mark_all_done
    (0...@todos.size).each { |idx| mark_done_at(idx) }
    # per solution:
    # each { |todo| todo.done! }
  end

  def mark_all_undone
    (0...@todos.size).each { |idx| mark_undone_at(idx) }
    # per solution:
    # each { |todo| todo.undone! }
  end
end

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")
#
# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)
#
# # puts list
# #
# # list.pop
# #
# # puts list
# #
# # list.mark_done_at(1)
# #
# # puts list
# #
# list.each do |todo|
#   puts todo
# end
#
# todo1.done!
#
# results = list.select { |todo| todo.done? }
#
# puts results.inspect
#
# puts list
#
# list.each { |todo| puts todo.title }
#
# p list.find_by_title('clean')
#
# puts list.all_done
#
# puts list.all_not_done
#
# list.mark_done('room')
#
# puts list
#
# list.mark_all_done
# puts list
#
# list.mark_all_undone
# puts list