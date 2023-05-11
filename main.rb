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
    new_node = Node.new(value)

    # Checks if there's no head and assigns to it if there's none
    @head ||= new_node

    # Assigns to next node if there is a tail
    @tail ? @tail.next_node = new_node : @tail = new_node

    # Set value to tail
    @tail = new_node    
  end

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

end

test = LinkedList.new
p test.head

test.prepend('A')
p test

test.prepend('B')
p test

test.prepend('C')
p test