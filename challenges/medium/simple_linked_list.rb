=begin
Write a simple linked list implementation. The linked list is a fundamental data structure in computer science, often used in the implementation of other data structures.

The simplest kind of linked list is a singly linked list. Each element in the list contains data and a "next" field pointing to the next element in the list of elements. This variant of linked lists is often used to represent sequences or push-down stacks (also called a LIFO stack; Last In, First Out).

Let's create a singly linked list whose elements may contain a range of data such as the numbers 1-10. Provide functions to reverse the linked list and convert a linked list to and from an array.

P: Create a simple singly linked list (e.g. each node points to the next
node) that simulates a stack (LIFO).

details derived from test suite:
- Nodes are a class called Element, which is initialized with a value (datum)
- Element objects have an instance variable @next, which indicates the next
node (returns the Element object)
- Element#tail? returns whether @next is nil (if nil, it is the last node)
- class SimplyLinkedList, no constructor
note: in SimplyLinkedList, as LIFO; the 'head' refers to the last element
added (the 'head' of the stack); the 'tail' refers to the first element added
 (the bottom of the stack)
- SimplyLinkedList#push to add an element to the list
- SimplyLinkedList has an instance variable @head to indicate the last node
added
- SimplyLinkedList#empty? returns whether @head is nil
- SimplyLinkedList#size returns size of the list
- SimplyLinkedList#peek return the value of the last node without removing it
 from the list
- SimplyLinkedList#pop remove a node from the list and returns its value
- SimplyLinkedList#reverse reverses the order of the stack
- SimplyLinkedList#to_a returns the list as an array (bottom of stack to top)
- SimplyLinkedList#from_a takes an array and creates a list from it

E: Per test suite

D: arrays

A:
- define class Element, which represents a node
  - initialize takes two parameters, datum and (optional)next; next defaults to
 nil
    - set @datum = datum, @next to next
    - attr_accessor for @datum, @next

- define method Element#tail?
  - @head.next.nil?

- define class SimplyLinkedList
  - initialize - no parameters but sets @head to nil

- define method SimplyLinkedList#size
  - next_node = @head
  - counter = 0
  - loop until next_node is nil
    - counter += 1
    - next_node = next_node.next
  - return counter

- define method SimplyLinkedList#empty?
  - @head.nil?

- define method SimplyLinkedList#peek
  - return nil if @head.nil?
  - @head.datum

- define method SimplyLinkedList#push
  - takes one parameter (datum)
  - @head = Element.new(datum, @head)

- define method SimplyLinkedList#pop
  - datum = @head.datum
  - @head = @head.next
  - return datum

- define class method SimplyLinkedList#from_a
  - takes one array parameter
  - return if array.nil? || array.empty?
  - array.reverse_each { |ele| push(ele) }

- define method SimplyLinkedList#to_a
  - output = []
  - next_node = @head
  - until next_node.nil?
    - output << next_node.datum
    - next_node = next_node.next
  - return output.reverse

- define method SimplyLinkedList#reverse
  - new_list = new
  - next_node = @head
  - until next_node.nil?
      new_list.push(next_node.datum)
  - return new_list

=> there is repeat code (reverse, to_a, size) for iterating through the
nodes, so extracted that out to an iterator method 'each_node', which takes a
 block.

Two of the methods return objects (to_a, reverse), so created an iterator
'each_node_with_object' for those, presented as an alternative. Note
each_node_with_object will not for for #size because the object that is sent
to the method must be mutable, and an integer is not mutable.
=end

class Element
  attr_reader :datum, :next

  def initialize(datum, next_node = nil)
    @datum = datum
    @next = next_node
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def self.from_a(arr)
    new_list = new

    return new_list if arr.nil? || arr.empty?

    arr.reverse_each { |ele| new_list.push(ele) }

    new_list
  end

  def size
    counter = 0

    each_node { |_| counter += 1 }

    counter
  end

  def empty?
    head.nil?
  end

  def peek
    return nil if head.nil?

    head.datum
  end

  def push(datum)
    @head = Element.new(datum, head)
  end

  def pop
    datum = head.datum
    @head = head.next

    datum
  end

  def to_a
    # output = []
    #
    # each_node { |node| output << node.datum }
    #
    # output

    each_node_with_object([]) do |node, arr|
      arr << node.datum
    end
  end

  def reverse
    # new_list = SimpleLinkedList.new
    #
    # each_node { |node| new_list.push(node.datum) }
    #
    # new_list

    each_node_with_object(SimpleLinkedList.new) do |node, list|
      list.push(node.datum)
    end
  end

  private

  def each_node
    current_node = head

    until current_node.nil?
      yield(current_node)
      current_node = current_node.next
    end
  end

  def each_node_with_object(obj)
    current_node = head

    until current_node.nil?
      yield(current_node, obj)
      current_node = current_node.next
    end

    obj
  end
end
