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
        current_node.right_child = Node.new(mid_value)
      else
        current_node.left_child = Node.new(mid_value)
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

  def print_values
    current_node = @root
    p current_node.value
    p current_node.right_child.value
    p current_node.right_child.right_child.value
    p current_node.right_child.right_child.left_child.value
    p current_node.right_child.right_child.left_child.right_child.value
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
                         current_node.right_child
                       else
                         current_node.left_child
                       end
      end
      if value < previous_node.value
        previous_node.left_child = Node.new(value)
      else
        previous_node.right_child = Node.new(value)
      end
    end
  end

  def delete(value) # rewrite so each scenario calls a method for that options
    puts 'That value does not exist' if @array.include?(value) == false
    current_node = @root
    previous_node = @root

    until current_node.value == value
      previous_node = current_node
      current_node = if value < current_node.value
                       current_node.left_child
                     else
                       current_node.right_child
                     end
    end

    p previous_node.right_child.value
    if current_node.left_child.nil? && current_node.right_child.nil? && current_node.value < previous_node.value
      previous_node.left_child = nil
    elsif current_node.left_child.nil? && current_node.right_child.nil? && current_node.value > previous_node.value
      previous_node.right_child = nil
    elsif current_node.left_child.nil? && !current_node.right_child.nil?
      previous_node.right_child = current_node.right_child
    elsif !current_node.left_child.nil? && current_node.right_child.nil?
      previous_node.left_child = current_node.left_child
    elsif !current_node.left_child.nil? && !current_node.right_child.nil?
      # find the next larger number from deleted node
      current_node = current_node.right_child
      # iterate to the right until you reach the furthest left item
      until current_node.left_child.nil?
        current_node = current_node.left_child
        p "End result is #{current_node.value}"
      end

    end
    p previous_node.right_child.value
  end

  def find(value)
    current_node = @root
    until current_node.nil?
      if value == current_node.value
        return puts current_node
      elsif value < current_node.value
        current_node = current_node.left_child
      else
        current_node = current_node.right_child
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
