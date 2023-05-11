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

  def append(value)
    tmp_node = Node.new(value)

    # Checks if there's no head and assigns to it if there's none
    @head ||= tmp_node

    # Assigns to next node if there is a tail
    @tail ? @tail.next_node = tmp_node : @tail = tmp_node

    # Set value to tail
    @tail = tmp_node    
  end

end

test = LinkedList.new
p test.head

test.append('A')
p test

test.append('B')
p test

test.append('C')
p test