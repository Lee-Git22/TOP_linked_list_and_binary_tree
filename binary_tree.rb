class Node 
  attr_accessor :value, :left, :right

  def initialize(value=nil, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end

end

class Tree
  attr_accessor :root

  def initialize(root=nil)
    @root = root
  end

  def build_tree(array)
    
  end
end