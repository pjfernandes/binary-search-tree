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

  def insert(value, node = @root)
    return nil if value == node.data
    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    else
      if node.right.nil?
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end

  def find(value, node = @root)
    return node if node.nil? || node.data == value
    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def min_value_node(node)
    current = node
    while !current.left.nil?
      current = current.left
    end
    current
  end

  def delete(value, node = @root)
    return node if node.nil? #base case

    if value < node.data
      node.left = delete(value, node.left)

    elsif value > node.data
      node.right = delete(value, node.right)

    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      temp = min_value_node(node.right)
      node.data = temp.data
      node.right = delete(node.right, temp.data)
    end
  end

  def level_order(node = @root, array = [])
    print "#{node.data} -> "
    array << node.left unless node.left.nil?
    array << node.right unless node.right.nil?
    return if array.empty?
    level_order(array.shift, array)
  end

  def preorder(node = @root)
    print "#{node.data} -> "
    preorder(node.left) unless node.left.nil?
    preorder(node.right) unless node.right.nil?
  end

  def inorder(node = @root)
    inorder(node.left) unless node.left.nil?
    print "#{node.data} -> "
    inorder(node.right) unless node.right.nil?
  end

  def postorder(node = @root)
    postorder(node.left) unless node.left.nil?
    postorder(node.right) unless node.right.nil?
    print "#{node.data} -> "
  end

  def height(node = @root, edges = 0)
    return edges if node.nil?
    edges += 1
    left = height(node.left, edges)
    right = height(node.right, edges)

    return [left, right].max
  end



  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

t = Tree.new([50, 30, 20, 40, 70, 60, 80])
