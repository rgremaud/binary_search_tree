Building a binary search tree!

Algorithm to build from
1 - First initialize a queue with root node (which the mid of initial array) and two variables. Lets say start and end which will describe the range of the root (set to 0 and n-1 for root node). Loop until the queue is empty.

2 - Remove first node from the queue along with its start and end range and find middle index of the range. Elements present in the range [start, middle-1] will be present in its left subtree and elements in the range [middle+1, end] will be present in the right subtree.

3 - If left subtree exists, that is, if start is less than middle index. Then create the left node with the value equal to middle of range [start, middle-1]. Link the root node and left node and push the left node along withrange into the queue.

4 - If right subtree exists, that is, if end is greater than middle index. Then create the right node with the value equal to middle of range [middle+1, end]. Link the root node and right node and push the right node along range into the queue.

5 - Return the root node.