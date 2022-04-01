class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end
########################
class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.uniq.sort
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.empty?
    mid = array.size/2
    root = Node.new(array[mid])
    root.left = build_tree(array.slice(0,mid))
    root.right = build_tree(array.slice(mid + 1, array.size - 1))
    root
  end

  def insert(value, node = root)
    return nil if value == node.data
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end


end
