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
    p @root
  end

  def array_split(array, node)
    n = array.length
    return nil if n <= 1

    if n == 2
      mid = 1
      mid_value = array[1]
    else
      mid = (n - 1) / 2 # mid = (2-1)/2 = 0
      mid_value = array[mid]
    end
    current_node = node # current_node = 4
    if mid_value > current_node.value
      current_node.right_child = Node.new(mid_value)
      current_node = current_node.right_child
    else
      current_node.left_child = Node.new(mid_value)
      current_node = current_node.left_child
    end

    left_half = array[0..mid - 1]
    right_half = array[mid + 1..n - 1]
    array_split(left_half, current_node)
    array_split(right_half, current_node)
  end

  def print_left_values
    current_node = @root
    p current_node.value
    p current_node.left_child.value
    p current_node.left_child.right_child.value
    p current_node.left_child.left_child.left_child
  end
end
