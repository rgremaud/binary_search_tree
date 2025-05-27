class Tree
  # Build a Tree class which accepts an array when initialized.
  # The Tree class should have a root attribute, which uses the return value of #build_tree which you’ll write next.
  #
  # Psuedocode
  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree
    sorted_array = @array.sort.uniq
    n = sorted_array.length
    return nil if n.zero?

    # Initialize a queue w/root node as middle of initial array
    mid = (n - 1) / 2
    p sorted_array
    p mid

    @root = Node.new(sorted_array[mid])
    p @root
    sorted_array.delete_at(mid)
    p sorted_array
    # iterate over the full sorted_array with each
    # set a current_node and previous_node
    # initial value is @root for both since you start at the top
    # keep iterating unless value of current node is nil
    # take value from array, if greater than root go right_child
    #                      , if less than root go left_child
    # create a new node for the item if you reach the end of the tree
    #        or if value < previous_node and value > current_node
    # tree is build once all items are iterated and converted to nodes
  end
end
