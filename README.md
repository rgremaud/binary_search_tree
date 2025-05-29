Building a binary search tree!

Algorithm to build from
1 - First initialize a queue with root node (which the mid of initial array) and two variables. Lets say start and end which will describe the range of the root (set to 0 and n-1 for root node). Loop until the queue is empty.

2 - Remove first node from the queue along with its start and end range and find middle index of the range. Elements present in the range [start, middle-1] will be present in its left subtree and elements in the range [middle+1, end] will be present in the right subtree.

3 - If left subtree exists, that is, if start is less than middle index. Then create the left node with the value equal to middle of range [start, middle-1]. Link the root node and left node and push the left node along withrange into the queue.

4 - If right subtree exists, that is, if end is greater than middle index. Then create the right node with the value equal to middle of range [middle+1, end]. Link the root node and right node and push the right node along range into the queue.

5 - Return the root node.

Ex array
[1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

sorted array = [1,3,4,5,7,8,9,23,67,324,6345] - length 11
root = (11-1)/2 = 5th item = 8
left_array = [1,3,4,5,7]
    root = 4                                                                                
    left_array = [1,3]                          4
        left_array = [1]                       3  7
        right_array = [3]                     1    5
    right_array = [5,7]
        left_array = [5]
        right_array = [7]



right_array = [9,23,67,324,6345]
        root = 67                                 67
        left_array = [9,23]                   23    6345
            left_array = [9]                 9     324
            right_array = [23]
        right_array = [324,6345]
            left_array = [324]
            right_array = [6345]

[1,3,4,5,7,8,9,23,67,324,6345]
root = 8
insert(500)
                  8
               /      \
              4       67
             / \     /    \
            3   7   23    6345
          /    /    /     /
        1      5   9     324
                           \
                            500

    Example removing 67 - current_node = 67
                            previous_node = 8
      current_node = current_node.right_child current_node = 6345
      current_node = current_node.left_child until current_node.left_child.left_child.nil?
      current_node.left_child = if current_node.left_child.value > previous_node.value
                                  previous_node.right_child
                                else
                                  previous_node.left_child
                                end
      current_node.left_child = nil
    end
    p previous_node.right_child.value