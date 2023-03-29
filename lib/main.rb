require 'pry-byebug'
require_relative 'merge-sort.rb'
require_relative 'node.rb' 
require_relative 'tree.rb'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

sorted_arr = merge_sort(arr).uniq
def max(a, b)
  if a > b
    a
  else
    b
  end
end


tree = Tree.new(sorted_arr)

tree.pretty_print

tree.insert(35)
tree.insert(42)
tree.insert(2)
tree.insert(12)
tree.insert(112)

tree.pretty_print


p tree.balanced?

tree.rebalance

tree.pretty_print

