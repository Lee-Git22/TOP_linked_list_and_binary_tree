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

      # Assign new root and delete duplicate root
      node.data = new_root.data 
      node.right = delete(new_root.data, node.right)
    end

    # Return node
    node
  end

end

test_array = [1, 7, 4, 23, 8, 3, 5, 9, 67, 6345, 324]

test = Tree.new(test_array)
test.pretty_print
test.delete(67)
test.pretty_print
