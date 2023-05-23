class Node 
  attr_accessor :data, :left, :right

  def initialize(data=nil, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end

end

class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

   # Debugging function from TOP discord
   def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end 

  # Builds a balanced tree from a sorted, unique array using recursion
  def build_tree(array)
    return nil if array.empty?

    middle = (array.size - 1) / 2
    root_node = Node.new(array[middle])

    root_node.left = build_tree(array[0...middle])
    root_node.right = build_tree(array[(middle + 1)..-1])

    root_node
  end

  # Adds a value by transversing down binary tree until correct position with recursion
  def insert(value, node=root)
    return nil if value == node.data

    if value < node.data
      if node.left == nil
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    else
      if node.right == nil
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end

  # Deletes a value on the binary tree if it exists with recursion
  def delete(value, node=root)
    return nil if node == nil

    if value < node.data
        node.left = delete(value, node.left)
    elsif value > node.data 
        node.right = delete(value, node.right)
    else
      # If the target node has only 1 or no children
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # If the target node has 2 children
      # Assign right node as new root and traverse left until nil
      new_root = node.right 
      until new_root.left == nil
        new_root = new_root.left
      end 

      # Assign new root and delete old root
      node.data = new_root.data 
      node.right = delete(new_root.data, node.right)
    end

    # Return node
    node
  end

  # Finds the node with the given value, returns nil if node does not exist
  def find(value, node=root)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  # Traverses the tree in breadth-first level order and yield each node to the provided block, returns an array if no blocks given
  def level_order(node=root, queue=[])
    return nil if node == nil
    
    output = []
    queue << node

    # Continues until queue is empty
    until queue.empty?
      # Points to the first node in queue and shifts queue down by 1
      cursor = queue.shift

      # Yield current node if block given, or push node.data to output
      output << block_given? ? yield(cursor) : cursor.data

      # Push left and right node to queue if it exists
      queue << cursor.left if cursor.left
      queue << cursor.right if cursor.right
    end

    output
  end

  # Inorder, preorder, and postorder takes a block as a proc via &block, and returns output as an array if no block given 
  def inorder(node=root, output=[], &block)
    return nil if node == nil

    inorder(node.left, output, &block) if node.left
    block.nil? ? output << node.data : output << block.call(node)
    inorder(node.right, output, &block) if node.right

    output
  end

  def preorder(node=root, output=[], &block)
    return nil if node == nil

    block.nil? ? output << node.data : output << block.call(node)
    inorder(node.left, output, &block) if node.left
    inorder(node.right, output, &block) if node.right

    output
  end

  def postorder(node=root, output=[], &block)
    return nil if node == nil

    inorder(node.left, output, &block) if node.left
    inorder(node.right, output, &block) if node.right
    block.nil? ? output << node.data : output << block.call(node)

    output
  end

  # Accepts a node and returns its height
  def height(node=root, node_height=-1)
    return node_height if node == nil

    node_height += 1

    # Returns the highest value of traversing left or right to leaf
    [height(node.left, node_height), height(node.right, node_height)].max
  end

  def depth(target_node)
    return nil if target_node == nil
    count = 0
    cursor = root

    until cursor.data == target_node.data
      count += 1
      cursor = cursor.left if target_node.data < cursor.data
      cursor = cursor.right if target_node.data > cursor.data
    end

    count
  end

  # Checks if the tree is balanced where diff between left and right subtree height is less than 1
  def balanced?(node=root)
    left_subtree = height(node.left) 
    right_subtree = height(node.right)
    (left_subtree - right_subtree).between?(-1, 1)
  end


  # Balances a tree using in order traversal 
  def rebalance
    values = inorder()
    @root = build_tree(values)
  end
end


test_array =(Array.new(15) { rand(1..100) })

test = Tree.new(test_array)

test.pretty_print
# search = test.find(6345)
# puts search.data if search != nil
# test.level_order() {|node| puts 100 + node.data}

# p test.inorder()
# p test.preorder() 
# p test.postorder()
# puts test.depth(test.find(6345))
puts test.balanced?
p test.inorder()
p test.preorder() 
p test.postorder()


test.insert(123)
test.insert(12312)
test.insert(444)
test.insert(4536)

test.pretty_print

puts test.balanced?

test.rebalance
test.pretty_print

puts test.balanced?
p test.inorder()
p test.preorder() 
p test.postorder()

