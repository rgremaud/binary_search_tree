# frozen_string_literal: true

# Nodes for creating a binary search tree
class Node
  attr_accessor :value, :left_child, :right_child

  # Build a Node class. It should have an attribute for the data it stores as well as its left and right children.
  # As a bonus, try including the Comparable module and compare nodes using their data attribute.
  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end
end
