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
    tmp = 0

    until tmp >= index or cursor == nil
      cursor = cursor.next_node
      tmp += 1
    end
    
    cursor
  end
end

test = LinkedList.new

test.append('A')

test.append('B')

test.append('C')
p test.at(4)

