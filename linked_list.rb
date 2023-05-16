class Node 
  attr_accessor :value, :next_node

  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  # Adds a new node containing value to the end of the list
  def append(value)
    new_node = Node.new(value)

    # Checks if there's no head and assigns to it if there's none
    @head ||= new_node

    # Assigns to next node if there is a tail
    @tail ? @tail.next_node = new_node : @tail = new_node

    # Set value to tail
    @tail = new_node    
  end

  # Adds a new node containing value to the start of the list
  def prepend(value)
    new_node = Node.new(value)
    
    # If there is already a head, move it down and prepend
    if @head
      tmp = @head
      @head = new_node
      @head.next_node = tmp

    # Otherwise create new head and tail
    else
      @head = new_node
      @tail = new_node
    end
  end

  # Returns the total number of nodes in the list
  def size
    cursor = @head
    count = 0

    until cursor == nil
      cursor = cursor.next_node
      count += 1

    end

    count
  end

  # Returns the node at the given index
  def at(index)
    cursor = @head
    index.times do
      cursor = cursor.next_node
    end
    cursor
  end

  # Removes the last element from the list
  def pop
    # For any linkedlist of size 1 or smaller
    if size() - 1 <= 0
      @head = nil
      @tail = nil
      return
    end

    # Otherwise, the 2nd last node is the new tail
    new_tail = at(size() - 2)
    new_tail.next_node = nil
    @tail = new_tail
  end

  # Returns true if the passed in value is in the list and otherwise returns false.
  def contains?(value)
    match = false
    cursor = @head

    until match or cursor == nil
      if cursor.value == value
        match = true
      else
        cursor = cursor.next_node
      end
    end

    match
  end
  # Returns the indexes of the nodes containing value as an array, or nil if not found.
  def find(value)
    cursor = @head
    index = 0
    matching_index = []

    until cursor == nil
      if cursor.value == value
        match = true
        matching_index << index
      end
      cursor = cursor.next_node
      index += 1 
    end

    return nil if matching_index.empty?
    return matching_index
  end

  # Represent LinkedList objects as strings
  def to_s
    output = ""
    cursor = @head

    until cursor == nil
      output = output + "( #{cursor.value} ) -> " 
      cursor = cursor.next_node
    end
    output += "nil"
  end
end

test = LinkedList.new

test.append('A')
test.append('B')
test.append('C')

p test
puts test.to_s