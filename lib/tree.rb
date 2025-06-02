# frozen_string_literal: true

# Tree class to build a binary search tree provided an array.
class Tree
  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree
    sorted_array = @array.sort.uniq
    n = sorted_array.length
    mid = (n - 1) / 2

    @root = Node.new(sorted_array[mid]) if @root.nil?

    left_half = sorted_array[0..mid - 1]
    right_half = sorted_array[mid + 1..n - 1]

    current_node = @root
    array_split(left_half, current_node)
    array_split(right_half, current_node)
  end

  def array_split(array, node)
    n = array.length
    current_node = node
    if n == 1
      mid_value = array[0]
      if mid_value > current_node.value
        current_node.right = Node.new(mid_value)
      else
        current_node.left = Node.new(mid_value)
      end
      return
    end
    return nil if n.zero?

    if n == 2
      mid = 1
      mid_value = array[1]
    else
      mid = (n - 1) / 2
      mid_value = array[mid]
    end

    if mid_value > current_node.value
      current_node.right = Node.new(mid_value)
      current_node = current_node.right
    else
      current_node.left = Node.new(mid_value)
      current_node = current_node.left
    end

    left_half = array[0..mid - 1]
    right_half = array[mid + 1..n - 1]
    array_split(left_half, current_node)
    array_split(right_half, current_node)
  end

  def insert(value)
    return puts 'That value exists already' if @array.include?(value)

    if @root.nil?
      @root = Node.new(value)
    else
      current_node = @root
      previous_node = @root
      until current_node.nil?
        previous_node = current_node
        current_node = if value > current_node.value
                         current_node.right
                       else
                         current_node.left
                       end
      end
      if value < previous_node.value
        previous_node.left = Node.new(value)
      else
        previous_node.right = Node.new(value)
      end
    end
  end

  def delete(value)
    puts 'That value does not exist' if @array.include?(value) == false

    current_node = find(value)
    parent_node = find_parent(current_node)

    if current_node.left.nil? && current_node.right.nil?
      delete_leaf(current_node, parent_node)
    elsif current_node.left.nil? || current_node.right.nil?
      delete_one_child(current_node, parent_node)
    else
      delete_two_children(current_node)
    end
  end

  def delete_leaf(current_node, parent_node)
    if current_node.value < parent_node.value
      parent_node.left = nil
    else
      parent_node.right = nil
    end
  end

  def delete_one_child(current_node, previous_node)
    if current_node == previous_node.left
      previous_node.left = if !current_node.left.nil?
                             current_node.left
                           else
                             current_node.right
                           end
    else
      previous_node.right = if !current_node.left.nil?
                              current_node.left
                            else
                              current_node.right
                            end
    end
  end

  def delete_two_children(current_node)
    repl_node = find_replacement(current_node)
    repl_parent = find_parent(repl_node)
    current_node.value = repl_node.value
    repl_parent.left = nil
  end

  def find_replacement(current_node)
    current_node = current_node.right
    current_node = current_node.left until current_node.left.nil?
    replacement_node = current_node
    current_node.left = nil
    replacement_node
  end

  def find_parent(node)
    return nil if find(node.value) == false

    current_node = @root
    previous_node = nil
    until current_node.value == node.value
      previous_node = current_node
      current_node = if node.value > current_node.value
                       current_node.right
                     else
                       current_node.left
                     end
    end
    previous_node
  end

  def find(value)
    current_node = @root
    until current_node.nil?
      if value == current_node.value
        return current_node
      elsif value < current_node.value
        current_node = current_node.left
      else
        current_node = current_node.right
      end
    end
  end

  def level_order
    values = []
    queue = [@root]
    until queue.empty?
      block_given? ? yield(queue[0]) : values << queue[0].value
      queue << queue[0].left unless queue[0].left.nil?
      queue << queue[0].right unless queue[0].right.nil?
      queue.shift(1)
    end
    values unless block_given?
  end

  def inorder(node = @root, values = [], &block)
    return if node.nil?

    yield node if block_given?
    inorder(node.left, values)
    values << node.value
    inorder(node.right, values)
    values unless block_given?
  end

  def preorder(node = @root, values = [], &block)
    return if node.nil?

    yield node if block_given?
    values << node.value
    preorder(node.left, values)
    preorder(node.right, values)
    values unless block_given?
  end

  def postorder(node = @root, values = [], &block)
    return if node.nil?

    yield node if block_given?
    postorder(node.left, values)
    postorder(node.right, values)
    values << node.value
    values unless block_given?
  end

  def find_value(value) # doesn't work -
    preorder { |node| return node if node == value }
  end

  def height(value)
    # Write a #height method that accepts a value and returns the height of the node
    # containing that value. Height is defined as the number of edges in the longest path
    # from that node to a leaf node. If the value is not found in the tree, the method should return nil.
    height = 0
    p current_node = find(value)
    # if value is not found, return nil
    # if node is leaf (no children), height is 0
    # recursively calculate height of left subtree from value
    # recusrively calculate height of right subtree from value
  end

  def depth(value, node = @root, depth = -1) # doesnt work
    return -1 if @root.nil?

    depth += 1
    return depth if node.value == value

    depth(value, node.left, depth)
    depth(value, node.right, depth)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
