# frozen_string_literal: true

require_relative 'lib/tree'
require_relative 'lib/node'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

# expected post order answer 324 9 6345 23 67 8 5 7 4 3 1
# expected in order = 1 3 4 5 7 8 9 23 67 324 6345
tree.build_tree
tree.pretty_print
p tree.depth(4)
