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
    nil if n.zero?
    mid = (n - 1) / 2

    # Set The middle element of the array as root.
    @root = Node.new(sorted_array[mid])

    # Recursively do the same for the left half and right half.
    left_half = sorted_array[0..mid - 1]
    right_half = sorted_array[mid + 1..n - 1]

    # Get the middle of the left half and make it the left child of the root created in step 1.
    # Get the middle of the right half and make it the right child of the root created in step 1.
    # Print the preorder of the tree.
  end

  def divide_array(array)
  end
end
