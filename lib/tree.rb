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

  def print_values
    current_node = @root
    p current_node.value
    p current_node.right.value
    p current_node.right.right.value
    p current_node.right.right.left.value
    p current_node.right.right.left.right.value
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
    current_node = @root
    previous_node = @root

    until current_node.value == value
      previous_node = current_node
      current_node = if value < current_node.value
                       current_node.left
                     else
                       current_node.right
                     end
    end

    if current_node.left.nil? && current_node.right.nil?
      delete_leaf(current_node, previous_node)
    elsif current_node.left.nil? || current_node.right.nil?
      delete_one_child(current_node, previous_node)
    else
      delete_two_children(current_node)
    end
  end

  def delete_leaf(current_node, previous_node)
    if current_node.value < previous_node.value
      previous_node.left = nil
    else
      previous_node.right = nil
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
    return nil if @array.include?(node.value) == false

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
    p previous_node
  end

  def find(value)
    current_node = @root
    until current_node.nil?
      if value == current_node.value
        return puts current_node
      elsif value < current_node.value
        current_node = current_node.left
      else
        current_node = current_node.right
      end
    end
  end

  def level_order # does not work
    values_array = []
    queue_array = []
    current_node = @root
    # block_given? ? yield(node) : result << node.data
    # result unless block_given?
    # Enqueue the root node.
    queue_array << current_node
    # until queue_array.empty?
    values_array << queue_array[0].value
    queue_array << queue_array[0].left unless queue_array[0].left.nil?
    queue_array << queue_array[0].right unless queue_array[0].right.nil?
    queue_array.drop(1)

    queue_array.drop(1)
    queue_array.drop(1)
    p queue_array.length
    # Visit the node by adding its value to the value_array,
    # and then adding its left and right child (if exist) to the queue
    # continue to visit the first node in queue, add it to values_array, add its children, remove
    # While the queue is not empty then dequeue the node and visit it.
    # Enqueue its the left child(if its exists)
    # Enqueue its the right child(if its exists)
    # Repeat the steps 2-4 until the queue is empty
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
